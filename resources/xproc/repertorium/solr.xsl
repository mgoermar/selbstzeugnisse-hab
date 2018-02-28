<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xmlns:c="http://www.w3.org/ns/xproc-step"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:fun="http://dmaus.name/ns/xslt"
               xmlns:xsd="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="tei:TEI">
    <c:request method="POST" href="http://194.95.134.40:8080/solr/selbst/update" detailed="true">
      <c:body content-type="application/xml">
        <add commitWithin="500">
          <doc>
            <xsl:copy-of select="fun:field('id',    1.0, substring-before(tokenize(document-uri(/), '/')[last()], '.xml'))"/>
            <xsl:copy-of select="fun:field('title', 1.0, //tei:title[ancestor::tei:msDesc])"/>
            <xsl:copy-of select="fun:field('title', 1.0, //tei:rubric)"/>
            <xsl:copy-of select="fun:field('identifier', 1.0, //tei:idno[ancestor::tei:msDesc])"/>
            <xsl:copy-of select="fun:field('date_min', 1.0, substring((//tei:origDate/@from, //tei:origDate/@notBefore)[1], 1, 4))"/>
            <xsl:copy-of select="fun:field('date_max', 1.0, substring((//tei:origDate/@to, //tei:origDate/@notAfter)[1], 1, 4))"/>
            <xsl:if test="//tei:origDate/@when">
              <xsl:copy-of select="fun:field('date_min', 1.0, substring(//tei:origDate/@when, 1, 4))"/>
              <xsl:copy-of select="fun:field('date_max', 1.0, substring(//tei:origDate/@when, 1, 4))"/>
            </xsl:if>
            <xsl:if test="//tei:origDate">
              <xsl:copy-of select="fun:field('date_display', 1.0, fun:date(//tei:origDate))"/>
            </xsl:if>
            <xsl:copy-of select="fun:field('creator', 1.0, //tei:author)"/>
            <xsl:copy-of select="fun:field('creator_display', 1.0, //tei:author)"/>
            <xsl:copy-of select="fun:field('contributor', 1.0, //tei:respStmt/tei:name)"/>
            <xsl:copy-of select="fun:field('abstract', 1.0, //tei:summary)"/>
            <xsl:copy-of select="fun:field('genre', 1.0, document(//tei:msItem/@class)/tei:catDesc/tei:term)"/>
            <xsl:copy-of select="fun:field('language', 1.0, fun:language(//tei:textLang/@mainLang))"/>

            <xsl:copy-of select="fun:field('origdate_pivot', 1.0, fun:century((//tei:origDate/@when, //tei:origDate/@from, //tei:origDate/@notBefore, //tei:origDate/@after, //tei:origDate/@notAfter, //tei:origDate/@before)[1]))"/>
            <xsl:copy-of select="fun:field('coverage_pivot', 1.0, fun:century((//tei:date[@type = 'coverage']/@when, //tei:date[@type = 'coverage']/@from, //tei:date[@type = 'coverage']/@notBefore, //tei:date[@type = 'coverage']/@after, //tei:date[@type = 'coverage']/@notAfter, //tei:date[@type = 'coverage']/@before)[1]))"/>

            <xsl:copy-of select="fun:field('collection_pivot', 1.0, //tei:collection)"/>

          </doc>
        </add>
      </c:body>
    </c:request>
  </xsl:template>

  <xsl:function name="fun:century" as="xsd:string">
    <xsl:param name="yearAttr" as="attribute()?"/>
    <xsl:variable name="year" select="substring($yearAttr, 1, 4)"/>
    <xsl:value-of select="if ($year castable as xsd:integer) then concat(1 + (xsd:integer($year) idiv 100), '. Jahrhundert') else 'Ohne Zeitangabe'"/>
  </xsl:function>

  <xsl:function name="fun:field" as="element(field)*">
    <xsl:param name="field" as="xsd:string"/>
    <xsl:param name="boost" as="xsd:decimal"/>
    <xsl:param name="value" as="item()*"/>

    <xsl:for-each select="$value">
      <xsl:if test="normalize-space()">
        <xsl:element name="field">
          <xsl:attribute name="name"  select="$field"/>
          <xsl:attribute name="boost" select="$boost"/>
          <xsl:value-of select="normalize-space()"/>
        </xsl:element>
      </xsl:if>
    </xsl:for-each>
  </xsl:function>

  <xsl:function name="fun:date" as="xsd:string">
    <xsl:param name="element" as="element()"/>
    <xsl:choose>
      <xsl:when test="normalize-space($element) != ''">
        <xsl:value-of select="normalize-space($element)"/>
      </xsl:when>
      <xsl:when test="$element/@when">
        <xsl:value-of select="substring($element/@when, 1, 4)"/>
      </xsl:when>
      <xsl:when test="$element/@from = $element/@to">
        <xsl:value-of select="substring($element/@from, 1, 4)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(substring($element/@from, 1, 4), '–', substring($element/@to, 1, 4))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="fun:language" as="xsd:string">
    <xsl:param name="code" as="attribute()"/>
    <xsl:choose>
      <xsl:when test="$code = 'deu' or $code = 'de'">Deutsch</xsl:when>
      <xsl:when test="$code = 'lat' or $code = 'la'">Latein</xsl:when>
      <xsl:when test="$code = 'ces' or $code = 'cs'">Tschechisch</xsl:when>
      <xsl:when test="$code = 'nld' or $code = 'nl'">Niederländisch</xsl:when>
      <xsl:when test="$code = 'fra' or $code = 'fr'">Französisch</xsl:when>
      <xsl:when test="$code = 'eng' or $code = 'en'">Englisch</xsl:when>
      <xsl:otherwise>Unbekannt/Keine Angabe</xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:template match="text()"/>

</xsl:transform>
