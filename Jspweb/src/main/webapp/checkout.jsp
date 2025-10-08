<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <style>
        body { font-family: Arial; text-align: center; padding: 20px; }
        input { padding: 10px; margin: 10px; width: 300px; }
        .submit-btn {
            background: #27ae60; color: white; padding: 10px 20px;
            border: none; cursor: pointer; font-size: 16px; border-radius: 5px;
        }
        .submit-btn:hover { background: #1e8449; }
    </style>
</head>
<body>
    <h2>Checkout</h2>
    <form action="OrderServ" method="post">
        <input type="hidden" name="userEmail" value="<%= request.getParameter("userEmail") %>">

        <input type="text" name="name" placeholder="Full Name" required><br>
        <input type="text" name="phone" placeholder="Phone Number" required><br>
        <input type="text" name="address" placeholder="Address" required><br>

        <button type="submit" class="submit-btn">Place Order</button>
    </form>
</body>
</html>
