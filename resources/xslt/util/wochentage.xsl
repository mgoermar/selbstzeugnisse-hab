<xsl:transform version="2.0"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="utf-8"/>

  <xsl:variable name="terms">
    <tei:term key="&#x263D;">1</tei:term>
    <tei:term key="&#x2642;">2</tei:term>
    <tei:term key="&#x263F;">3</tei:term>
    <tei:term key="&#x2643;">4</tei:term>
    <tei:term key="&#x2640;">5</tei:term>
    <tei:term key="&#x2644;">6</tei:term>
    <tei:term key="&#x2609;">0</tei:term>
  </xsl:variable>

  <xsl:template match="tei:date">
    <xsl:value-of select="concat(@when, ';', substring(($terms/*[@key = current()/descendant::tei:c])[1], 1, 2))"/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:transform>
