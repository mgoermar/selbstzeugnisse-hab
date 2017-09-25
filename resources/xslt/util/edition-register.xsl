<xsl:transform version="2.0"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rs[starts-with(@ref, '#')]">
    <xsl:copy>
      <xsl:attribute name="ref" select="concat('register.xml', @ref)"/>
      <xsl:apply-templates select="node() | @*[not(name() = 'ref')]"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="sourceDesc"/>
  
</xsl:transform>
