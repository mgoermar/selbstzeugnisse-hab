<xsl:transform version="1.0"
               exclude-result-prefixes="tei"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:param name="q"/>
  <xsl:key name="entity-ref" match="tei:rs[@ref][not(contains(@ref, ' '))]" use="substring(@ref,2)"/>
  <xsl:key name="term-ref" match="tei:term" use="substring(@ref, 2)"/>

  <tei:index>
    <tei:term key="&#x263D;">Montag</tei:term>
    <tei:term key="&#x2642;">Dienstag</tei:term>
    <tei:term key="&#x263F;">Mittwoch</tei:term>
    <tei:term key="&#x2643;">Donnerstag</tei:term>
    <tei:term key="&#x2640;">Freitag</tei:term>
    <tei:term key="&#x2644;">Samstag</tei:term>
    <tei:term key="&#x2609;">Sonntag</tei:term>
  </tei:index>

  <xsl:template match="tei:text/tei:body">
    <div class="navigation navigation-collapse">
      <span class="fa fa-lg fa-navicon"></span>
      <xsl:call-template name="navigation"/>
    </div>

    <div class="mainpage diarium">

      <div class="pagination" style="margin-bottom: 2em;">
        <xsl:call-template name="paginator"/>
        <div style="padding: .5em 0;">
          Herzog August der Jüngere von Braunschweig-Wolfenbüttel (1579-1666): Ephemerides. Sive Diarium
          (1594-1635). Herzog August Bibliothek, Signatur: Cod. Guelf. 42.19 Aug. 2°
        </div>
      </div>

      <div style="clear: both; border-right: thin solid; padding-right: 2.5em; ">
        <xsl:apply-templates/>
      </div>

      <div class="pagination" style="margin-bottom: 2em;">
        <xsl:call-template name="paginator"/>
      </div>
      
      <div id="info_gloss">
        <xsl:apply-templates mode="gloss"/>
      </div>
      <div id="info_person">
        <xsl:apply-templates select="//tei:person"/>
      </div>
      <div id="info_place">
        <xsl:apply-templates select="//tei:place"/>
      </div>
      <div id="info_org">
        <xsl:apply-templates select="//tei:org"/>
      </div>
      <div id="info_bibl">
        <xsl:apply-templates select="//tei:bibl"/>
      </div>

    </div>
    <div class="infopanel diarium">
      <ul class="controls">
        <li><a class="fa fa-print" href="javascript:print()"> Drucken</a></li>
      </ul>
      <div class="facsimile" style="display: none;">
        <a class="fa fa-close pull-right" title="Ansicht schließen"></a>
        <a id="facsimile" href="#" target="_facsimile">
          <img/>
        </a>
      </div>
      <script type="text/javascript">
        $(document).ready(function () {
          adjust('span.margin-left');
          adjust('span.margin-right');
          $('.facsimile img').load(function () { $('#facsimile').zoom(); });
        });
      </script>
    </div>
  </xsl:template>

  <xsl:template match="tei:title">
    <h1><xsl:apply-templates/></h1>
  </xsl:template>

  <xsl:template match="tei:*[ancestor::tei:body]" priority="-50">
    <span class="error">
      <xsl:value-of select="concat('&lt;', name(), '&gt;')"/>
      <xsl:apply-templates/>
      <xsl:value-of select="concat('&lt;/', name(), '&gt;')"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:note" priority="-10"/>

  <xsl:template match="tei:head[not(tei:date)]">
    <xsl:call-template name="pagebreak"/>
    <h1>
      <xsl:if test="@place">
        <xsl:attribute name="class">margin-left</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>

  <xsl:template match="tei:head[tei:date] | tei:label[tei:date]">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>

  <xsl:template match="tei:date">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:ex">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <xsl:template match="tei:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="tei:div">
    <div>
      <xsl:if test="@xml:id"><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute></xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="tei:foreign">
    <span lang="{@xml:lang}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:seg">
    <span><xsl:apply-templates/></span>
  </xsl:template>

  <!--<xsl:template match="tei:rs[@type = 'person'][@ref != '']">
    <a class="ref-{@type}" title="{document(@ref)/tei:persName}" href="../personen#{substring-after(@ref, '#')}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="tei:rs[@type = 'place'][@ref != '']">
    <a class="ref-{@type}" title="{document(@ref)/tei:placeName}" href="../orte#{substring-after(@ref, '#')}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="tei:rs">
    <xsl:apply-templates/>
  </xsl:template>-->
  
  <xsl:template match="tei:rs">
    <xsl:variable name="id" select="generate-id()"/>
        <xsl:choose>
          <xsl:when test="@type='abbreviation'">
            <a href="#" class="tooltip">
              <span class="custom info">
                <xsl:value-of select="//tei:list/tei:item[@xml:id =substring(current()/@ref,2)]/*[position()=1]"/>
              </span>
              <xsl:apply-templates/>
            </a>
          </xsl:when>
          <xsl:when test="@type='symbol'">
            <a href="#" class="tooltip">
              <span class="custom info">
                <xsl:value-of select="//tei:list/tei:item[@xml:id =substring(current()/@ref,2)]/*"/>
              </span>
              <xsl:apply-templates/>
            </a>
          </xsl:when>
          
          <xsl:when test="@type='person' or @type='place' or @type='org' or @type='bibl'">
            <xsl:apply-templates>
              <xsl:with-param name="id" select="$id"/>
              <xsl:with-param name="ref" select="@ref"/>
            </xsl:apply-templates>
          </xsl:when>
          
          <xsl:when test="@type='bibl'">
            <a href="{@ref}" id="{$id}" class="rs-ref">
              <xsl:apply-templates>
                <xsl:with-param name="id" select="$id"/>
              </xsl:apply-templates>
            </a>
          </xsl:when>
          
        </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:rs[@type='person' or @type='place' or @type='org' or @type='bibl']/text()
    | tei:w[parent::tei:rs[@type='person' or @type='place' or @type='org' or @type='bibl']]/text()">
    <xsl:param name="id"/>
    <xsl:param name="ref"/>
    <a href="javascript:void(0)" id="{$id}" class="rs-ref" onclick="showInlineAnnotation(this, '{$ref}');">
      <xsl:choose>
        <xsl:when test="ancestor::tei:w"><xsl:value-of select="normalize-space(.)"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>
  
  <!-- Templateregel zur Erzeugung eines Index-Registers am Seitenende, das via css ausgeblendet wird -->
  
  <!-- Lemma im Glossar, das im Text referenziert wird -->
  <xsl:template match="tei:item[key('term-ref', @xml:id)]" mode="gloss">
    <xsl:variable name="label" select="tei:label"/>
    <xsl:variable name="lemma-id" select="@xml:id"/>
    <xsl:for-each select="tei:list/tei:item">
      <xsl:variable name="id">
        <xsl:call-template name="lemma-gloss-id">
          <xsl:with-param name="lemma-id" select="$lemma-id"/>
          <xsl:with-param name="gloss-n" select="@n"/>
        </xsl:call-template>
      </xsl:variable>
      <div id="{$id}">
        <b>
          <xsl:value-of select="$label"/>
        </b>
        <br/>
        <i>
          <xsl:value-of select="."/>
        </i>
      </div>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="text()" mode="gloss"/>
  
  <!-- ID einer Glosse im Ausgabedokument: f(Lemma-ID, Zählung Glosse) -->
  <xsl:template name="lemma-gloss-id">
    <xsl:param name="lemma-id"/>
    <xsl:param name="gloss-n"/>
    <xsl:value-of select="$lemma-id"/>
    <xsl:text>_</xsl:text>
    <xsl:choose>
      <xsl:when test="string-length($gloss-n) &gt; 0">
        <xsl:value-of select="$gloss-n"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="tei:person">
    <!--<xsl:template match="tei:person[key('entity-ref', @xml:id)]">-->
    <xsl:call-template name="format-person"/>
  </xsl:template>
  
  <!-- Wird mit einem tei:person als Kontextknoten aufgerufen und liefert eine für die Anzeige vorbereitete Übersicht zur Person -->
  <xsl:template name="format-person">
    <div id="{@xml:id}">
      <xsl:attribute name="class">
        <xsl:text>rs-ref</xsl:text>
      </xsl:attribute>
      
      
      <!-- TBD -->
      
      <xsl:for-each select="tei:persName">
        <div>
          <xsl:if test="@type='birthName'">Geburtsname: </xsl:if>
          <!-- falls nur <name> -->
          <xsl:if test="tei:name">
            <span>
              <b>
                <xsl:value-of select="tei:name/."/>
              </b>
            </span>
            <xsl:text> </xsl:text>
          </xsl:if>
          
          <!-- Rollenname -->
          <xsl:if test="tei:roleName">
            <span class="roleName">
              <xsl:value-of select="tei:roleName/."/>
            </span>
            <xsl:text> </xsl:text>
          </xsl:if>
          
          <!-- Vorname -->
          <xsl:if test="tei:forename">
            <span class="forename">
              <b>
                <xsl:value-of select="tei:forename/."/>
              </b>
            </span>
            <xsl:text> </xsl:text>
          </xsl:if>
          
          <!-- Namelink -->
          <xsl:if test="tei:nameLink">
            <span class="nameLink">
              <xsl:value-of select="tei:nameLink/."/>
            </span>
            <xsl:text> </xsl:text>
          </xsl:if>
          
          <!-- Nachname -->
          <xsl:if test="tei:surname">
            <span class="surname">
              <xsl:value-of select="tei:surname/."/>
            </span>
            <xsl:text> </xsl:text>
          </xsl:if>
          
          <!-- addName -->
          <xsl:if test="tei:addName">
            <span>
              <xsl:value-of select="tei:addName/."/>
            </span>
            <xsl:text> </xsl:text>
          </xsl:if>
          
          <!-- Placename -->
          <xsl:if test="tei:placeName">
            <span class="placeName">
              <xsl:value-of select="tei:placeName/."/>
            </span>
            <xsl:text> </xsl:text>
          </xsl:if>
          
          
        </div>
      </xsl:for-each>
      
      <!-- Sonstiges zur Person -->
      <xsl:if test="tei:birth">
        <br/>
        <xsl:text>geb. </xsl:text>
        <span class="birth">
          <xsl:value-of select="tei:birth/."/>
        </span>
      </xsl:if>
      <xsl:if test="tei:death">
        <br/>
        <xsl:text>gest. </xsl:text>
        <span class="death">
          <xsl:value-of select="tei:death/."/>
        </span>
      </xsl:if>
      <xsl:if test="tei:note">
        <br/>
        <xsl:text>Anm.: </xsl:text>
        <span class="note">
          <xsl:value-of select="tei:note/."/>
        </span>
      </xsl:if>			
      
      <xsl:if test="tei:persName[@ref]">
        <br/><br/>
        <xsl:text>Weiterführende Informationen </xsl:text>
        <xsl:choose>
          <!--<xsl:when test="contains(tei:persName/@ref,'gnd')"><xsl:text>in der </xsl:text><a href="{tei:persName/@ref}" target="_blank">DNB</a></xsl:when>-->
          <xsl:when test="contains(tei:persName/@ref,'viaf')"><xsl:text>in </xsl:text><a href="{tei:persName/@ref}" target="_blank">VIAF</a></xsl:when>
          <xsl:when test="contains(tei:persName/@ref,'gnd')">
            <xsl:text>in der </xsl:text>
            <a href="http://beaconfinder.mww-forschung.de/index.php?gnd={substring(tei:persName[@ref]/@ref,22)}" target="_blank">MWW-Personensuche</a>
          </xsl:when>
        </xsl:choose>				
      </xsl:if>
      
      <xsl:if test="tei:listBibl/tei:bibl/tei:ptr[@type='adb']">
        <xsl:text>, </xsl:text>
        <a href="{tei:listBibl/tei:bibl/tei:ptr[@type='adb']/@target}" target="_blank">ADB</a>
      </xsl:if>
      
      <xsl:if test="tei:listBibl/tei:bibl/tei:ptr[@type='ndb']">
        <xsl:text>, </xsl:text>
        <a href="{tei:listBibl/tei:bibl/tei:ptr[@type='ndb']/@target}" target="_blank">NDB</a>
      </xsl:if>
      <xsl:if test="tei:listBibl/tei:bibl/tei:ptr[@type='wg']">
        <xsl:text>, </xsl:text>
        <a href="{tei:listBibl/tei:bibl/tei:ptr[@type='wg']/@target}" target="_blank">Westfälische Geschichte</a>
      </xsl:if>
      <xsl:if test="tei:listBibl/tei:bibl/tei:ptr[@type='hb']">
        <xsl:text>, </xsl:text>
        <a href="{tei:listBibl/tei:bibl/tei:ptr[@type='hb']/@target}" target="_blank">Hessische Biographie</a>
      </xsl:if>
      <xsl:if test="tei:listBibl/tei:bibl/tei:ptr[@type='sb']">
        <xsl:text>, </xsl:text>
        <a href="{tei:listBibl/tei:bibl/tei:ptr[@type='sb']/@target}" target="_blank">Sächsische Biographie</a>
      </xsl:if>
      <xsl:if test="tei:persName[@ref] and tei:note/tei:rs[@type='org'][@ref='#fruchtbringende_gesellschaft']">
        <xsl:text>, </xsl:text>
        <a href="{concat('http://dbs.hab.de/padmin/fruchtbringer/ausgabe.php?m4=allgemein&amp;st3=&amp;trunc3=%25&amp;m2=gnd&amp;st2=',substring(tei:persName/@ref,22),'&amp;trunc2=%25&amp;m1=mitgliedsnr&amp;st1=&amp;trunc1=%25&amp;submit=&amp;m3=name')}" target="_blank">Mitgliederdatenbank Fruchtbringende Gesellschaft</a>
      </xsl:if>
      
    </div>
  </xsl:template>
  
  
  
  <!-- Wird mit einem tei:org als Kontextknoten aufgerufen und liefert eine für die Anzeige vorbereitete Übersicht zur Organisation -->
  <xsl:template match="tei:org"/>
  <xsl:template match="tei:org[key('entity-ref', @xml:id)]">
    <xsl:call-template name="format-org"/>
    
  </xsl:template>
  <xsl:template name="format-org">
    <div id="{@xml:id}">
      <xsl:attribute name="class">
        <xsl:text>rs-ref</xsl:text>
      </xsl:attribute>
      
      
      <!-- TBD -->
      
      <xsl:if test="tei:orgName">
        <span class="org">
          <xsl:value-of select="tei:orgName/."/>
          <xsl:if test="tei:orgName[@ref]">
            <br/>
            <a href="{tei:orgName/@ref}" target="_blank">weiterführende Informationen </a>
          </xsl:if>
          <xsl:if test="child::tei:note">
            <br/>
            <xsl:text>Anm.:</xsl:text>
            <xsl:text> </xsl:text>
            <xsl:value-of select="child::tei:note"/>
          </xsl:if>
        </span>
        <xsl:text> </xsl:text>
      </xsl:if>
    </div>
  </xsl:template>
  
  <!-- Templateregel zur Erzeugung eines Index-Registers am Seitenende, das via css ausgeblendet wird -->
  
  <xsl:template match="tei:place">
    <xsl:call-template name="format-place"/>
  </xsl:template>
  
  <!-- Wird mit einem tei:place als Kontextknoten aufgerufen und liefert eine für die Anzeige vorbereitete Übersicht zum Ort -->
  <xsl:template name="format-place">
    <div id="{@xml:id}" class="rs-ref">
      <!-- TBD -->
      <xsl:if test="tei:placeName">
        <span class="placeName">
          <xsl:value-of select="tei:placeName/."/>
          <xsl:if test="tei:placeName[@ref]">
            <br/>
            <a href="{tei:placeName/@ref}" target="_blank">weiterführende Informationen </a>
          </xsl:if>
        </span>
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:if test="tei:note">
        <br/>
        <xsl:text>Anm.: </xsl:text>
        <span class="note">
          <xsl:value-of select="tei:note/."/>
        </span>
      </xsl:if>
    </div>
  </xsl:template>
  
  <!-- Bibliographische Verweise aus dem Literaturverzeichnis -->
  
  <xsl:template match="tei:bibl">
    <xsl:call-template name="format-bibl"/>
  </xsl:template>
  
  <xsl:template name="format-bibl">
    <span id="{@xml:id}" class="rs-ref">
      <xsl:apply-templates select="tei:author"/>
      <xsl:apply-templates select="tei:title"/>
      <xsl:apply-templates select="tei:biblScope[@unit='vol']"/>
      <xsl:apply-templates select="tei:editor"/>
      <xsl:apply-templates select="tei:pubPlace"/>
      <xsl:apply-templates select="tei:publisher"/>
      <xsl:apply-templates select="tei:date"/>
      <xsl:apply-templates select="tei:biblScope[@unit='pp']"/>
      <xsl:apply-templates select="tei:series"/>
      <xsl:apply-templates select="tei:title/@ref"/>
    </span>
  </xsl:template>
  
  <xsl:template name="format-name">
    <xsl:choose>
      <xsl:when test="@ref">
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:text>http://diglib.hab.de/edoc/ed000228/register/listPerson.html</xsl:text>
            <xsl:value-of select="@ref"/>
          </xsl:attribute>
          <xsl:if test="tei:name">
            <span style="font-variant: small-caps;" class="author">
              <xsl:apply-templates select="tei:name"/>
            </span>
          </xsl:if>
          <xsl:if test="tei:roleName">
            <xsl:apply-templates select="tei:roleName"/>
          </xsl:if>
          <xsl:if test="tei:forename">
            <xsl:if test="not(preceding-sibling::tei:roleName)">
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="contains(tei:roleName,'König') or contains(tei:roleName, 'Kaiser') or contains(tei:roleName, 'Papst')">
                <span style="font-variant: small-caps;" class="editor">
                  <xsl:apply-templates select="tei:forename"/>
                </span>                                
              </xsl:when>
              <xsl:otherwise> 
                <xsl:apply-templates select="tei:forename"/>                                
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:if test="tei:nameLink">
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="tei:nameLink"/>
          </xsl:if>
          <xsl:if test="tei:surname">
            <xsl:text> </xsl:text>
            <xsl:choose>
              <xsl:when test="contains(tei:roleName,'König') or contains(tei:roleName, 'Kaiser')">
                <xsl:apply-templates select="tei:surname"/>
              </xsl:when>
              <xsl:otherwise>
                <span style="font-variant: small-caps;" class="editor">
                  <xsl:apply-templates select="tei:surname"/>
                </span>
              </xsl:otherwise>
            </xsl:choose>                        
          </xsl:if>
          <xsl:if test="tei:addName[not(@type='pseudonym')]">
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="tei:addName"/>
          </xsl:if>
          <xsl:if test="tei:addName[@type='pseudonym']">
            <xsl:text> [=</xsl:text>
            <xsl:apply-templates select="tei:addName"/>
            <xsl:text>]</xsl:text>
          </xsl:if>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="tei:name">
          <span style="font-variant: small-caps;" class="author">
            <xsl:apply-templates select="tei:name"/>
          </span>
        </xsl:if>
        <xsl:if test="tei:roleName">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="tei:roleName"/>
        </xsl:if>
        <xsl:if test="tei:forename">
          <xsl:if test="not(preceding-sibling::tei:roleName)">
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="contains(tei:roleName,'König') or contains(tei:roleName, 'Kaiser') or contains(tei:roleName, 'Papst')">
              <span style="font-variant: small-caps;" class="editor">
                <xsl:apply-templates select="tei:forename"/>
              </span>                                
            </xsl:when>
            <xsl:otherwise> 
              <xsl:apply-templates select="tei:forename"/>                                
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="tei:nameLink">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="tei:nameLink"/>
        </xsl:if>
        <xsl:if test="tei:surname">
          <xsl:text> </xsl:text>
          <xsl:choose>
            <xsl:when test="contains(tei:roleName,'König') or contains(tei:roleName, 'Kaiser')">
              <xsl:apply-templates select="tei:surname"/>
            </xsl:when>
            <xsl:otherwise>
              <span style="font-variant: small-caps;" class="editor">
                <xsl:apply-templates select="tei:surname"/>
              </span>
            </xsl:otherwise>
          </xsl:choose>                        
        </xsl:if>
        <xsl:if test="tei:addName[not(@type='pseudonym')]">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="tei:addName"/>
        </xsl:if>
        <xsl:if test="tei:addName[@type='pseudonym']">
          <xsl:text> [=</xsl:text>
          <xsl:apply-templates select="tei:addName"/>
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:editor">
    <xsl:if test="not(preceding-sibling::tei:editor)">
      <xsl:text>hg. von</xsl:text>
    </xsl:if>
    <xsl:call-template name="format-name"/>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:editor[following-sibling::tei:editor]">
    <xsl:if test="not(preceding-sibling::tei:editor)">
      <xsl:text>hg. von</xsl:text>
    </xsl:if>
    <xsl:call-template name="format-name"/>
    <xsl:text> / </xsl:text>        
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:editor[@role='translator']">
    <xsl:if test="not(preceding-sibling::tei:editor[@role='translator'])">
      <xsl:text>übers. von</xsl:text>
    </xsl:if>
    <xsl:call-template name="format-name"/>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:editor[following-sibling::tei:editor][@role='translator']">
    <xsl:if test="not(preceding-sibling::tei:editor[@role='translator'])">
      <xsl:text>übers. von</xsl:text>
    </xsl:if>
    <xsl:call-template name="format-name"/>
    <xsl:text> / </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:author">
    <xsl:call-template name="format-name"/>        
    <xsl:text>: </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:author[following-sibling::tei:author]">
    <xsl:call-template name="format-name"/>
    <xsl:text> / </xsl:text>                
  </xsl:template>	
  
  <xsl:template match="tei:bibl//tei:title[@level='m']">
    <xsl:apply-templates/>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:title[@level='a']">
    <xsl:apply-templates/>
    <xsl:text>, in: </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:title[@type='short']">
    <span style="font-variant: small-caps;"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:title/@ref">
    <xsl:text> [Nachweis im </xsl:text>
    <a>
      <xsl:attribute name="href">
        <xsl:text>https://kxp.k10plus.de/DB=2.1/PPNSET?PPN=</xsl:text>
        <xsl:value-of select="substring-after(.,'_')"/>
      </xsl:attribute>
      <xsl:text>GVK</xsl:text>
    </a>
    <xsl:text>] </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:bibl">
    <xsl:text> in: </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:pubPlace">
    <xsl:apply-templates/>
    <xsl:text>: </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:publisher">
    <xsl:apply-templates/>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:date">
    <xsl:apply-templates/>
    <xsl:if test="not(../tei:biblScope[@unit='pp'])"><xsl:text>. </xsl:text></xsl:if>
  </xsl:template>
  
  
  <xsl:template match="tei:bibl//tei:biblScope[@unit='pp']">
    <xsl:if test="../tei:date"><xsl:text>, S. </xsl:text></xsl:if>
    <xsl:apply-templates/>
    <xsl:text>.</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:biblScope[@unit='cols']">
    <xsl:if test="../tei:date"><xsl:text>, Sp. </xsl:text></xsl:if>
    <xsl:apply-templates/>
    <xsl:text>.</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:biblScope[@unit='vol']">
    <xsl:text>Bd. </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:series">
    <xsl:text> (</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>)</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:bibl//tei:abbr"/>
  
  <xsl:template match="tei:bibl/tei:title[@type='short']"/>
  
  <xsl:template match="tei:term[not(parent::tei:index[@indexName='regest'])]">
    <xsl:variable name="lemma-gloss-id">
      <xsl:call-template name="lemma-gloss-id">
        <xsl:with-param name="lemma-id" select="substring(@ref, 1)"/>
        <xsl:with-param name="gloss-n" select="@n"/>
      </xsl:call-template>
    </xsl:variable>
    <a href="javascript:void(0)" class="rs-ref" onclick="showInlineAnnotation(this, '{$lemma-gloss-id}');">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="tei:l">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>
  
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <xsl:template match="tei:lg">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="tei:unclear">
    <span class="unclear"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:w">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:del">
    <del><xsl:apply-templates/></del>
  </xsl:template>

  <xsl:template match="tei:add">
    <span><sup>+</sup><xsl:apply-templates/><sup>+</sup></span>
  </xsl:template>

  <xsl:template match="tei:c | tei:subst">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tei:c[. = document('')//tei:term/@key]">
    <span title="{document('')//tei:term[@key = current()]}" class="symbol">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="tei:hi[@rend = 'underline']">
    <u><xsl:apply-templates/></u>
  </xsl:template>

  <xsl:template match="tei:hi[@rend = 'superscript' or @rend = 'super']">
    <sup><xsl:apply-templates/></sup>
  </xsl:template>

  <xsl:template match="tei:note[@place]" priority="10">
    <span class="margin-left"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:seg[@rend = 'august']">
    <span class="cipher"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:ref[@target]">
    <a href="{@target}" target="_blank">
      <xsl:choose>
        <xsl:when test="normalize-space(translate(., 'WIKIPEDIA', 'wikipedia')) = 'wikipedia'">
          <span class="fa fa-wikipedia-w"></span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>

  <xsl:template match="tei:pb">
    <xsl:call-template name="pagebreak"/>
  </xsl:template>

  <xsl:template match="tei:list|tei:listPerson">
    <ul><xsl:apply-templates/></ul>
  </xsl:template>

  <xsl:template match="tei:item[parent::tei:list or parent::tei:listPerson]">
    <li><xsl:apply-templates/></li>
  </xsl:template>

  <xsl:template name="pagebreak">
    <xsl:if test="@facs">
      <a class="pagebreak screen-only" target="_facsimile" href="{@facs}" style="position: absolute; left: 15em;">
        <span class="fa fa-file-o"> <xsl:value-of select="@n"/> </span>
      </a>
    </xsl:if>
  </xsl:template>

  <xsl:template name="paginator">
    <div style="float: right; margin-left: 2em;">
      <xsl:if test="/tei:TEI/@prev">
        <a href="{substring-before(/tei:TEI/@prev, '.xml')}" class="prev screen-only">
          <xsl:choose>
            <xsl:when test="/tei:TEI/@prev = 'front.xml'">Titelseite</xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="substring-before(/tei:TEI/@prev, '.xml')"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:if>
      <h1><xsl:value-of select="/tei:TEI/@n"/></h1>
      <xsl:if test="/tei:TEI/@next">
        <a href="{substring-before(/tei:TEI/@next, '.xml')}" class="next screen-only">
          <xsl:value-of select="substring-before(/tei:TEI/@next, '.xml')"/>
        </a>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:milestone"/>

</xsl:transform>
