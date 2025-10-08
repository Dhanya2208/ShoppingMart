package example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.getWriter().println("Order servlet working!");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String pidStr = request.getParameter("productId");
        String qtyStr = request.getParameter("quantity");
        String priceStr = request.getParameter("price");
        String productName = request.getParameter("productName");
        String productType = request.getParameter("productType");

        // ✅ Get logged-in user email from cookie
        String userEmail = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    userEmail = cookie.getValue();
                    break;
                }
            }
        }

        if (userEmail == null || userEmail.trim().isEmpty()) {
            out.println("<script>alert('Please log in first!'); window.location='login.jsp';</script>");
            return;
        }

        try {
            if (name == null || name.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                address == null || address.trim().isEmpty()) {
                out.println("<script>alert('Please fill all fields.'); history.back();</script>");
                return;
            }

            if (pidStr == null || qtyStr == null || priceStr == null || productName == null || productType == null) {
                out.println("Error: Missing product details.");
                return;
            }

            int productId = Integer.parseInt(pidStr);
            int quantity = Integer.parseInt(qtyStr);
            double price = Double.parseDouble(priceStr);
            double totalPrice = price * quantity;

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/green_market", "root", "Dhanya@2005")) {

                String sql = "INSERT INTO orders (user_email, name, phone, address, product_id, product_name, product_type, quantity, total_price) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, userEmail);
                    ps.setString(2, name);
                    ps.setString(3, phone);
                    ps.setString(4, address);
                    ps.setInt(5, productId);
                    ps.setString(6, productName);
                    ps.setString(7, productType);
                    ps.setInt(8, quantity);
                    ps.setDouble(9, totalPrice);

                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        out.println("<script>alert('Order Successful'); window.location='Web1.html';</script>");
                    } else {
                        out.println("<script>alert('Order failed. Try again.'); window.location='Web1.jsp';</script>");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
