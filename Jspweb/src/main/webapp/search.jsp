<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Search</title>
    <style>
        #results { border: 1px solid #ccc; max-width: 400px; margin-top: 10px; }
        .item { padding: 8px; cursor: pointer; }
        .item:hover { background: #f0f0f0; }
    </style>
    <script>
        function searchProducts() {
            let query = document.getElementById("searchBox").value;
            if (query.length === 0) {
                document.getElementById("results").innerHTML = "";
                return;
            }

            // AJAX request
            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("results").innerHTML = xhr.responseText;
                }
            };
            // Sending query to servlet
            xhr.open("GET", "SearchServlet?q=" + query, true);
            xhr.send();
        }
    </script>
</head>
<body>
    <h2>🔍 Search Products</h2>
    <input type="text" id="searchBox" onkeyup="searchProducts()" placeholder="Type product name...">
    <div id="results"></div>
</body>
</html>
