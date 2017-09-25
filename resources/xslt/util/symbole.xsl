<xsl:transform version="2.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" use-character-maps="symbole"/>

  <xsl:character-map name="symbole">
    <xsl:output-character character="&#x263D;" string="&lt;c>&#x263D;&lt;/c>"/>
    <xsl:output-character character="&#x2642;" string="&lt;c>&#x2642;&lt;/c>"/>
    <xsl:output-character character="&#x263F;" string="&lt;c>&#x263F;&lt;/c>"/>
    <xsl:output-character character="&#x2643;" string="&lt;c>&#x2643;&lt;/c>"/>
    <xsl:output-character character="&#x2640;" string="&lt;c>&#x2640;&lt;/c>"/>
    <xsl:output-character character="&#x2644;" string="&lt;c>&#x2644;&lt;/c>"/>
    <xsl:output-character character="&#x2609;" string="&lt;c>&#x2609;&lt;/c>"/>
  </xsl:character-map>

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
