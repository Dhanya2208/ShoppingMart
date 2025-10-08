<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Search Feedbacks</title>
  <style>
    body { font-family: Arial, sans-serif; background:#f4f6f8; padding:30px; }
    .card{ max-width:800px; margin:auto; background:#fff; padding:18px; border-radius:8px; box-shadow:0 6px 18px rgba(0,0,0,0.06); }
    label{ font-weight:700; margin-top:8px; display:block;}
    input, select{ width:100%; padding:10px; margin-top:6px; border-radius:6px; border:1px solid #ccc; }
    .btn{ margin-top:12px; background:#2e7d32; color:#fff; padding:10px 14px; border:none; border-radius:6px; cursor:pointer; }
    table{ width:100%; margin-top:16px; border-collapse:collapse;}
    th,td{ border:1px solid #eee; padding:8px; text-align:left;}
  </style>
</head>
<body>
  <div class="card">
    <h2>Search Feedbacks (XPath)</h2>

    <form id="searchForm" action="<%= request.getContextPath() %>/SearchFeedbackServlet" method="get">
      <label for="minRating">Minimum Rating (leave empty if not used)</label>
      <input type="number" name="minRating" min="1" max="5">

      <label for="productName">Product name (exact match, optional)</label>
      <input type="text" name="productName">

      <label for="email">User email (optional)</label>
      <input type="email" name="userEmail">

      <button type="submit" class="btn">Search</button>
    </form>

    <p style="margin-top:12px; color:#555;">Examples:</p>
    <ul>
      <li>Ratings greater than 3 → set Minimum Rating = 4</li>
      <li>All feedbacks for product Tomato → Product name = Tomato</li>
    </ul>
  </div>
</body>
</html>
