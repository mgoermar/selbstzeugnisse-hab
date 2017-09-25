<xsl:transform version="1.0"
               exclude-result-prefixes="tei"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../default.xsl"/>

  <xsl:template match="tei:text/tei:body">
    <div class="navigation">
      <xsl:call-template name="navigation"/>
    </div>
    <xsl:apply-templates/>
  </xsl:template>

</xsl:transform>
