<%@ page import="java.io.*, javax.xml.parsers.*, org.w3c.dom.*, javax.xml.transform.*, javax.xml.transform.dom.DOMSource, javax.xml.transform.stream.StreamResult" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String product = request.getParameter("product");
    String rating = request.getParameter("rating");
    String comment = request.getParameter("comment");

    String filePath = application.getRealPath("/feedbacks.xml");

    File xmlFile = new File(filePath);
    DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
    DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
    Document doc;

    if (xmlFile.exists()) {
        doc = dBuilder.parse(xmlFile);
    } else {
        doc = dBuilder.newDocument();
        Element rootElement = doc.createElement("feedbacks");
        doc.appendChild(rootElement);
    }

    Element root = doc.getDocumentElement();
    Element feedback = doc.createElement("feedback");

    Element nameEl = doc.createElement("name");
    nameEl.appendChild(doc.createTextNode(name));
    feedback.appendChild(nameEl);

    Element emailEl = doc.createElement("email");
    emailEl.appendChild(doc.createTextNode(email));
    feedback.appendChild(emailEl);

    Element productEl = doc.createElement("product");
    productEl.appendChild(doc.createTextNode(product));
    feedback.appendChild(productEl);

    Element ratingEl = doc.createElement("rating");
    ratingEl.appendChild(doc.createTextNode(rating));
    feedback.appendChild(ratingEl);

    Element commentEl = doc.createElement("comment");
    commentEl.appendChild(doc.createTextNode(comment));
    feedback.appendChild(commentEl);

    root.appendChild(feedback);

    TransformerFactory transformerFactory = TransformerFactory.newInstance();
    Transformer transformer = transformerFactory.newTransformer();
    DOMSource source = new DOMSource(doc);
    StreamResult result = new StreamResult(xmlFile);
    transformer.transform(source, result);

    out.println("<script>alert('Feedback submitted successfully!'); window.location='experience.jsp';</script>");
%>
