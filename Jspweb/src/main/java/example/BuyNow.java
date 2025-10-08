package example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/BuyNow")
public class BuyNow extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userEmail = request.getParameter("userEmail");
        String jdbcURL = "jdbc:mysql://localhost:3306/green_market";
        String jdbcUser = "root";
        String jdbcPass = "Dhanya@2005";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);

            // Move items from cart to orders table
            String insertSQL = "INSERT INTO orders (user_email, product_id, quantity, order_date) " +
                               "SELECT user_email, product_id, quantity, NOW() FROM cart WHERE user_email=?";
            PreparedStatement ps = conn.prepareStatement(insertSQL);
            ps.setString(1, userEmail);
            ps.executeUpdate();

            // Clear the cart
            String deleteSQL = "DELETE FROM cart WHERE user_email=?";
            PreparedStatement ps2 = conn.prepareStatement(deleteSQL);
            ps2.setString(1, userEmail);
            ps2.executeUpdate();

            conn.close();

            response.getWriter().println("<script>alert('Order placed successfully!'); window.location='order.jsp';</script>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error placing order!'); window.location='viewcart.jsp';</script>");
        }
    }
}
