<xsl:transform version="2.0"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="div[head/date[@when]]">
    <xsl:copy>
      <xsl:attribute name="xml:id" select="concat('E', head/date/@when)"/>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:transform>
