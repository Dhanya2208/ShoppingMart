<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>Feedback Summary</title>
                <style>
                    table { border-collapse: collapse; width: 70%; margin: 20px auto; }
                    th, td { border: 1px solid #333; padding: 10px; text-align: left; }
                    th { background-color: #4CAF50; color: white; }
                </style>
            </head>
            <body>
                <h2 align="center">User Feedback Summary</h2>
                <table>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Product</th>
                        <th>Rating</th>
                        <th>Comment</th>
                    </tr>
                    <xsl:for-each select="feedbacks/feedback">
                        <tr>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="email"/></td>
                            <td><xsl:value-of select="product"/></td>
                            <td><xsl:value-of select="rating"/></td>
                            <td><xsl:value-of select="comment"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
