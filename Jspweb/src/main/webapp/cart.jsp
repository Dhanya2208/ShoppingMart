<%@ page import="java.util.*,java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>Your Cart</title>
  <link rel="stylesheet" href="../css/style.css">
</head>
<body>
  <h2 style="text-align:center;margin-top:20px">Shopping Cart</h2>
  <%
    Map<Integer,Integer> cart = (Map<Integer,Integer>) session.getAttribute("cart");
    if(cart==null || cart.isEmpty()){
      out.println("<p style='text-align:center'>Your cart is empty. <a href='vegetables.jsp'>Shop now</a></p>");
    } else {
  %>
  <form action="../CartUpdateServlet" method="post">
    <table class="cart-table">
      <tr><th>Item</th><th>Qty</th><th>Price</th><th>Subtotal</th></tr>
      <%
        double total=0;
        String jdbcUrl = "jdbc:mysql://localhost:3306/green_market";
        String dbUser = "root";
        String dbPass = "Dhanya@2005";
        try{
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection con = DriverManager.getConnection(jdbcUrl,dbUser,dbPass);
          for(Map.Entry<Integer,Integer> e : cart.entrySet()){
            int pid = e.getKey(); int qty = e.getValue();
            PreparedStatement ps = con.prepareStatement("SELECT name,price FROM products WHERE id=?");
            ps.setInt(1,pid);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
              double price = rs.getDouble("price");
              double sub = price*qty; total+=sub;
      %>
      <tr>
        <td><%=rs.getString("name")%></td>
        <td><input type="number" name="qty_<%=pid%>" value="<%=qty%>" min="0" style="width:60px"></td>
        <td>₹<%=price%></td>
        <td>₹<%=sub%></td>
      </tr>
      <%    }
            rs.close(); ps.close();
          }
          con.close();
        }catch(Exception ex){ out.println("<tr><td colspan='4' style='color:red'>"+ex.getMessage()+"</td></tr>"); }
      %>
      <tr class="total-row"><td colspan="3">Total</td><td>₹<%=total%></td></tr>
    </table>
    <div style="text-align:center;margin-top:10px">
      <input type="submit" value="Update Cart">
      <a href="checkout.jsp" class="add-btn">Proceed to Checkout</a>
    </div>
  </form>
  <% } %>
</body>
</html>