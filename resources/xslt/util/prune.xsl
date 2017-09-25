<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns="http://www.tei-c.org/ns/1.0"
               xmlns:xi="http://www.w3.org/2001/XInclude"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="idno">
    <xsl:value-of select="//msDesc/msIdentifier/idno"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="//msPart//locus/@from"/>
    <xsl:if test="//msPart//locus/@from != msPart//locus/@to">
      <xsl:text>-</xsl:text>
      <xsl:value-of select="//msPart//locus/@to"/>
    </xsl:if>
  </xsl:variable>

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="TEI">
    <xsl:copy>
      <xsl:attribute name="xml:id" select="concat('repertorium.eintrag.', tokenize(base-uri(/), '/')[last()])"/>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <!-- Leere Elemente entfernen -->
  <xsl:template match="*[normalize-space() = ''][normalize-space(string-join(.//@*, '')) = '']"/>

  <!-- Leere Attribute entfernen -->
  <xsl:template match="@*[normalize-space() = '']"/>

  <!-- titleStmt -->
  <xsl:template match="fileDesc">
    <xsl:copy>
      <titleStmt>
        <title>
          <xsl:value-of select="$idno"/>
          <xsl:text> – </xsl:text>
          <xsl:value-of select=".//title[@type = 'uniform']"/>
        </title>

        <principal ref="https://doi.org/10.1515/editio-2016-0009">Inga Hanna Ralle</principal>
        <funder ref="http://d-nb.info/gnd/5055588-1">Niedersächsisches Ministerium für Wissenschaft und Kultur</funder>
        <respStmt>
          <name>Jacqueline Krone</name>
          <resp>Metadaten, Recherche und Korrektur</resp>
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
      <xsl:apply-templates select="sourceDesc"/>
    </xsl:copy>
  </xsl:template>

  <!-- institution -->
  <xsl:template match="msIdentifier[parent::msDesc]">
    <xsl:copy>
      <institution ref="http://d-nb.info/gnd/8989-8">Herzog August Bibliothek Wolfenbüttel</institution>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="institution"/>

  <!-- Signatur des Selbstzeugnisses -->
  <xsl:template match="msIdentifier[parent::msPart]">
    <xsl:copy>
      <idno>
        <xsl:value-of select="$idno"/>
      </idno>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="xi:include"/>

</xsl:transform>
