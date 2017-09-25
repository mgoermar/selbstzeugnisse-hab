<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="fileDesc">
    <xsl:copy>
      <titleStmt>
        <title>
          Herzog August der Jüngere von Braunschweig-Wolfenbüttel (1579-1666): Ephemerides. Sive Diarium (1594-1635)
          <xsl:text> – </xsl:text>
          <xsl:value-of select="/TEI/@n"/>
        </title>
        <principal ref="https://doi.org/10.1515/editio-2016-0009">Inga Hanna Ralle</principal>
        <funder ref="http://d-nb.info/gnd/5055588-1">Niedersächsisches Ministerium für Wissenschaft und Kultur</funder>
        <respStmt>
          <name>Jacqueline Krone</name>
          <resp>Metadaten, Recherche und Korrektu</resp>
        </respStmt>
        <respStmt>
          <name ref="http://orcid.org/0000-0001-9292-5673">David Maus</name>
          <resp>Technische Konzeption und Begleitung</resp>
        </respStmt>
      </titleStmt>
      <publicationStmt>
        <publisher>
          <name ref="http://d-nb.info/gnd/8989-8">Herzog August Bibliothek Wolfenbüttel</name>
        </publisher>
        <pubPlace>Wolfenbüttel</pubPlace>
        <date when="2017">2017</date>
        <availability>
          <licence target="https://creativecommons.org/licenses/by-sa/4.0/">CC-BY-SA 4.0</licence>
        </availability>
      </publicationStmt>
      <sourceDesc>
        <bibl>
          Herzog August der Jüngere von Braunschweig-Wolfenbüttel (1579-1666): Ephemerides. Sive Diarium (1594-1635). Herzog
          August Bibliothek, Signatur: Cod.  Guelf. 42.19 Aug. 2°
        </bibl>
      </sourceDesc>
    </xsl:copy>
  </xsl:template>
  
</xsl:transform>
