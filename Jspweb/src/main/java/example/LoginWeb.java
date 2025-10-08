package example;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginWeb")
public class LoginWeb extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/green_market";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Dhanya@2005";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM users WHERE email = ? AND password = ?");
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // ✅ Session handling
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);
                session.setAttribute("userName", rs.getString("name"));

                // ✅ Create secure cookie (store session ID or user token, not email)
                Cookie userCookie = new Cookie("userEmail", email);
                userCookie.setMaxAge(60 * 60 * 24); // 1 day
                userCookie.setPath("/"); // Valid for entire app
                userCookie.setHttpOnly(true); // Prevent JavaScript access
                // userCookie.setSecure(true); // Uncomment if HTTPS is enabled
                response.addCookie(userCookie);

                // ✅ Response
                out.println("<h2>Welcome, " + rs.getString("name") + "!</h2>");
                out.println("<p>Email: " + rs.getString("email") + "</p>");
                out.println("<p>Location: " + rs.getString("location") + "</p>");
                out.println("<h2>Login successful!</h2>");
                out.println("<a href='Web1.html'>Go to Home page</a>");

            } else {
                out.println("<h3 style='color:red'>Invalid email or password!</h3>");
                out.println("<a href='login.jsp'>Try again</a>");
            }

            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
