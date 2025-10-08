package example;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/green_market";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Dhanya@2005";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Check if user already exists
            PreparedStatement checkStmt = conn.prepareStatement("SELECT email FROM users WHERE email=?");
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                out.println("<h3 style='color:red'>Email already registered!</h3>");
            } else {
                PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO users (name, email, password, phone, location) VALUES (?, ?, ?, ?, ?)");
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, password);
                stmt.setString(4, phone);
                stmt.setString(5, location);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    out.println("<h2>Signup successful!</h2>");
                    out.println("<a href='login.jsp'>Go to Login</a>");
                } else {
                    out.println("<h3 style='color:red'>Signup failed.</h3>");
                }

                stmt.close();
            }

            conn.close();
        } catch (Exception e) {
            out.println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
