<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xmlns:mets="http://www.loc.gov/METS/"
               xmlns:fun="http://selbstzeugnisse.hab.de/ns"
               xmlns:xlink="http://www.w3.org/1999/xlink"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="target" select="'html'"/>

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="mets:mets">
    <transformations>
      <xsl:for-each select="//mets:div[@ID and @ID != 'home']">
        <xsl:if test="//mets:file[@ID = current()/mets:fptr/@FILEID]/@MIMETYPE = 'application/tei+xml'">
          <xsl:variable name="candidates" select="//mets:behaviorSec[@ID = $target]//mets:behavior[mets:interfaceDef/@xlink:href = 'http://www.w3.org/TR/xslt']"/>
          <xsl:variable name="behavior" select="fun:select-behavior(reverse(ancestor-or-self::mets:div), $candidates)"/>
          <xsl:if test="$behavior">
            <transformation id="{@ID}" stylesheet="{$behavior/mets:mechanism/@xlink:href}" source="{//mets:file[@ID = current()/mets:fptr/@FILEID]/mets:FLocat/@xlink:href}"/>
          </xsl:if>
        </xsl:if>
      </xsl:for-each>
    </transformations>
  </xsl:template>

  <xsl:function name="fun:select-behavior" as="element(mets:behavior)?">
    <xsl:param name="divisions" as="element(mets:div)+"/>
    <xsl:param name="behaviors" as="element(mets:behavior)*"/>
    <xsl:choose>
      <xsl:when test="$divisions[1]/@ID = $behaviors/@STRUCTID">
        <xsl:sequence select="$behaviors[@STRUCTID = $divisions[1]/@ID][1]"/>
      </xsl:when>
      <xsl:when test="count($divisions) gt 1">
        <xsl:sequence select="fun:select-behavior($divisions[position() gt 1], $behaviors)"/>
      </xsl:when>
    </xsl:choose>
  </xsl:function>

</xsl:transform>
