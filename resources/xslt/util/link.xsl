<xsl:transform version="2.0"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               exclude-result-prefixes="#all"
               xmlns:xsd="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="TEI">
    <xsl:copy>
      <xsl:variable name="cur" select="substring-before(tokenize(base-uri(), '/')[last()], '.xml')"/>
      <xsl:variable name="nxt" select="concat(xsd:integer($cur) + 1, '.xml')"/>
      <xsl:variable name="prv" select="concat(xsd:integer($cur) - 1, '.xml')"/>
      <xsl:if test="doc-available(resolve-uri($nxt, base-uri()))">
        <xsl:attribute name="next" select="$nxt"/>
      </xsl:if>
      <xsl:attribute name="n" select="$cur"/>
      <xsl:if test="doc-available(resolve-uri($prv, base-uri()))">
        <xsl:attribute name="prev" select="$prv"/>
      </xsl:if>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
