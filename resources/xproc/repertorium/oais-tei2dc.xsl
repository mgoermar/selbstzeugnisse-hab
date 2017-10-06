<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="tei:msDesc">
    <oai_dc:dc xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
      <xsl:apply-templates/>
    </oai_dc:dc>
  </xsl:template>

  <xsl:template match="tei:idno[../../tei:msPart]">
    <dc:identifier>
      <xsl:value-of select="."/>
    </dc:identifier>
  </xsl:template>

  <xsl:template match="tei:rubric | tei:title[@type = 'uniform']">
    <dc:title>
      <xsl:value-of select="."/>
    </dc:title>
  </xsl:template>

  <xsl:template match="tei:author">
    <dc:creator>
      <xsl:value-of select="."/>
    </dc:creator>
  </xsl:template>

  <xsl:template match="tei:respStmt">
    <dc:contributor>
      <xsl:value-of select="."/>
    </dc:contributor>
  </xsl:template>

  <xsl:template match="tei:date[@type = 'coverage']">
    <dc:coverage>
      <xsl:choose>
        <xsl:when test="@when">
          <xsl:value-of select="@when"/>
        </xsl:when>
        <xsl:when test="@from = @to">
          <xsl:value-of select="@from"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@from"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="@to"/>
        </xsl:otherwise>
      </xsl:choose>
    </dc:coverage>
  </xsl:template>

  <xsl:template match="tei:textLang">
    <dc:language><xsl:value-of select="@mainLang"/></dc:language>
    <xsl:if test="@otherLangs">
      <dc:language><xsl:value-of select="@otherLangs"/></dc:language>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:summary">
    <dc:description>
      <xsl:value-of select="."/>
    </dc:description>
  </xsl:template>

  <xsl:template match="tei:support/tei:material">
    <dc:format>
      <xsl:value-of select="."/>
    </dc:format>
  </xsl:template>

  <xsl:template match="tei:measure">
    <dc:format>
      <xsl:value-of select="."/>
    </dc:format>
  </xsl:template>

  <xsl:template match="tei:dimensions">
    <dc:format>
      <xsl:value-of select="concat(translate(tei:width/@quantity, '.', ','), tei:width/@unit)"/>
      <xsl:text> x </xsl:text>
      <xsl:value-of select="concat(translate(tei:height/@quantity, '.', ','), tei:height/@unit)"/>
    </dc:format>
  </xsl:template>

  <xsl:template match="tei:msItem">
    <dc:type>
      <xsl:value-of select="document(@class)/tei:catDesc/tei:term"/>
    </dc:type>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:origDate">
    <dc:date>
      <xsl:choose>
        <xsl:when test="@when">
          <xsl:value-of select="@when"/>
        </xsl:when>
        <xsl:when test="@from = @to">
          <xsl:value-of select="@from"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@from"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="@to"/>
        </xsl:otherwise>
      </xsl:choose>
    </dc:date>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:transform>
