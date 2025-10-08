package example;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.sql.*;

@WebServlet("/CartActionServlet")
public class CartActionServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/shoppingmart";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Dhanya@2005";

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("userEmail");
        if (email == null) { res.sendRedirect("login.jsp"); return; }

        String action = req.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            if ("update".equals(action)) {
                int cartId = Integer.parseInt(req.getParameter("cartId"));
                int qty = Integer.parseInt(req.getParameter("qty"));
                PreparedStatement ps = conn.prepareStatement("UPDATE cart SET quantity=? WHERE id=?");
                ps.setInt(1, qty);
                ps.setInt(2, cartId);
                ps.executeUpdate();
                ps.close();

            } else if ("remove".equals(action)) {
                int cartId = Integer.parseInt(req.getParameter("cartId"));
                PreparedStatement ps = conn.prepareStatement("DELETE FROM cart WHERE id=?");
                ps.setInt(1, cartId);
                ps.executeUpdate();
                ps.close();

            } else if ("clear".equals(action)) {
                PreparedStatement ps = conn.prepareStatement("DELETE FROM cart WHERE user_email=?");
                ps.setString(1, email);
                ps.executeUpdate();
                ps.close();
            }

            conn.close();
            res.sendRedirect("viewCart.jsp");
        } catch (Exception e) {
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
