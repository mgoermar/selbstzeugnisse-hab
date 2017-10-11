<xsl:transform version="1.0"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="utf-8" indent="yes" media-type="application/xml"/>

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="tei:title[parent::tei:titleStmt]">
    <xsl:copy>Vokabular</xsl:copy>
  </xsl:template>

  <xsl:template match="tei:classDecl">
    <xsl:element name="classDecl" namespace="http://www.tei-c.org/ns/1.0">
      <xsl:element name="taxonomy" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:for-each select="tei:taxonomy/tei:category">
          <xsl:sort select="tei:catDesc/tei:term"/>
          <xsl:copy>
            <xsl:copy-of select="@xml:id"/>
            <xsl:copy-of select="tei:catDesc"/>
          </xsl:copy>
        </xsl:for-each>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tei:text"/>

</xsl:transform>
