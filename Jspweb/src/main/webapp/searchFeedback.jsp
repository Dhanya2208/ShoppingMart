<%@ page import="javax.xml.parsers.*, javax.xml.xpath.*, org.w3c.dom.*, java.io.*" %>
<%
    String ratingParam = request.getParameter("rating");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Feedbacks</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f9f9f9; }
        .container { width: 50%; margin: auto; padding: 20px; background: white; margin-top: 50px; border-radius: 10px; }
        input, button { padding: 10px; font-size: 16px; margin-top: 10px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #333; padding: 8px; }
        th { background: #4CAF50; color: white; }
    </style>
</head>
<body>
<div class="container">
    <h2>Search Feedback by Rating</h2>
    <form method="get">
        <label>Enter Minimum Rating:</label>
        <input type="number" name="rating" min="1" max="5" required>
        <button type="submit">Search</button>
    </form>
    <a href="Web1.html">Home</a>
<%
    if (ratingParam != null) {
        String xmlFile = application.getRealPath("/feedbacks.xml");
        File file = new File(xmlFile);

        if (file.exists()) {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(file);

            XPathFactory xPathFactory = XPathFactory.newInstance();
            XPath xPath = xPathFactory.newXPath();

            String expression = "/feedbacks/feedback[rating > " + ratingParam + "]";
            NodeList nodes = (NodeList) xPath.evaluate(expression, doc, XPathConstants.NODESET);

            if (nodes.getLength() > 0) {
%>
    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Product</th>
            <th>Rating</th>
            <th>Comment</th>
        </tr>
<%
                for (int i = 0; i < nodes.getLength(); i++) {
                    Element feedback = (Element) nodes.item(i);
%>
        <tr>
            <td><%= feedback.getElementsByTagName("name").item(0).getTextContent() %></td>
            <td><%= feedback.getElementsByTagName("email").item(0).getTextContent() %></td>
            <td><%= feedback.getElementsByTagName("product").item(0).getTextContent() %></td>
            <td><%= feedback.getElementsByTagName("rating").item(0).getTextContent() %></td>
            <td><%= feedback.getElementsByTagName("comment").item(0).getTextContent() %></td>
        </tr>
<%
                }
%>
    </table>
<%
            } else {
                out.println("<p>No feedbacks found with rating greater than " + ratingParam + ".</p>");
            }
        } else {
            out.println("<p>XML file not found.</p>");
        }
    }
%>
</div>
</body>
</html>
