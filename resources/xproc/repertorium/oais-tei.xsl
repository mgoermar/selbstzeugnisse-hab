<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="TEI">
    <xsl:copy>
      <xsl:attribute name="xsi:schemaLocation">http://www.tei-c.org/ns/1.0 http://selbstzeugnisse.hab.de/repertorium/repository.xsd</xsl:attribute>
      <xsl:apply-templates select="@* except @xsi:*"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@ref[starts-with(., '../../register.xml')]">
    <xsl:if test="document(.)/idno[@type = 'URI']">
      <xsl:attribute name="ref" select="document(.)/idno[@type = 'URI']"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ref[ends-with(@target, '.xml')]">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:transform>
