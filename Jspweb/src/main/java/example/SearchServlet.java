package example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String query = request.getParameter("q");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/green_market", "root", "Dhanya@2005");

            // ✅ include category also
            PreparedStatement ps = con.prepareStatement(
                "SELECT name, price, category FROM products WHERE name LIKE ?"
            );
            ps.setString(1, "%" + query + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                String category = rs.getString("category");

                
                String targetPage = "#";
                if (category.equalsIgnoreCase("Vegetables")) {
                    targetPage = "Vegetables.jsp";
                } else if (category.equalsIgnoreCase("Furniture")) {
                    targetPage = "Furniture.jsp";
                } else if (category.equalsIgnoreCase("Cooking")) {
                    targetPage = "Cooking.jsp";
                } else if (category.equalsIgnoreCase("Snacks")) {
                    targetPage = "Snacks.jsp";
                } else if (category.equalsIgnoreCase("Dresses")) {
                    targetPage = "Dresses.jsp";
                } else if (category.equalsIgnoreCase("Food")) {
                    targetPage = "Food.jsp";
                }

                
                out.println("<div class='item'>"
                        + "<a href='" + targetPage + "' style='text-decoration:none; color:#2d572c;'>"
                        + name + " - Rs." + price
                        + "</a></div>");
            }

            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
}
