<xsl:transform version="2.0"
               xpath-default-namespace="http://docs.oasis-open.org/ns/xri/xrd-1.0"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="utf-8"/>

  <xsl:template match="XRDS">
    <xsl:text>#FORMAT: BEACON&#10;</xsl:text>
    <xsl:text>#PREFIX: http://d-nb.info/gnd/&#10;</xsl:text>
    <xsl:text>#TARGET: http://selbstzeugnisse.hab.de/{ID}&#10;</xsl:text>
    <xsl:text>#VERSION: 0.1&#10;</xsl:text>
    <xsl:text>#CONTACT: maus@hab.de&#10;</xsl:text>
    <xsl:text>#INSTITUTION: Herzog August Bibliothek Wolfenbüttel&#10;</xsl:text>
    <xsl:text>#TIMESTAMP: </xsl:text><xsl:value-of select="format-date(current-date(), '[Y]-[M01]-[D01]')"/><xsl:text>&#10;</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="Link">
    <xsl:variable name="gndUri" select="document(@href)/tei:idno[starts-with(., 'http://d-nb.info/gnd/')]"/>
    <xsl:if test="$gndUri">
      <xsl:value-of select="substring-after($gndUri, 'http://d-nb.info/gnd/')"/>
      <xsl:text>||</xsl:text>
      <xsl:value-of select="substring-after(../Subject, 'http://selbstzeugnisse.hab.de/')"/>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()"/>
  
</xsl:transform>
