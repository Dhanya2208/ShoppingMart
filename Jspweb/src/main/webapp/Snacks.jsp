<%@ page import="java.sql.*" %>
<%
  String jdbcURL = "jdbc:mysql://localhost:3306/green_market";
  String jdbcUser = "root";
  String jdbcPass = "Dhanya@2005";

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPass);

  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery("SELECT * FROM products WHERE category='Snacks'");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Snacks</title>
  <style>
      body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; padding: 20px; }
      .page-title { text-align: center; font-size: 2rem; margin-bottom: 20px; color: #2d572c; }
      .category-contain { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; max-width: 1000px; margin: 0 auto; }
      .category-it { background: #fff; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); overflow: hidden; text-align: center; padding: 15px; }
      .category-img-contain { width: 100%; height: 200px; overflow: hidden; display: flex; align-items: center; justify-content: center; margin-bottom: 10px; }
      .category-img-contain img { width: 100%; height: auto; object-fit: cover; }
      .category-info h2 { font-size: 1.4rem; margin: 10px 0; color: #333; }
      .price { font-size: 1.2rem; color: #27ae60; margin-bottom: 15px; }
      .action-form { margin: 5px 0; }
      .shop-btn { width: 100%; padding: 10px; font-size: 1rem; border: none; border-radius: 6px; cursor: pointer; color: #fff; font-weight: bold; transition: background 0.3s ease; }
      .buy-btn { background: #e67e22; }
      .buy-btn:hover { background: #cf711f; }
      .cart-btn { background: #27ae60; }
      .cart-btn:hover { background: #1f8f4b; }
  </style>
</head>
<body>
<div style="text-align:right; margin-bottom:20px; padding-top:20px;">
    <a href="viewCart.jsp" style="font-size:18px; text-decoration:none; color:#27ae60; font-weight:bold;">View Cart</a>
    <a href="Web1.html" style="font-size:18px; text-decoration:none; color:#27ae60; font-weight:bold; margin-left:20px;">Home</a>
</div>

<h1 class="page-title">Snacks Section</h1>

<div class="category-contain">
<%
  while(rs.next()) {
      int productId = rs.getInt("id");
      String productName = rs.getString("name");
      double price = rs.getDouble("price");
      String productType = rs.getString("category");
%>
    <div class="category-it">
        <div class="category-img-contain">
            <img src="<%= rs.getString("image_url") %>" alt="<%= productName %>">
        </div>
        <div class="category-info">
            <h2><%= productName %></h2>
            <p class="price">Rs.<%= price %></p>

            <!-- Buy Now -->
            <form action="orderForm.jsp" method="get" class="action-form">
                <input type="hidden" name="productId" value="<%= productId %>">
                <input type="hidden" name="quantity" value="1">
                <input type="hidden" name="price" value="<%= price %>">
                <input type="hidden" name="productName" value="<%= productName %>">
                <input type="hidden" name="productType" value="<%= productType %>">
                <button type="submit" class="shop-btn buy-btn">Buy Now</button>
            </form>

            <!-- Add to Cart -->
            <form action="CartServlet" method="post" class="action-form">
                <input type="hidden" name="productId" value="<%= productId %>">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="shop-btn cart-btn">Add to Cart</button>
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
