package example;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.validation.*;
import javax.xml.xpath.*;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

public class XmlDbHelper {

    // Validate XML against XSD. Returns true if valid.
    public static boolean validateXML(String xmlPath, String xsdPath) throws Exception {
        SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        Schema schema = factory.newSchema(new File(xsdPath));
        Validator validator = schema.newValidator();
        validator.validate(new StreamSource(new File(xmlPath)));
        return true;
    }

    // Transform XML -> HTML using XSLT and write to outputHtmlPath.
    public static void transformXmlToHtml(String xmlPath, String xsltPath, String outputHtmlPath) throws Exception {
        TransformerFactory tf = TransformerFactory.newInstance();
        Templates tmpl = tf.newTemplates(new StreamSource(new File(xsltPath)));
        Transformer transformer = tmpl.newTransformer();
        transformer.transform(new StreamSource(new File(xmlPath)), new StreamResult(new File(outputHtmlPath)));
    }

    // Run an XPath expression and print results (returns NodeList)
    public static NodeList runXPath(String xmlPath, String xpathExpr) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(false);
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(new File(xmlPath));

        XPathFactory xpf = XPathFactory.newInstance();
        XPath xpath = xpf.newXPath();
        XPathExpression expr = xpath.compile(xpathExpr);

        Object result = expr.evaluate(doc, XPathConstants.NODESET);
        return (NodeList) result;
    }

    // Example usage
    public static void main(String[] args) throws Exception {
        String base = "WebContent/xml"; // adjust path to where you put files in your project
        String xml = base + "/feedbacks.xml";
        String xsd = base + "/feedbacks.xsd";
        String xslt = "WebContent/xslt/feedbacks-summary.xslt";
        String outHtml = "WebContent/html/feedbacks-summary.html";

        System.out.println("Validating XML...");
        try {
            validateXML(xml, xsd);
            System.out.println("XML valid.");
        } catch (Exception e) {
            System.err.println("Validation failed: " + e.getMessage());
            // If invalid, you may want to log the error and stop.
        }

        System.out.println("Transforming to HTML...");
        transformXmlToHtml(xml, xslt, outHtml);
        System.out.println("HTML generated at: " + outHtml);

        System.out.println("Running XPath queries:");

        // Example 1: choose feedbacks with rating > 3
        String xp1 = "/feedbacks/feedback[rating>3]";
        NodeList nodes = runXPath(xml, xp1);
        System.out.println("Feedbacks with rating > 3: " + nodes.getLength());
        for (int i = 0; i < nodes.getLength(); i++) {
            System.out.println("  - " + nodes.item(i).getTextContent().replace("\n"," ").trim());
        }

        // Example 2: average rating for product 'Tomato' (XPath 1.0 doesn't have avg, so compute with node set)
        NodeList tomatoNodes = runXPath(xml, "/feedbacks/feedback[productName='Tomato']/rating");
        double sum = 0;
        for (int i = 0; i < tomatoNodes.getLength(); i++) {
            sum += Double.parseDouble(tomatoNodes.item(i).getTextContent());
        }
        if (tomatoNodes.getLength() > 0) {
            System.out.println("Tomato avg rating: " + (sum / tomatoNodes.getLength()));
        } else {
            System.out.println("No tomato feedbacks.");
        }
    }
}
