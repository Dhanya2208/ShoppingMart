<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%
    HttpSession session2 = request.getSession();
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail == null) {
        out.println("<script>alert('Please login first!'); window.location='login.jsp';</script>");
        return;
    }

    String jdbcURL = "jdbc:mysql://localhost:3306/green_market";
    String jdbcUser = "root";
    String jdbcPass = "Dhanya@2005";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);

    String sql = "SELECT c.id, p.id as product_id, p.name, p.category, p.price, " +
                 "c.quantity, (p.price * c.quantity) as total_price " +
                 "FROM cart c JOIN products p ON c.product_id = p.id " +
                 "WHERE c.user_email = ?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, userEmail);
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        table { width: 80%; margin: auto; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background: #27ae60; color: white; }
        .remove-btn {
            background: #e74c3c; color: white; padding: 5px 10px;
            border: none; cursor: pointer;
        }
        .remove-btn:hover { background: #c0392b; }
        .buy-btn, .home-btn {
            display: inline-block;
            margin: 20px 10px;
            background: #2980b9;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            text-decoration: none;
        }
        .buy-btn:hover, .home-btn:hover { background: #1c5980; }
        .top-nav {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">Your Cart</h2>

<!-- ✅ Home button added -->
<div class="top-nav">
    <a href="Web1.html" class="home-btn">Home</a>
</div>

<table>
    <tr>
        <th>Product Name</th>
        <th>Category</th>
        <th>Price (Rs.)</th>
        <th>Quantity</th>
        <th>Total Price</th>
        <th>Action</th>
    </tr>
    <%
        double grandTotal = 0;
        boolean hasItems = false;
        while (rs.next()) {
            hasItems = true;
            grandTotal += rs.getDouble("total_price");
    %>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("category") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getInt("quantity") %></td>
        <td><%= rs.getDouble("total_price") %></td>
        <td>
            <form action="RemoveItem" method="post">
                <input type="hidden" name="cartId" value="<%= rs.getInt("id") %>">
                <button class="remove-btn">Remove</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>

<% if (hasItems) { %>
    <h3 style="text-align:center;">Grand Total: Rs.<%= grandTotal %></h3>

    <!-- ✅ Buy Now button -->
    <form action="checkout.jsp" method="post" style="text-align:center;">
        <input type="hidden" name="userEmail" value="<%= userEmail %>">
        <button type="submit" class="buy-btn">Buy Now</button>
    </form>
<% } else { %>
    <h3 style="text-align:center; color:red;">Your cart is empty!</h3>
<% } %>

</body>
</html>
<%
    conn.close();
%>
