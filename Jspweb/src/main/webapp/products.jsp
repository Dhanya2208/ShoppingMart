<%@ page import="java.sql.*" %>
<%
    String category = request.getParameter("category");
    if(category == null) category = "Vegetables";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmart", "root", "Dhanya@2005");
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM products WHERE category=?");
    stmt.setString(1, category);
    ResultSet rs = stmt.executeQuery();
%>
<html>
<head>
<title><%= category %> - ShoppingMart</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<h1><%= category %> Products</h1>

<div class="category-container">
<%
   while(rs.next()) {
%>
   <div class="category-item">
       <div class="category-img-container">
           <img src="<%= rs.getString("image_url") %>" width="150">
       </div>
       <div class="category-info">
           <h2><%= rs.getString("name") %></h2>
           <p><%= rs.getString("description") %></p>
           <p>Price: ₹<%= rs.getDouble("price") %></p>

           <form action="CartServlet" method="post">
               <input type="hidden" name="productId" value="<%= rs.getInt("id") %>">
               <input type="number" name="qty" value="1" min="1">
               <input type="submit" value="Add to Cart">
           </form>

           <form action="Checkout.jsp" method="post">
               <input type="hidden" name="productId" value="<%= rs.getInt("id") %>">
               <input type="hidden" name="qty" value="1">
               <input type="submit" value="Buy Now">
           </form>
       </div>
   </div>
<%
   }
   conn.close();
%>
</div>
</body>
</html>
