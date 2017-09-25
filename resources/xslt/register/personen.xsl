<xsl:transform version="1.0"
               exclude-result-prefixes="tei xrd"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xrd="http://docs.oasis-open.org/ns/xri/xrd-1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../default.xsl"/>

  <xsl:variable name="linkmap" select="document('linkmap.xml', /)"/>

  <xsl:key name="persons" match="tei:person[tei:idno][normalize-space(tei:persName) != '']" use="substring(tei:persName, 1, 1)"/>

  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:template match="tei:text/tei:body">
    <div class="navigation">
      <xsl:call-template name="navigation"/>
    </div>
    <div class="mainpage register">
      <xsl:apply-templates select="tei:listPerson"/>
    </div>
    <div class="infopanel">
      <div class="screen-only controls">
        <ul>
          <li><a class="fa fa-print" href="javascript:print()"> Drucken</a></li>
        </ul>
      </div>
      <div class="facet">
        <h1>Schnellauswahl</h1>
        <ul>
          <xsl:for-each select="./tei:listPerson/tei:person[generate-id() = generate-id(key('persons', substring(tei:persName, 1, 1))[1])]">
            <xsl:sort select="substring(tei:persName, 1, 1)"/>
            <li>
              <a href="#{substring(tei:persName, 1, 1)}">
                <xsl:value-of select="substring(tei:persName, 1, 1)"/>
              </a>
            </li>
          </xsl:for-each>
        </ul>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="tei:listPerson">
    <h1>Personenregister</h1>
    <xsl:for-each select="tei:person[generate-id() = generate-id(key('persons', substring(tei:persName, 1, 1))[1])]">
      <xsl:sort select="substring(tei:persName, 1, 1)"/>
      <h2 id="{substring(tei:persName, 1, 1)}"><xsl:value-of select="substring(tei:persName, 1, 1)"/></h2>
      <dl>
        <xsl:for-each select="key('persons', substring(tei:persName, 1, 1))">
          <xsl:sort select="tei:persName"/>
          <xsl:variable name="refId" select="concat('register.xml#', @xml:id)"/>
          <xsl:if test="count($linkmap//xrd:Link[@href = $refId]) &gt; 0">
            <dt id="{@xml:id}">
              <xsl:value-of select="tei:persName"/>
            </dt>
            <dd>
              <xsl:for-each select="$linkmap//xrd:Link[@href = $refId]">
                <xsl:if test="position() > 1">
                  <xsl:text>, </xsl:text>
                </xsl:if>
                <a href="{../xrd:Subject}">
                  <xsl:value-of select="xrd:Title"/>
                </a>
              </xsl:for-each>
            </dd>
          </xsl:if>
        </xsl:for-each>
      </dl>
    </xsl:for-each>
  </xsl:template>

</xsl:transform>
