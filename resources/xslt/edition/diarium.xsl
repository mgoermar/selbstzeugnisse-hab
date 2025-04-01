<xsl:transform version="1.0"
               exclude-result-prefixes="tei"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../default.xsl"/>
  <xsl:import href="diarium-import.xsl"/>

  <xsl:output method="html" encoding="utf-8" indent="yes"/>
  

  <xsl:template match="tei:text[child::tei:group]">
    <nav role="navigation">
      <xsl:call-template name="navigation"/>
    </nav>
    <!--<a class="printer" href="#"></a>-->
    <div class="content">
      <div class="contentWrap">
        <h1><xsl:value-of select="ancestor::tei:TEI/tei:teiHeader/descendant::tei:title"/></h1>
      <p>
        <xsl:for-each select="ancestor::tei:TEI/tei:teiHeader/descendant::tei:titleStmt/tei:respStmt">
          <xsl:value-of select="tei:resp"/>
          <xsl:text>: </xsl:text>
          <xsl:for-each select="tei:persName">
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="position()!=last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="tei:name">
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="position()!=last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
          <xsl:text>. </xsl:text>          
        </xsl:for-each>
        <xsl:for-each select="ancestor::tei:TEI/tei:teiHeader/descendant::tei:publicationStmt">
          <xsl:value-of select="tei:pubPlace"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="tei:date"/>
          <xsl:text>.</xsl:text>
        </xsl:for-each>
      </p>
        <xsl:if test="ancestor::tei:TEI/tei:teiHeader/descendant::tei:revisionDesc[normalize-space()='work in progress']">
          <xsl:for-each select="ancestor::tei:TEI/tei:teiHeader/descendant::tei:revisionDesc">
            <p>Hinweis: Die Editionen im Projekt Grand Tour digital befinden sich derzeit im Aufbau und werden sukzessive auf dieser Seite veröffentlicht. Für nähere Informationen zum Projektfortschritt besuchen Sie auch den projektbegleitenden <a href="https://grandtourdig.hypotheses.org/">Blog</a>.</p>
          </xsl:for-each>          
        </xsl:if>
        <h2>Einleitungstexte und Register</h2>
        <div class="menuboxes">
          <ul>
          
            <xsl:choose>
              <!--++++++++++++++++++ Selbstzeugnisse II +++++++++++++++++++-->
              <xsl:when test="ancestor::tei:TEI/@xml:id='edition_sz2'">
                <li>
                  <a href="sz2/projektbeschreibung">
                    <div class="sWrap">Einleitung</div>
                    <div class="sWrap"><img src="../assets/imgs/t001.jpg" alt=""/></div>
                  </a>
                </li>
                <li>
                  <a href="sz2/kurzbiographien">
                    <div class="sWrap">Kurzbiographien</div>
                    <div class="sWrap"><img src="../assets/imgs/img004.jpg" alt=""/></div>
                  </a>
                </li>
                <!--<li>
                  <a href="beschreibung">
                    <div class="sWrap">Quellenbeschreibung</div>
                    <div class="sWrap"><img src="../assets/imgs/img002.jpg" alt=""/></div>
                  </a>              
                </li>-->
                <li>
                  <a href="sz2/editionsrichtlinien">
                    <div class="sWrap">Editionsrichtlinien</div>
                    <div class="sWrap"><img src="../assets/imgs/t003.jpg" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="sz2/bibliographie">
                    <div class="sWrap">Bibliographie</div>
                    <div class="sWrap"><img src="../assets/imgs/bibl.png" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="sz2/personen">                
                    <div class="sWrap">Personenregister</div>
                    <div class="sWrap"><img src="../assets/imgs/img005.jpg" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="sz2/orte">
                    <div class="sWrap">Ortsregister</div>
                    <div class="sWrap"><img src="../assets/imgs/t002.jpg" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="sz2/literatur">
                    <div class="sWrap">Werkregister</div>
                    <div class="sWrap"><img src="../assets/imgs/bibl_alt.png" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="sz2/geobrowser">
                    <div class="sWrap">Ortsregister (Karte)</div>
                    <div class="sWrap"><img src="../assets/imgs/map.png" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="sz2/itinerar_geobrowser">
                    <div class="sWrap">Itinerar (Karte)</div>
                    <div class="sWrap"><img src="../assets/imgs/map.png" alt=""/></div>
                  </a>              
                </li>                
              </xsl:when>
              <!--++++++++++++++++++ Grand Tour digital +++++++++++++++++++-->
              <xsl:when test="ancestor::tei:TEI/@xml:id='edition_grand_tour'">
                <li>
                  <a href="grand_tour/projektbeschreibung">
                    <div class="sWrap">Einleitung</div>
                    <div class="sWrap"><img src="../assets/imgs/t001.jpg" alt=""/></div>
                  </a>
                </li>   
                <li>
                  <a href="grand_tour/personen">                
                    <div class="sWrap">Personenregister</div>
                    <div class="sWrap"><img src="../assets/imgs/img005.jpg" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="grand_tour/orte">
                    <div class="sWrap">Ortsregister</div>
                    <div class="sWrap"><img src="../assets/imgs/t002.jpg" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="grand_tour/koerperschaften">
                    <div class="sWrap">Körperschaftsregister</div>
                    <div class="sWrap"><img src="../assets/imgs/Dreigesicht.jpg" alt=""/></div>
                  </a>              
                </li>
              </xsl:when>
              <!--++++++++++++++++++ Reisetagebuch August +++++++++++++++++++-->
              <xsl:otherwise>
                <li>
                  <a href="edition/einleitung">
                    <div class="sWrap">Einleitung</div>
                    <div class="sWrap"><img src="../assets/imgs/t001.jpg" alt=""/></div>
                  </a>
                </li>
                <li>
                  <a href="edition/beschreibung">
                    <div class="sWrap">Quellenbeschreibung</div>
                    <div class="sWrap"><img src="../assets/imgs/img002.jpg" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="edition/richtlinien">
                    <div class="sWrap">Editionsrichtlinien</div>
                    <div class="sWrap"><img src="../assets/imgs/t003.jpg" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="edition/personen">                
                    <div class="sWrap">Personenregister</div>
                    <div class="sWrap"><img src="../assets/imgs/img005.jpg" alt=""/></div>
                  </a>              
                </li>
                <li>
                  <a href="edition/orte">
                    <div class="sWrap">Ortsregister</div>
                    <div class="sWrap"><img src="../assets/imgs/t002.jpg" alt=""/></div>
                  </a>              
                </li>
              </xsl:otherwise>
            </xsl:choose>
          
        </ul>
        </div>
        <xsl:for-each select="tei:group">
          <h2><xsl:value-of select="tei:head"/></h2>
          <div class="menuboxes">
            <ul>
              <xsl:for-each select="tei:TEI">
                <li>
                  <xsl:choose>
                    <xsl:when test="@n='Titelseite'">
                      <a href="edition/diarium/front">
                        <div class="sWrap">
                          <xsl:value-of select="@n"/>
                        </div>
                        <div class="sWrap"><img src="{descendant::*/@facs[1]}" alt=""/></div>
                      </a>
                    </xsl:when>                    
                    <xsl:when test="@n='Einleitung' and contains(@xml:id,'sz2.')">
                      <a href="sz2/{substring-after(@xml:id,'sz2.')}">
                        <div class="sWrap">
                          <xsl:value-of select="@n"/>
                        </div>
                        <div class="sWrap"><img src="{substring-before(descendant::tei:text/descendant::tei:ref[text()='Digitalisat']/@target,'/start.htm')}/min/00001.jpg" alt=""/></div>
                      </a>
                    </xsl:when>    
                    <xsl:when test="not(@n='Einleitung') and contains(@xml:id,'sz2.')">
                      <a href="sz2/{substring-after(@xml:id,'sz2.')}">
                        <div class="sWrap">
                          <xsl:value-of select="@n"/>
                        </div>
                        <div class="sWrap"><img src="http://diglib.hab.de/mss/{substring-before(substring-after(descendant::*/@facs[1], '_'),'_')}/min/{substring-after(substring-after(descendant::*/@facs[1],'_'),'_')}.jpg" alt=""/></div>
                      </a>
                    </xsl:when>
                    <xsl:when test="@n='Einleitung' and contains(@xml:id,'grand_tour.')">
                      <a href="grand_tour/{substring-after(@xml:id,'grand_tour.')}">
                        <div class="sWrap">
                          <xsl:value-of select="@n"/>
                        </div>
                        <div class="sWrap"><img src="{substring-before(descendant::tei:text/descendant::tei:ref[text()='Digitalisat']/@target,'/start.htm')}/min/00001.jpg" alt=""/></div>
                      </a>
                    </xsl:when>
                    <xsl:when test="not(@n='Einleitung') and contains(@xml:id,'grand_tour.')">
                      <a href="grand_tour/{substring-after(@xml:id,'grand_tour.')}">
                        <div class="sWrap">
                          <xsl:value-of select="@n"/>
                        </div>
                        <div class="sWrap"><img src="http://diglib.hab.de/mss/{substring-before(substring-after(descendant::*/@facs[1], '_'),'_')}/min/{substring-after(substring-after(descendant::*/@facs[1],'_'),'_')}.jpg" alt=""/></div>
                      </a>
                    </xsl:when>
                    <xsl:when test="@type='edition'">
                      <a href="edition/diarium/{@n}">
                        <div class="sWrap">
                          <xsl:value-of select="@n"/>
                          <xsl:text> – </xsl:text>
                          <xsl:value-of select="count(descendant::tei:body//tei:date)"/>
                          <xsl:text> Einträge</xsl:text>
                        </div>
                        <div class="sWrap"><img src="http://diglib.hab.de/mss/42-19-aug-2f/min/{substring-after(descendant::*/@facs[1],'images/')}" alt=""/></div>
                      </a>
                    </xsl:when>
                  </xsl:choose>           
                  
                </li>              
              </xsl:for-each>
              <xsl:if test="contains(./tei:head,'Wagener')">
                <li>
                  <a href="edition/grand_tour/itinerar_wagener.html">
                    <div class="sWrap">
                      Itinerar
                    </div>
                    <div class="sWrap"><img src="../assets/imgs/t002.jpg" alt=""/></div>
                  </a>
                </li>
                <li>
                  <a href="edition/grand_tour/itinerar_wagener_karte_iframe.html">
                    <div class="sWrap">
                      Itinerar (Karte)
                    </div>
                    <div class="sWrap"><img src="../assets/imgs/map.png" alt=""/></div>
                  </a>
                </li>
              </xsl:if>
              <xsl:if test="contains(./tei:head,'Ludwig Rudolf')">
                <li>
                  <a href="edition/grand_tour/itinerar_ludwig_rudolf.html">
                    <div class="sWrap">
                      Itinerar
                    </div>
                    <div class="sWrap"><img src="../assets/imgs/t002.jpg" alt=""/></div>
                  </a>
                </li>
                <li>
                  <a href="edition/grand_tour/itinerar_ludwig_rudolf_karte_iframe.html">
                    <div class="sWrap">
                      Itinerar (Karte)
                    </div>
                    <div class="sWrap"><img src="../assets/imgs/map.png" alt=""/></div>
                  </a>
                </li>
              </xsl:if>
            </ul>
          </div>      
        </xsl:for-each>      
        
    </div>
    </div>
  </xsl:template>

  <!--<xsl:template match="*[following-sibling::tei:note[@type = 'annotation'][1][generate-id(preceding-sibling::tei:*[not(self::tei:note)][1]) = generate-id(current())]]" priority="10">
    <xsl:variable name="local-name">span</xsl:variable>
    <xsl:element name="{$local-name}">
      <xsl:attribute name="class">annotation</xsl:attribute>
      <!-\-<a class="fa fa-hand-o-right annotation-reference"></a>-\->
<!-\-      <a href="#{generate-id(following-sibling::tei:note[@type = 'annotation'][1])}" class="fa fa-hand-o-right annotation-reference"></a>-\->
      <a href="javascript:void()"><xsl:apply-imports/></a>
      <xsl:apply-templates select="following-sibling::tei:note[@type = 'annotation'][1]" mode="annotation"/>
    </xsl:element>
  </xsl:template>-->

  <!--<xsl:template match="*[following-sibling::tei:note[@type = 'translation'][1][generate-id(preceding-sibling::tei:*[not(self::tei:note)][1]) = generate-id(current())]]">
    <span title="{normalize-space(following-sibling::tei:note[@type = 'translation'][1])}">
      <xsl:apply-imports/>
    </span>
  </xsl:template>-->

  <!--<xsl:template match="tei:note[@type = 'annotation']" mode="annotation">
    <span class="annotation-target margin-right">
<!-\-    <span id="{generate-id()}" class="annotation-target margin-right">-\->
      <span class="fa fa-sticky-note-o pull-right"></span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->
  
  <xsl:template match="tei:note[@type='annotation']">
    <xsl:variable name="number">
      <xsl:call-template name="annumber" />
    </xsl:variable>
    <a href="#an{$number}" name="ana_{$number}" title="{normalize-space(.)}" class="note"><xsl:value-of select="$number"/></a>
  </xsl:template>
  
  <xsl:template match="tei:surplus">
    <xsl:variable name="number">
      <xsl:call-template name="annumber" />
    </xsl:variable>
    <a href="#an{$number}" name="ana_{$number}" title="Im Original steht überflüssiges {normalize-space(.)}." class="note"><xsl:value-of select="$number"/></a>
  </xsl:template>
  
  <xsl:template match="tei:note[@type='footnote']">
    <xsl:variable name="number">
      <xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+1"/>
    </xsl:variable>
    <a href="#fn{$number}" name="fna_{$number}" title="{normalize-space(.)}" class="note"><xsl:value-of select="$number"/></a>
  </xsl:template>

  <!--<xsl:template match="text()" mode="annotation"/>-->

</xsl:transform>
