<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>LOGIN PAGE</title>
   <style>
    /* same styling as before */
    body {
      background-image: url('Vegetables.png');
      background-repeat: no-repeat;
      background-attachment: fixed;
      background-size: cover;
      background-position: center;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .form-container {
      width: 27%;
      background-color: rgba(255, 255, 255, 0.85);
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
    }
    h2 {
      text-align: center;
    }
    .dynamic-content {
      text-align: center;
      color: #2e7d32;
      font-weight: bold;
      margin-bottom: 20px;
      min-height: 20px;
      font-size: 16px;
      animation: fadeIn 1s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to   { opacity: 1; }
    }
    form input[type="text"],
    form input[type="password"] {
      width: 100%;
      padding: 8px;
      margin-bottom: 15px;
      border-radius: 5px;
    }
    form input[type="submit"] {
      width: 100%;
      padding: 10px;
      background-color: #0f2d16;
      color: white;
      border: none;
      border-radius: 5px;
    }
    .signup-link {
      text-align: center;
      margin-top: 15px;
    }
    .signup-link a {
      color: #2e7d32;
      text-decoration: none;
    }
  </style>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="form-container">
    <h2>LOGIN</h2>
    <form action="LoginWeb" method="post">
      Email: <input type="text" name="email" required><br>
      Password: <input type="password" name="password" required><br>
      <input type="submit" value="Login">
    </form>
    <div style="text-align:center;margin-top:10px">Don't have an account? <a href="sign.jsp">Sign up</a></div>
  </div>
</body>
</html>