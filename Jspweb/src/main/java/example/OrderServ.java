package example;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

@WebServlet("/OrderServ")
public class OrderServ extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            out.println("<script>alert('Please login first!'); window.location='login.jsp';</script>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/green_market", "root", "Dhanya@2005")) {

                // ✅ Get all cart items for the user
                String getCartSQL = "SELECT c.id, p.id as product_id, p.name, p.category, p.price, c.quantity " +
                                    "FROM cart c JOIN products p ON c.product_id = p.id " +
                                    "WHERE c.user_email=?";
                PreparedStatement psCart = con.prepareStatement(getCartSQL);
                psCart.setString(1, userEmail);
                ResultSet rs = psCart.executeQuery();

                // ✅ Insert into orders (product_type column exists in orders, not products)
                String insertOrderSQL = "INSERT INTO orders (user_email, name, phone, address, product_id, product_name, product_type, quantity, total_price) " +
                                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement psOrder = con.prepareStatement(insertOrderSQL);

                boolean hasItems = false;
                while (rs.next()) {
                    hasItems = true;
                    int productId = rs.getInt("product_id");
                    String productName = rs.getString("name");
                    String productCategory = rs.getString("category"); // ✅ from products
                    int quantity = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    double totalPrice = price * quantity;

                    psOrder.setString(1, userEmail);
                    psOrder.setString(2, name);
                    psOrder.setString(3, phone);
                    psOrder.setString(4, address);
                    psOrder.setInt(5, productId);
                    psOrder.setString(6, productName);
                    psOrder.setString(7, productCategory);  // ✅ map category → product_type
                    psOrder.setInt(8, quantity);
                    psOrder.setDouble(9, totalPrice);
                    psOrder.addBatch();
                }

                if (hasItems) {
                    psOrder.executeBatch();

                    // ✅ Clear cart after order
                    String clearCartSQL = "DELETE FROM cart WHERE user_email=?";
                    PreparedStatement psClear = con.prepareStatement(clearCartSQL);
                    psClear.setString(1, userEmail);
                    psClear.executeUpdate();

                    out.println("<script>alert('Order placed successfully!'); window.location='Web1.html';</script>");
                } else {
                    out.println("<script>alert('Your cart is empty!'); window.location='Vegetables.jsp';</script>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
