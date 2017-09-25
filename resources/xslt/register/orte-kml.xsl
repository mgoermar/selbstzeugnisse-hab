<xsl:transform version="1.0" exclude-result-prefixes="tei"
               xmlns="http://www.opengis.net/kml/2.2"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" media-type="application/vnd.google-earth.kml+xml"/>

  <xsl:template match="/">
    <kml>
      <xsl:apply-templates/>
    </kml>
  </xsl:template>

  <xsl:template match="tei:listPlace">
    <Document>
      <xsl:apply-templates/>
    </Document>
  </xsl:template>

  <xsl:template match="tei:place">
    <Placemark>
      <address><xsl:value-of select="@xml:id"/></address>
      <Point>
        <coordinates><xsl:value-of select="translate(tei:location/tei:geo, ' ', ',')"/></coordinates>
      </Point>
    </Placemark>
  </xsl:template>

  <xsl:template match="text()"/>
  
</xsl:transform>
