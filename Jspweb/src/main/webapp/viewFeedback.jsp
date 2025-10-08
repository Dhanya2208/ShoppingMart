<%@ page import="javax.xml.transform.*, javax.xml.transform.stream.*, java.io.*" %>
<%
    String xmlFile = application.getRealPath("/feedbacks.xml");
    String xslFile = application.getRealPath("/feedbacks.xsl");

    TransformerFactory factory = TransformerFactory.newInstance();
    Transformer transformer = factory.newTransformer(new StreamSource(new File(xslFile)));

    response.setContentType("text/html");
    transformer.transform(new StreamSource(new File(xmlFile)), new StreamResult(out));
%>
