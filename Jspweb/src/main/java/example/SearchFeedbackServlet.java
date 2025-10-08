package example;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.*;
import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.w3c.dom.*;

@WebServlet("/SearchFeedbackServlet")
public class SearchFeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String minRating = request.getParameter("minRating");
        String productName = request.getParameter("productName");
        String userEmail = request.getParameter("userEmail");

        // build XPath filter
        StringBuilder cond = new StringBuilder();
        if (minRating != null && !minRating.trim().isEmpty()) {
            cond.append("rating >= ").append(minRating.trim());
        }
        if (productName != null && !productName.trim().isEmpty()) {
            if (cond.length() > 0) cond.append(" and ");
            cond.append("productName = '").append(escapeForXPath(productName.trim())).append("'");
        }
        if (userEmail != null && !userEmail.trim().isEmpty()) {
            if (cond.length() > 0) cond.append(" and ");
            cond.append("userEmail = '").append(escapeForXPath(userEmail.trim())).append("'");
        }

        String xpathExpr = "/feedbacks/feedback";
        if (cond.length() > 0) xpathExpr += "[" + cond.toString() + "]";

        PrintWriter out = response.getWriter();
        out.println("<html><head><title>Search Results</title><style>body{font-family:Arial;padding:20px;} table{border-collapse:collapse;width:100%} th,td{border:1px solid #ddd;padding:8px;text-align:left} th{background:#f1f1f1}</style></head><body>");
        out.println("<h2>Results for: <code>" + xpathExpr + "</code></h2>");

        try {
            String xmlPath = getServletContext().getRealPath("/xml/feedbacks.xml");
            File xmlFile = new File(xmlPath);
            if (!xmlFile.exists()) {
                out.println("<p>No feedbacks yet.</p>");
                out.println("</body></html>");
                return;
            }

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(false);
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(xmlFile);

            XPathFactory xpf = XPathFactory.newInstance();
            XPath xp = xpf.newXPath();
            XPathExpression expr = xp.compile(xpathExpr);

            NodeList nodes = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
            out.println("<p>Found: " + nodes.getLength() + " feedback(s)</p>");

            if (nodes.getLength() > 0) {
                out.println("<table><tr><th>ID</th><th>User</th><th>Email</th><th>Product</th><th>Rating</th><th>Comment</th><th>Date</th></tr>");
                for (int i = 0; i < nodes.getLength(); i++) {
                    Element f = (Element) nodes.item(i);
                    String id = f.getAttribute("id");
                    String uname = getText(f, "userName");
                    String email = getText(f, "userEmail");
                    String prod = getText(f, "productName");
                    String rating = getText(f, "rating");
                    String comment = getText(f, "comment");
                    String date = getText(f, "date");

                    out.println("<tr><td>" + id + "</td><td>" + esc(uname) + "</td><td>" + esc(email) + "</td><td>" + esc(prod) + "</td><td>" + esc(rating) + "</td><td>" + esc(comment) + "</td><td>" + esc(date) + "</td></tr>");
                }
                out.println("</table>");
            }

        } catch (Exception e) {
            e.printStackTrace(out);
            out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
        }

        out.println("<p><a href='" + request.getContextPath() + "/experience-search.jsp'>Back to search</a> | <a href='" + request.getContextPath() + "/xml/feedbacks-summary.html'>View full summary</a></p>");
        out.println("</body></html>");
    }

    private String getText(Element parent, String tag) {
        NodeList nl = parent.getElementsByTagName(tag);
        if (nl.getLength() == 0) return "";
        return nl.item(0).getTextContent();
    }

    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;");
    }

    private String escapeForXPath(String s) {
        // simplistic: if string contains single quote, wrap in concat(...) expression
        if (s.indexOf('\'') < 0) return s;
        // fallback: replace ' with &apos; — XPath literal handling is complex; for simple names avoid quotes
        return s.replace("'", "&apos;");
    }
}
