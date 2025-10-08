<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Place Your Order</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f2f2f2; padding: 30px; }
        form { background: white; padding: 20px; width: 400px; margin: auto; border-radius: 8px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        h2 { text-align: center; color: #28a745; }
        label { font-weight: bold; }
        input, textarea { width: 100%; margin-bottom: 15px; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        input[type="submit"] { background: #28a745; color: white; border: none; cursor: pointer; }
        input[type="submit"]:hover { background: #218838; }
    </style>
</head>
<body>
    <h2>Order Details</h2>
    <form action="OrderServlet" method="post">
        <label>Name:</label>
        <input type="text" name="name" required><br><br>

        <label>Phone:</label>
        <input type="text" name="phone" required><br><br>

        <label>Address:</label>
        <textarea name="address" required></textarea><br><br>

        <!-- Hidden product details -->
        <input type="hidden" name="productId" value="<%= request.getParameter("productId") %>">
        <input type="hidden" name="quantity" value="<%= request.getParameter("quantity") %>">
        <input type="hidden" name="price" value="<%= request.getParameter("price") %>">
        <input type="hidden" name="productName" value="<%= request.getParameter("productName") %>">
        <input type="hidden" name="productType" value="<%= request.getParameter("productType") %>">

        <input type="submit" value="Confirm Order">
    </form>
</body>
</html>
