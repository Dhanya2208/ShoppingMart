package example;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.*;
import javax.xml.xpath.*;
import org.w3c.dom.*;

import java.io.*;
import java.nio.file.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ExperienceServlet")
public class ExperienceServlet extends HttpServlet {

    private static final Object FILE_LOCK = new Object(); // simple lock for concurrency

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ensure UTF-8 form decoding
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        String productName = request.getParameter("productName");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        // basic server-side validation
        if (userName == null || userName.trim().isEmpty() ||
            userEmail == null || userEmail.trim().isEmpty() ||
            ratingStr == null || ratingStr.trim().isEmpty()) {
            response.getWriter().println("<script>alert('Please fill name, email and rating.'); history.back();</script>");
            return;
        }

        int rating;
        try { rating = Integer.parseInt(ratingStr); }
        catch (NumberFormatException e) {
            response.getWriter().println("<script>alert('Invalid rating'); history.back();</script>");
            return;
        }

        // Paths inside webapp
        String xmlRel = "/feedbacks.xml";
        String xsdRel = "/feedbacks.xsd";
        String xsltRel = "/feedbacks-summary.xslt";
        String outHtmlRel = "/feedbacks-summary.html";

        String xmlPath = getServletContext().getRealPath(xmlRel);
        String xsdPath = getServletContext().getRealPath(xsdRel);
        String xsltPath = getServletContext().getRealPath(xsltRel);
        String outHtmlPath = getServletContext().getRealPath(outHtmlRel);

        synchronized (FILE_LOCK) {
            try {
                // create xml dir or file if not exist
                File xmlFile = new File(xmlPath);
                xmlFile.getParentFile().mkdirs();
                if (!xmlFile.exists()) {
                    // create basic skeleton
                    try (Writer w = new OutputStreamWriter(new FileOutputStream(xmlFile), "UTF-8")) {
                        w.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<feedbacks>\n</feedbacks>");
                    }
                }

                // parse existing XML
                DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                dbf.setNamespaceAware(true);
                DocumentBuilder db = dbf.newDocumentBuilder();
                Document doc = db.parse(xmlFile);

                // compute new id (max existing + 1)
                NodeList nodes = doc.getElementsByTagName("feedback");
                int maxId = 0;
                for (int i = 0; i < nodes.getLength(); i++) {
                    Element f = (Element) nodes.item(i);
                    String idStr = f.getAttribute("id");
                    try {
                        int id = Integer.parseInt(idStr);
                        if (id > maxId) maxId = id;
                    } catch (Exception ex) { /* ignore parse errors */ }
                }
                int newId = maxId + 1;

                // create new feedback element
                Element root = doc.getDocumentElement();
                Element feedback = doc.createElement("feedback");
                feedback.setAttribute("id", Integer.toString(newId));

                Element eName = doc.createElement("userName");
                eName.setTextContent(userName);
                feedback.appendChild(eName);

                Element eEmail = doc.createElement("userEmail");
                eEmail.setTextContent(userEmail);
                feedback.appendChild(eEmail);

                if (productName != null && !productName.trim().isEmpty()) {
                    Element eProd = doc.createElement("productName");
                    eProd.setTextContent(productName);
                    feedback.appendChild(eProd);
                }

                Element eRating = doc.createElement("rating");
                eRating.setTextContent(Integer.toString(rating));
                feedback.appendChild(eRating);

                if (comment != null && !comment.trim().isEmpty()) {
                    Element eComment = doc.createElement("comment");
                    eComment.setTextContent(comment);
                    feedback.appendChild(eComment);
                }

                // date in yyyy-MM-dd
                String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
                Element eDate = doc.createElement("date");
                eDate.setTextContent(today);
                feedback.appendChild(eDate);

                // append
                root.appendChild(feedback);

                // write to temp file first
                File temp = new File(xmlPath + ".tmp");
                TransformerFactory tf = TransformerFactory.newInstance();
                Transformer writer = tf.newTransformer();
                writer.setOutputProperty(OutputKeys.INDENT, "yes");
                writer.transform(new DOMSource(doc), new StreamResult(new OutputStreamWriter(new FileOutputStream(temp), "UTF-8")));

                // validate temp against XSD
                SchemaFactory sf = SchemaFactory.newInstance(javax.xml.XMLConstants.W3C_XML_SCHEMA_NS_URI);
                Schema schema = sf.newSchema(new File(xsdPath));
                Validator validator = schema.newValidator();
                validator.validate(new StreamSource(temp)); // if invalid, exception thrown

                // if validation OK, move temp -> xml
                Files.move(temp.toPath(), xmlFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

                // transform XML -> HTML summary using XSLT
                TransformerFactory tff = TransformerFactory.newInstance();
                Source xslt = new StreamSource(new File(xsltPath));
                Transformer trans = tff.newTransformer(xslt);
                Source xmlSource = new StreamSource(xmlFile);
                File outHtml = new File(outHtmlPath);
                outHtml.getParentFile().mkdirs();
                trans.transform(xmlSource, new StreamResult(new OutputStreamWriter(new FileOutputStream(outHtml), "UTF-8")));

                // success response: redirect to summary or show a success page
                response.getWriter().println("<script>alert('Thank you! Feedback submitted successfully.'); window.location='" + request.getContextPath() + "/xml/feedbacks-summary.html';</script>");
            } catch (org.xml.sax.SAXParseException spe) {
                // validation or parse error
                String msg = "XML Validation failed: " + spe.getMessage();
                log(msg, spe);
                response.getWriter().println("<script>alert('Validation failed: " + escapeForJS(spe.getMessage()) + "'); history.back();</script>");
            } catch (Exception e) {
                log("Error while saving feedback", e);
                response.getWriter().println("<script>alert('Server error: " + escapeForJS(e.getMessage()) + "'); history.back();</script>");
            }
        }
    }

    // small helper to escape single quotes/newlines in JS alert
    private String escapeForJS(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n").replace("\r", "\\r");
    }
}
