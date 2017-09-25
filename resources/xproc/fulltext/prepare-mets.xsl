<xsl:transform version="2.0"
               xmlns:mets="http://www.loc.gov/METS/"
               xmlns:xlink="http://www.w3.org/1999/xlink"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="mets:mets">
    <transformations>
      <xsl:for-each select="//mets:div[ancestor-or-self::mets:div/@ID = //mets:behaviorSec[@ID = 'html']/mets:behavior/@STRUCTID][mets:fptr]">
        <xsl:variable name="metsId" select="@ID"/>
        <xsl:variable name="fileId" select="mets:fptr/@FILEID"/>
        <xsl:if test="//mets:file[@ID = $fileId][@MIMETYPE = 'application/tei+xml'] and $metsId != 'home'">
          <xsl:variable name="metsIds" select="ancestor-or-self::mets:div[@ID = //mets:behaviorSec[@ID = 'html']/mets:behavior/@STRUCTID]/@ID"/>
          <transformation id="{@ID}"
                          source="{//mets:file[@ID = $fileId][@MIMETYPE = 'application/tei+xml']/mets:FLocat/@xlink:href}"
                          stylesheet="{(//mets:behaviorSec[@ID = 'html']/mets:behavior[@STRUCTID = $metsIds])[1]/mets:mechanism/@xlink:href}"/>
        </xsl:if>
      </xsl:for-each>
    </transformations>
  </xsl:template>

</xsl:transform>
