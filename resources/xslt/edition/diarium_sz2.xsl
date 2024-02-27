<xsl:transform version="1.0"
               exclude-result-prefixes="tei"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../default_sz2.xsl"/>
<!--  <xsl:import href="../default.xsl"/>-->
  <xsl:import href="diarium-import_sz2.xsl"/>

  <xsl:output method="html" encoding="utf-8" indent="yes"/>
  

  <xsl:template match="tei:text/tei:group">
    <nav role="navigation">
      <xsl:call-template name="navigation"/>
    </nav>
    <div class="mainpage">
      <h1>Diarien Ludwig Rudolph und Christine Luise</h1>
      <p>
        <xsl:value-of select="//tei:teiHeader//tei:titleStmt/tei:title"/>
      </p>
      <table>
        <tbody>
          <tr>
            <td style="vertical-align: middle;">
              <h2>
                <a href="front">Titelseite</a>
              </h2>
            </td>
            <td> </td>
          </tr>
          <xsl:for-each select="tei:text">
            <tr>
              <td style="vertical-align: middle;">
                <h2>
                  <a href="{substring(tei:body//tei:date[1]/@when, 1, 4)}">
                    <xsl:value-of select="substring(tei:body//tei:date[1]/@when, 1, 4)"/>
                  </a>
                </h2>
              </td>
              <td style="vertical-align: middle;">
                <ul>
                  <li>
                    <xsl:text/>
                    <xsl:call-template name="datum">
                      <xsl:with-param name="datum" select="(tei:body//tei:date)[1]/@when"/>
                    </xsl:call-template>
                    <xsl:text>–</xsl:text>
                    <xsl:call-template name="datum">
                      <xsl:with-param name="datum" select="(tei:body//tei:date)[last()]/@when"/>
                    </xsl:call-template>
                  </li>
                  <li>
                    <xsl:value-of select="count(tei:body//tei:date)"/>
                    <xsl:text> Einträge</xsl:text>
                  </li>
                </ul>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
    <div class="infopanel facet">
      <ul class="controls">
        <li>
          <a class="fa fa-print" href="javascript:print()"> Drucken</a>
        </li>
      </ul>
    </div>
  </xsl:template>

  <!--<xsl:template match="*[following-sibling::tei:note[@type = 'annotation'][1][generate-id(preceding-sibling::tei:*[not(self::tei:note)][1]) = generate-id(current())]]" priority="10">
    <xsl:variable name="number">
      <xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+count(preceding::tei:note[@type ='annotation'])+count(preceding::tei:surplus)+1"/>
    </xsl:variable>
    <xsl:variable name="local-name">div</xsl:variable>
    <xsl:element name="{$local-name}">
      <xsl:attribute name="class">annotation</xsl:attribute>
<!-\-      <a href="#{generate-id(following-sibling::tei:note[@type = 'annotation'][1])}" class="fa fa-hand-o-right annotation-reference"></a>-\->
      <!-\-<a href="javascript:void(0);" class="fa fa-hand-o-right annotation-reference"><xsl:value-of select="$number"/></a>-\->
      <xsl:apply-templates select="following-sibling::tei:note[@type = 'annotation'][1]" mode="annotation"/>      
      <xsl:apply-imports/>
      <a href="javascript:void(0);" class="fa annotation-reference"><xsl:value-of select="$number"/></a>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="*[following-sibling::tei:note[@type = 'footnote'][1][generate-id(preceding-sibling::tei:*[not(self::tei:note)][1]) = generate-id(current())]]" priority="10">
    <xsl:variable name="number">
      <xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+count(preceding::tei:note[@type ='annotation'])+count(preceding::tei:surplus)+1"/>
    </xsl:variable>
    <xsl:variable name="local-name">div</xsl:variable>
    <xsl:element name="{$local-name}">
      <xsl:attribute name="class">annotation</xsl:attribute>
<!-\-      <a href="#{generate-id(following-sibling::tei:note[@type = 'footnote'][1])}" class="fa fa-hand-o-right annotation-reference"></a>-\->
      <!-\-<a href="javascript:void(0);" class="fa fa-hand-o-right annotation-reference"><xsl:value-of select="$number"/></a>-\->
      <xsl:apply-templates select="following-sibling::tei:note[@type = 'footnote'][1]" mode="annotation"/>
      <xsl:apply-imports/>
      <a href="javascript:void(0);" class="fa annotation-reference"><xsl:value-of select="$number"/></a>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="*[following-sibling::tei:surplus[1][generate-id(preceding-sibling::tei:*[not(self::tei:note)][1]) = generate-id(current())]]" priority="10">
    <xsl:variable name="number">
      <xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+count(preceding::tei:note[@type ='annotation'])+count(preceding::tei:surplus)+1"/>
    </xsl:variable>
    <xsl:variable name="local-name">div</xsl:variable>
    <xsl:element name="{$local-name}">
      <xsl:attribute name="class">annotation</xsl:attribute>
<!-\-      <a href="#{generate-id(following-sibling::tei:note[@type = 'footnote'][1])}" class="fa fa-hand-o-right annotation-reference"></a>-\->
      <!-\-<a href="javascript:void(0);" class="fa fa-hand-o-right annotation-reference"><xsl:value-of select="$number"/></a>-\->
      <xsl:apply-templates select="following-sibling::tei:surplus[1]" mode="annotation"/>      
      <xsl:apply-imports/>
      <a href="javascript:void(0);" class="fa annotation-reference"><xsl:value-of select="$number"/></a>
    </xsl:element>
  </xsl:template>-->

  <xsl:template match="*[following-sibling::tei:note[@type = 'translation'][1][generate-id(preceding-sibling::tei:*[not(self::tei:note)][1]) = generate-id(current())]]">
    <span title="{following-sibling::tei:note[@type = 'translation'][1]}">
      <xsl:apply-imports/>
    </span>
  </xsl:template>

  <!--<xsl:template match="tei:note[@type = 'annotation']">
    <xsl:variable name="number">
      <xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+count(preceding::tei:note[@type ='annotation'])+count(preceding::tei:surplus)+1"/>
    </xsl:variable>
    <xsl:variable name="local-name">span</xsl:variable>
    <xsl:element name="{$local-name}">
      <xsl:attribute name="class">annotation</xsl:attribute>
    <span id="{generate-id()}" class="annotation-target margin-right">
      <span class="fnnumber"><xsl:value-of select="$number"/></span>
      <xsl:apply-templates/>
    </span>
      <xsl:apply-imports/>
      <a href="javascript:void(0);" class="fa annotation-reference"><xsl:value-of select="$number"/></a>
    </xsl:element>
  </xsl:template>-->
  
  <xsl:template match="tei:note[@type='annotation']">
    <xsl:variable name="number">
      <xsl:call-template name="annumber" />
    </xsl:variable>
    <a href="#an{$number}" name="ana{$number}" title="{normalize-space(.)}" class="annotation-reference"><xsl:value-of select="$number"/></a>
  </xsl:template>
  
  <xsl:template match="tei:surplus">
    <xsl:variable name="number">
      <xsl:call-template name="annumber" />
    </xsl:variable>
    <a href="#an{$number}" name="ana{$number}" title="Im Original steht überflüssiges {normalize-space(.)}." class="annotation-reference"><xsl:value-of select="$number"/></a>
  </xsl:template>
  
  <xsl:template match="tei:note[@type='footnote']">
    <xsl:variable name="number">
      <xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+1"/>
    </xsl:variable>
    <a href="#fn{$number}" name="fna{$number}" title="{normalize-space(.)}" class="annotation-reference"><xsl:value-of select="$number"/></a>
  </xsl:template>
  
  <!--<xsl:template match="tei:surplus">
    <xsl:variable name="number">
      <xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+count(preceding::tei:note[@type ='annotation'])+count(preceding::tei:surplus)+1"/>
    </xsl:variable>
    <xsl:variable name="local-name">span</xsl:variable>
    <xsl:element name="{$local-name}">
      <xsl:attribute name="class">annotation</xsl:attribute>
    <span id="{generate-id()}" class="annotation-target margin-right">
      <span class="fnnumber"><xsl:value-of select="$number"/></span>
      Im Original steht überflüssiges <xsl:apply-templates/>.
    </span>
      <xsl:apply-imports/>
      <a href="javascript:void(0);" class="fa annotation-reference"><xsl:value-of select="$number"/></a>
    </xsl:element>
  </xsl:template>-->
  
  <!--<xsl:template match="tei:note[@type = 'footnote']">
    <xsl:variable name="number">
      <xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+count(preceding::tei:note[@type ='annotation'])+count(preceding::tei:surplus)+1"/>
    </xsl:variable>
    <xsl:variable name="local-name">span</xsl:variable>
    <xsl:element name="{$local-name}">
      <xsl:attribute name="class">annotation</xsl:attribute>
    <span id="{generate-id()}" class="annotation-target margin-right">
      <span class="fnnumber"><xsl:value-of select="$number"/></span>
      <xsl:apply-templates/>
    </span>
    <xsl:apply-imports/>
    <a href="javascript:void(0);" class="fa annotation-reference"><xsl:value-of select="$number"/></a>
    </xsl:element>
  </xsl:template>-->

</xsl:transform>
