<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0"
               exclude-result-prefixes="tei mets html"
               xmlns:html="http://www.w3.org/1999/xhtml"
               xmlns:mets="http://www.loc.gov/METS/"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="default.xsl"/>

  <xsl:template match="tei:text/tei:body">
    <div class="navigation">
      <xsl:call-template name="navigation"/>
    </div>
    <div class="mainpage">
      <xsl:apply-templates/>
    </div>
    <div class="infopanel facet">
      <ul class="controls">
        <li>
          <a class="fa fa-print" href="javascript:print()"> Drucken</a>
        </li>
      </ul>
      <h1>Schnellauswahl</h1>
      <ul>
        <xsl:for-each select=".//tei:listBibl//tei:head">
          <li>
            <a href="#{generate-id()}"><xsl:apply-templates/></a>
          </li>
        </xsl:for-each>
      </ul>
    </div>
  </xsl:template>


  <xsl:template match="tei:listBibl">

    <xsl:element name="h{1 + count(ancestor::*/tei:head)}">
      <xsl:attribute name="id"><xsl:value-of select="generate-id(tei:head)"/></xsl:attribute>
      <xsl:apply-templates select="tei:head/node()"/>
      <xsl:text> </xsl:text>
      <small>
        <xsl:value-of select="concat('(', count(tei:bibl), ' Einträge)')"/>
      </small>
    </xsl:element>

    <ul class="list-styled">
      <xsl:for-each select="tei:bibl">
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

</xsl:transform>
