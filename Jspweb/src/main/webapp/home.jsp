<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - ShoppingMart</title>
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: url('images/background.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }
        header {
            background: rgba(0, 0, 0, 0.7);
            color: #fff;
            padding: 15px;
            text-align: center;
            font-size: 24px;
            font-weight: 700;
        }
        .container {
            padding: 50px 20px;
            text-align: center;
            background: rgba(0, 0, 0, 0.6);
            max-width: 800px;
            margin: 80px auto;
            border-radius: 10px;
        }
        .container h1 {
            color: #ffcc00;
            font-size: 36px;
            margin-bottom: 20px;
        }
        .container p {
            color: #f1f1f1;
            font-size: 20px;
            line-height: 1.8;
            max-width: 600px;
            margin: auto;
            font-weight: 300;
        }
        .explore-btn {
            margin-top: 30px;
            padding: 14px 28px;
            background-color: #ffcc00;
            color: #333;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .explore-btn:hover {
            background-color: #ffdb4d;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<header>
    <h1>Welcome to ShoppingMart</h1>
</header>

<div class="container">
    <h1>About ShoppingMart</h1>
    <p>
        ShoppingMart is your one-stop online shopping destination where you can find a wide range
        of products from electronics, fashion, home appliances, and more. We aim to provide the best
        quality products at affordable prices with fast and secure delivery.
    </p>
    <form action="Web1.html">
        <button class="explore-btn" type="submit">Explore</button>
    </form>
</div>

</body>
</html>
