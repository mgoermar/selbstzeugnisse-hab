<xsl:transform version="2.0"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="utf-8"/>

  <xsl:template match="/">
    <xsl:apply-templates select="//TEI"/>
  </xsl:template>

  <xsl:template match="TEI">
    <xsl:value-of select=".//collection"/>
    <xsl:text>|</xsl:text>
    <xsl:value-of select=".//idno[ancestor::msPart]"/>
    <xsl:text>|</xsl:text>
    <xsl:value-of select="concat('http://selbstzeugnisse.hab.de/repertorium/eintrag/', tokenize(@xml:id, '\.')[3])"/>
    <xsl:text>|</xsl:text>
    <xsl:value-of select="substring-after(.//msItem/@class, '#')"/>
    <xsl:text>|</xsl:text>
    <xsl:value-of select="normalize-space(.//title[@type = 'uniform'])"/>
    <xsl:text>|</xsl:text>
    <xsl:if test=".//origDate">
      <xsl:text>datiert</xsl:text>
    </xsl:if>
    <xsl:text>&#13;&#10;</xsl:text>
  </xsl:template>

</xsl:transform>
