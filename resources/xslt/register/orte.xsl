<xsl:transform version="1.0"
               exclude-result-prefixes="tei xrd"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xrd="http://docs.oasis-open.org/ns/xri/xrd-1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../default.xsl"/>

  <xsl:variable name="linkmap" select="document('linkmap.xml', /)"/>

  <xsl:key name="places" match="tei:place[tei:idno][normalize-space(@xml:id) != '']" use="substring(@xml:id, 1, 1)"/>

  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:template match="tei:text/tei:body">
    <div class="navigation">
      <xsl:call-template name="navigation"/>
    </div>
    <div class="content">
      <div class="contentWrap">
        <div class="register">
          <xsl:apply-templates select="tei:listPlace"/>
        </div>
      </div>
      <div id="infopanel">
        <input class="trigInp" type="checkbox" role="button"/>
        <a id="trigBtn" role="button">
          <span></span>
          <span></span>
        </a>
        <div class="facet large">
          <div class="formWrap">
            <h1>Schnellauswahl</h1>
            <ul>
              <xsl:for-each select="./tei:listPlace/tei:place[generate-id() = generate-id(key('places', substring(@xml:id, 1, 1))[1])]">
                <xsl:sort select="substring(@xml:id, 1, 1)"/>
                <li>
                  <a href="#{substring(@xml:id, 1, 1)}">
                    <xsl:value-of select="substring(@xml:id, 1, 1)"/>
                  </a>
                </li>
              </xsl:for-each>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="tei:listPlace">
    <h1>Ortsregister</h1>
    <xsl:for-each select="tei:place[generate-id() = generate-id(key('places', substring(@xml:id, 1, 1))[1])]">
      <xsl:sort select="substring(@xml:id, 1, 1)"/>
      <h2 id="{substring(@xml:id, 1, 1)}"><xsl:value-of select="substring(@xml:id, 1, 1)"/></h2>
      <dl>
        <xsl:for-each select="key('places', substring(@xml:id, 1, 1))">
          <xsl:sort select="@xml:id"/>
          <xsl:variable name="refId" select="concat('register.xml#', @xml:id)"/>
          <xsl:if test="count($linkmap//xrd:Link[@href = $refId]) &gt; 0">
            <dt id="{@xml:id}">
              <xsl:value-of select="tei:placeName"/>
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
