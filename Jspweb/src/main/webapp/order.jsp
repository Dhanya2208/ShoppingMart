<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // Get user email from cookie
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
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #2c3e50;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #2ecc71;
            color: #fff;
        }
        tr:hover {
            background: #f1f1f1;
        }
        .no-orders {
            text-align: center;
            color: #e74c3c;
            font-size: 18px;
            margin-top: 20px;
        }
        .logout-btn {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
        .logout-btn a {
            background: #e74c3c;
            color: #fff;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 4px;
            transition: 0.3s;
        }
        .logout-btn a:hover {
            background: #c0392b;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        if (userEmail == null) {
    %>
        <p>Please log in first. <a href="login.jsp">Login</a></p>
    <%
        } else {
            out.println("<h2>Welcome " + userEmail + ", here are your orders:</h2>");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/green_market", "root", "Dhanya@2005");

                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM orders WHERE user_email = ?");
                stmt.setString(1, userEmail);

                ResultSet rs = stmt.executeQuery();
                if (!rs.isBeforeFirst()) {
    %>
                    <p class="no-orders">No orders found for you.</p>
    <%
                } else {
    %>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                            <th>Date</th>
                        </tr>
    <%
                    while (rs.next()) {
    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("product_name") %></td>
                            <td><%= rs.getInt("quantity") %></td>
                            <td>₹<%= rs.getBigDecimal("total_price") %></td>
                            <td><%= rs.getTimestamp("order_date") %></td>
                        </tr>
    <%
                    }
    %>
                    </table>
    <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
    <div class="logout-btn">
        <a href="Web1.html">Home</a>
    </div>
</div>
</body>
</html>
