<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
               xmlns:mets="http://www.loc.gov/METS/"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="baseUrl">http://selbstzeugnisse.hab.de</xsl:variable>


  <xsl:template match="mets:structMap">
    <urlset>
      <xsl:apply-templates/>
    </urlset>
  </xsl:template>

  <xsl:template match="mets:div[@ID][mets:fptr]">
    <url>
      <loc><xsl:value-of select="concat($baseUrl, '/', translate(@ID, '.', '/'))"/></loc>
      <changefreq>monthly</changefreq>
    </url>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:transform>
