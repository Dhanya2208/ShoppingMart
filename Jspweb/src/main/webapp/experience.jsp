<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Share Your Shopping Experience</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f2f2f2; }
        .container { width: 40%; margin: auto; padding: 20px; background: white; border-radius: 10px; margin-top: 50px; }
        input, select, textarea { width: 100%; margin-bottom: 15px; padding: 10px; font-size: 16px; }
        button { background: #4CAF50; color: white; padding: 10px 20px; border: none; cursor: pointer; }
        button:hover { background: #45a049; }
    </style>
</head>
<body>
<div class="container">
    <h2>Share Your Shopping Experience</h2>
    <form action="submitFeedback.jsp" method="post">
        <input type="text" name="name" placeholder="Your Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="product" placeholder="Product (optional)">
        <select name="rating" required>
            <option value="1">1 - Poor</option>
            <option value="2">2 - Fair</option>
            <option value="3">3 - Good</option>
            <option value="4">4 - Very Good</option>
            <option value="5">5 - Excellent</option>
        </select>
        <textarea name="comment" placeholder="Suggestion / Comment" required></textarea>
        <button type="submit">Submit Feedback</button>
    </form>
    <p>
        <a href="viewFeedback.jsp">View Feedback Summary</a>
        <a href="Web1.html">Home</a>
    </p>
</div>
</body>
</html>
