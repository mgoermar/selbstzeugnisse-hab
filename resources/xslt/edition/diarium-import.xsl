<!--von David Maus erstellt; ab Januar 2021 von Maximilian Görmar überarbeitet-->
<xsl:transform version="1.0"
    exclude-result-prefixes="tei"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:param name="cRef-biblical-start"><xsl:text>http://www.biblija.net/biblija.cgi?m=</xsl:text></xsl:param>
    <xsl:param name="cRef-biblical-end_de"><xsl:text>&amp;id12=1&amp;id8=1&amp;set=1</xsl:text></xsl:param>
    
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
        <nav role="navigation">
            <xsl:call-template name="navigation"/>
        </nav>
        <a class="printer" href="javascript:print()"></a>
        <div class="content">
            <div class="pageWrap">
                <div class="diarium">
                    <div class="pagination" style="margin-bottom: 2em;">
                        <xsl:call-template name="paginator"/>                
                    </div>
                    <div class="intro">
                        <p>
                            <!--Herzog August der Jüngere von Braunschweig-Wolfenbüttel (1579-1666): Ephemerides. Sive Diarium
                            (1594-1635). Herzog August Bibliothek, Signatur: Cod. Guelf. 42.19 Aug. 2°-->
                            <xsl:value-of select="ancestor::tei:TEI/tei:teiHeader/descendant::tei:sourceDesc/tei:bibl"/>
                        </p>                    
                    </div>
                    <xsl:apply-templates/>
                    <div id="annotation">
                        <xsl:if test="//tei:note[@type='annotation'] | //tei:note[@type='footnote'] | //tei:handShift | //tei:choice | //tei:restore | //tei:surplus">
                            <hr/>
                            <b>Anmerkungen</b>
                        </xsl:if>
                        <div>							
                            <xsl:for-each select="//tei:note[@type='annotation'] | //tei:surplus">
                                <xsl:variable name="footnotenumber">
                                    <xsl:call-template name="annumber"/>
                                </xsl:variable>
                                <div style="padding-left: 1em; text-indent: -1em;">
                                    <a name="an{$footnotenumber}" href="#ana_{$footnotenumber}">
                                        <!--<xsl:attribute name="style">
                    <xsl:text>color: blue; font-size: 0.7em; margin-right: 0.3em; vertical-align: super;</xsl:text>
                  </xsl:attribute>-->
                                        <span class="note"><xsl:value-of select="$footnotenumber"/><xsl:text> </xsl:text></span>                  
                                    </a>
                                    <xsl:choose>
                                        <xsl:when test="self::tei:note">
                                            <xsl:apply-templates/>
                                        </xsl:when>
                                        <xsl:when test="self::tei:surplus">													
                                            Im Original steht überflüssiges "<xsl:value-of select="."/>".
                                        </xsl:when>
                                    </xsl:choose>										
                                </div>
                            </xsl:for-each>
                        </div>
                        <xsl:if test="//tei:note[@type='footnote']">
                            <hr/>
                            <!--<b>Anmerkungen</b>-->
                        </xsl:if>
                        <div>							
                            <xsl:for-each select="//tei:note[@type='footnote']">
                                <xsl:variable name="footnotenumber">
                                    <xsl:number level="any" count="tei:note[@type ='footnote']"/>
                                </xsl:variable>
                                <div style="padding-left: 1em; text-indent: -1em;">
                                    <a name="fn{$footnotenumber}" href="#fna_{$footnotenumber}">
                                        <!--<xsl:attribute name="style">
                    <xsl:text>color: blue; font-size: 0.7em; margin-right: 0.3em; vertical-align: super;</xsl:text>
                  </xsl:attribute>-->
                                        <span class="note"><xsl:value-of select="$footnotenumber"/><xsl:text> </xsl:text></span>                  
                                    </a>
                                    <xsl:apply-templates/>										
                                </div>
                            </xsl:for-each>
                        </div>
                        
                    </div>
                    
                    <div class="pagination" style="margin-bottom: 2em;">
                        <xsl:call-template name="paginator"/>
                    </div>
                    
                    
                </div>
                
            </div>
            </div>
        
        <div class="infopanel">
            <div class="facet">
                <div class="facetWrap">
                    <h1>Schnellauswahl</h1>
                    <xsl:if test="starts-with(ancestor::tei:TEI/@xml:id,'sz2.')">
                        <form>
                            <label for="pages">Seite/Blatt: </label>
                            <select name="pages" id="pages" onchange="window.location.hash = value;">
                                <xsl:for-each select="descendant::tei:pb">
                                    <option value="{@n}"><xsl:value-of select="@n"/></option>
                                </xsl:for-each>
                            </select>
                        </form>
                    </xsl:if>                    
                    <xsl:if test="descendant::tei:date">
                        <form>
                            <label for="dates">Datum: </label>
                            <select name="dates" id="dates" onchange="window.location.hash = value;">
                                <xsl:for-each select="descendant::tei:date">
                                    <xsl:sort select="@when"/>
                                    <xsl:choose>
                                        <xsl:when test="@when=preceding::tei:date/@when or @when=following::tei:date/@when">
                                            <option value="{concat(@when,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="concat(substring(@when,9,2),'.',substring(@when,6,2),'.',substring(@when,1,4),' (S. ',preceding::tei:pb[1]/@n,')' )"/></option>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <option value="{concat(@when,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="concat(substring(@when,9,2),'.',substring(@when,6,2),'.',substring(@when,1,4))"/></option>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    
                                </xsl:for-each>
                            </select>
                        </form>
                    </xsl:if>
                    <a href="#">Zurück zum Seitenanfang</a>
                </div>
                
            </div>
            <div class="facsimile">
                <a class="fa fa-close pull-right" title="Ansicht schließen"></a>
                <a id="facsimile" href="#" target="_facsimile">
                    <img/>
                </a>
            </div>
            <script type="text/javascript">
                $(document).ready(function () {
                <!--adjust('span.margin-left');
                adjust('span.margin-right');-->
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
    
    <xsl:template match="tei:note[parent::tei:person]">
        <xsl:apply-templates/>
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
        <span style="font-weight: bold;" id="{concat(@when,'_',preceding::tei:pb[1]/@n)}">
            <xsl:apply-templates/>
        </span>        
    </xsl:template>
    
    <xsl:template match="tei:ex">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>   
    
    <xsl:template match="tei:table">
        <table>
            <tbody>
                <xsl:apply-templates/>
            </tbody>      
        </table>
    </xsl:template>
    
    <xsl:template match="tei:row">
        <tr><xsl:apply-templates/></tr>
    </xsl:template>
    
    <xsl:template match="tei:cell">
        <td><xsl:apply-templates/></td>
    </xsl:template>
    
    <xsl:template match="tei:ab">
        <table>
            <tbody>
                <tr>
                    <xsl:for-each select="tei:cb">
                        <td><xsl:apply-templates select="following-sibling::node()[preceding-sibling::tei:cb[1]/@n = current()/@n][not(self::tei:cb)]"/></td>
                    </xsl:for-each>
                </tr>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div>
            <xsl:if test="@xml:id"><xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute></xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:foreign">
        <xsl:choose>
            <xsl:when test="following-sibling::tei:note[1][@type = 'translation']">
                <xsl:variable name="id" select="generate-id(following-sibling::tei:note[@type = 'translation'][1])"/>
                <xsl:variable name="local-name">span</xsl:variable>
                <xsl:element name="{$local-name}">
                    <xsl:attribute name="class">ref</xsl:attribute>
                    <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
                    <span lang="{@xml:lang}" title="{normalize-space(following-sibling::tei:note[@type = 'translation'][1])}">
                        <xsl:apply-templates/>
                    </span></xsl:element>
                    <span id="{$id}" class="ref-gloss-target margin-right">
                        <a href="" class="fa fa-close pull-right" title="Schließen"></a>
                        <span style="font-weight: bold;">Übersetzung:</span>
                        <xsl:text> "</xsl:text>
                        <xsl:value-of select="normalize-space(following-sibling::tei:note[@type = 'translation'][1])"/>
                        <xsl:text>"</xsl:text>
                    </span>
                
            </xsl:when>
            <xsl:otherwise>
                <span lang="{@xml:lang}"><xsl:apply-templates/></span>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    
    <xsl:template match="tei:seg">
        <span><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type = 'person'][@ref != ''][not(contains(@ref,' '))][document(@ref)/tei:persName[@type='display']]">
        <xsl:variable name="id" select="generate-id()"/>
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-{@type}" title="{document(@ref)/tei:persName[@type='display']}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
        </xsl:element>
            <span id="{$id}" class="ref-{@type}-target margin-right">
                <a href="" class="fa fa-close pull-right" title="Schließen"></a>
                <xsl:for-each select="document(@ref)/tei:persName[@type='display']">
                    <span style="font-weight: bold;">
                        <xsl:value-of select="."/>
                        <xsl:choose>
                            <xsl:when test="following-sibling::tei:birth and following-sibling::tei:death">
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="following-sibling::tei:birth"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="following-sibling::tei:death"/>
                                <xsl:text>)</xsl:text>
                            </xsl:when>
                            <xsl:when test="following-sibling::tei:birth and not(following-sibling::tei:death)">
                                <xsl:text> (geb. </xsl:text>
                                <xsl:value-of select="following-sibling::tei:birth"/>
                                <xsl:text>)</xsl:text>
                            </xsl:when>
                            <xsl:when test="not(following-sibling::tei:birth) and following-sibling::tei:death">
                                <xsl:text> (gest. </xsl:text>
                                <xsl:value-of select="following-sibling::tei:death"/>
                                <xsl:text>)</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:text>:</xsl:text>
                    </span>
                    <xsl:if test="parent::tei:person/tei:note">
                        <br/><xsl:apply-templates select="parent::tei:person/tei:note"/>
                    </xsl:if>                                    
                    <xsl:if test="parent::tei:person/tei:persName/@ref">
<!--                        <br/>Weitere Informationen in der <a href="http://beaconfinder.mww-forschung.de/index.php?gnd={substring-after(parent::tei:person/tei:persName/@ref,'gnd/')}" target="_blank">MWW-Personensuche</a>.-->
                        <br/>GND: <a href="{parent::tei:person/tei:persName/@ref}" target="_blank"><xsl:value-of select="substring-after(parent::tei:person/tei:persName/@ref,'gnd/')"/></a>.
                    </xsl:if>
                    <xsl:if test="parent::tei:person/tei:idno[contains(.,'gnd')]">
<!--                        <br/>Weitere Informationen in der <a href="http://beaconfinder.mww-forschung.de/index.php?gnd={substring-after(parent::tei:person/tei:idno,'gnd/')}" target="_blank">MWW-Personensuche</a>.-->
                        <br/>Weitere Informationen in der <a href="{parent::tei:person/tei:idno}" target="_blank">GND</a>.
                    </xsl:if>
                    <xsl:if test="parent::tei:person/tei:idno[contains(.,'wikidata')]">
                        <br/>Weitere Informationen in <a href="{parent::tei:person/tei:idno}" target="_blank">Wikidata</a>.
                    </xsl:if>
                    <xsl:if test="parent::tei:person/tei:listBibl/tei:bibl[not(tei:ptr)]">
                        <br/>Literatur: <xsl:apply-templates select="parent::tei:person/tei:listBibl/tei:bibl[not(tei:ptr)]"/>.
                    </xsl:if>                    
                    <xsl:if test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr">
                        <xsl:choose>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='wibilex'">
                                <br/>Weitere Informationen im <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">WiBiLex</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='RE'">
                                <br/>Weitere Informationen in <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Paulys Realencyclopädie der classischen Altertumswissenschaft</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='hls'">
                                <br/>Weitere Informationen im <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Historischen Lexikon der Schweiz</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='ndb' and not(parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='adb')">
                                <br/>Weitere Informationen in der <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">NDB</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='adb' and not(parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='ndb')">
                                <br/>Weitere Informationen in der <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">ADB</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='adb' and parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='ndb'">
                                <br/>Weitere Informationen in der <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr[@type='adb']/@target}" target="_blank">ADB</a> und <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr[@type='ndb']/@target}" target="_blank">NDB</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='wikipedia'">
                                <br/>Weitere Informationen in <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Wikipedia</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='apw'">
                                <br/>Weitere Informationen in den <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Acta Pacis Westphalicae</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='dbl'">
                                <br/>Weitere Informationen im <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Dansk Biografisk Leksikon</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='dizionario'">
                                <br/>Weitere Informationen im <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Dizionario di Storia</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='fgdb'">
                                <br/>Weitere Informationen in der <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Mitgliederdatenbank Fruchtbringende Gesellschaft</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='hb'">
                                <br/>Weitere Informationen in der <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Hessischen Biographie</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='oehl'">
                                <br/>Weitere Informationen in der <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Ökumenischen Heiligenlexikon</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@type='sbl'">
                                <br/>Weitere Informationen im <a href="{parent::tei:person/tei:listBibl/tei:bibl/tei:ptr/@target}" target="_blank">Svenskt Biografiskt Lexikon</a>.
                            </xsl:when>
                            <xsl:when test="parent::tei:person/tei:listBibl/tei:bibl/tei:ptr[@type='doi' or @type='opac' or @type='gvk' or @type='jstor']">
                                <br/>Literatur: <xsl:apply-templates select="parent::tei:person/tei:listBibl/tei:bibl"/>.
                            </xsl:when>
                        </xsl:choose>                        
                    </xsl:if>
                    
                </xsl:for-each>
                <xsl:choose>                    
                    <xsl:when test="starts-with(ancestor::tei:TEI/@xml:id,'grand_tour.')">
                        <!--<br/><a href="../personen#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.-->
                    </xsl:when>
                    <xsl:when test="not(starts-with(ancestor::tei:TEI/@xml:id,'sz2.'))">
                        <br/><a href="../personen#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.
                    </xsl:when>
                    <xsl:otherwise>
                        <br/><a href="personen#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.
                    </xsl:otherwise>
                </xsl:choose>                                                
            </span>        
    </xsl:template>
    
    <xsl:template match="tei:rs[@ref != ''][contains(@ref,' ')]">
        <xsl:apply-templates/>
        <!--<xsl:param name="separator" select="' '"/>
        <xsl:variable name="id" select="generate-id()"/>
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-{@type}"  href="javascript:void(0);">  
                <xsl:attribute name="title">
                    <xsl:value-of select="document(substring-before(@ref,' '))"/>
                    <!-\-<xsl:if test="contains(substring-after(@ref,' '), ' ')">
                        <xsl:text> und </xsl:text>
                        <xsl:value-of select="document(substring-before(substring-after(@ref, ' '),' '))/tei:persName[@type='display']"/>
                    </xsl:if>-\->
                </xsl:attribute>
                <xsl:apply-templates/>
            </a>
        </xsl:element>-->
    </xsl:template>
    
    <xsl:template match="tei:rs[@type = 'place'][@ref != ''][not(contains(@ref,' '))][document(@ref)/tei:placeName]">
        <xsl:variable name="id" select="generate-id()"/>
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-{@type}" title="{document(@ref)/tei:placeName}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
        </xsl:element>
            <span id="{$id}" class="ref-{@type}-target margin-right">
                <a href="" class="fa fa-close pull-right" title="Schließen"></a>
                <xsl:for-each select="document(@ref)/tei:placeName">
                    <span style="font-weight: bold;">
                        <xsl:value-of select="."/>                        
                        <xsl:text>:</xsl:text>
                    </span>
                    <xsl:if test="parent::tei:place/tei:note">
                        <br/><xsl:value-of select="parent::tei:place/tei:note"/>                       
                    </xsl:if>                    
                    <xsl:if test="@ref">
                        <br/>Weitere Informationen bei <a href="{@ref}" target="_blank">geonames.org</a>.                        
                    </xsl:if>                    
                </xsl:for-each>
                <xsl:choose>                    
                    <xsl:when test="starts-with(ancestor::tei:TEI/@xml:id,'grand_tour.')">
                        <!--<br/><a href="../personen#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.-->
                    </xsl:when>
                    <xsl:when test="not(starts-with(ancestor::tei:TEI/@xml:id,'sz2.'))">
                        <br/><a href="../orte#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.
                    </xsl:when>
                    <xsl:otherwise>
                        <br/><a href="orte#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.
                    </xsl:otherwise>
                </xsl:choose>                              
            </span>        
    </xsl:template>
    
    <xsl:template match="tei:rs[@type = 'org'][@ref != ''][not(contains(@ref,' '))][document(@ref)/tei:orgName]">
        <xsl:variable name="id" select="generate-id()"/>
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-{@type}" title="{document(@ref)/tei:orgName}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
        </xsl:element>
        <span id="{$id}" class="ref-{@type}-target margin-right">
            <a href="" class="fa fa-close pull-right" title="Schließen"></a>
            <xsl:for-each select="document(@ref)/tei:orgName">
                <span style="font-weight: bold;">
                    <xsl:value-of select="."/>                        
                    <xsl:text>:</xsl:text>
                </span>
                <xsl:if test="parent::tei:org/tei:note">
                    <br/><xsl:value-of select="parent::tei:org/tei:note"/>                       
                </xsl:if>                    
                <xsl:if test="@ref">
                    <br/>GND: <a href="{@ref}" target="_blank"><xsl:value-of select="substring-after(@ref,'gnd/')"/></a>.
                </xsl:if>                    
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="starts-with(ancestor::tei:TEI/@xml:id,'grand_tour.')">
                    <!--<br/><a href="../personen#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.-->
                </xsl:when>
                <xsl:otherwise>
                    <br/><a href="orte#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.
                </xsl:otherwise>
            </xsl:choose>                              
        </span>        
    </xsl:template>
    
    <xsl:template match="tei:rs[@type = 'bibl'][@ref != ''][not(contains(@ref,' '))]">
        <xsl:variable name="id" select="generate-id()"/>
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-{@type}" title="{document(@ref)/self::tei:bibl}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
        </xsl:element>
            <span id="{$id}" class="ref-{@type}-target margin-right">
                <a href="" class="fa fa-close pull-right" title="Schließen"></a>
                <xsl:for-each select="document(@ref)/self::tei:bibl">
                    <span style="font-weight: bold;">
                        <xsl:value-of select="./text()"/>
                    </span>
                    <xsl:if test="tei:note">
                        <br/><xsl:value-of select="tei:note"/>                         
                    </xsl:if>                    
                    <xsl:if test="tei:ptr">
                        <br/>Eintrag im
                        <xsl:choose>
                            <xsl:when test="tei:ptr/@type='opac'">
                                <a href="http://opac.lbs-braunschweig.gbv.de/DB=2/XMLPRS=N/PPN?PPN={tei:ptr/@cRef}" target="_blank">HAB-OPAC</a>
                            </xsl:when>
                            <xsl:when test="tei:ptr/@type='gvk'">
                                <a href="https://kxp.k10plus.de/DB=2.1/PPNSET?PPN={tei:ptr/@cRef}" target="_blank">GVK</a>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:text>.</xsl:text>                        
                    </xsl:if>                    
                </xsl:for-each>
                
                <!--                    <br/><a href="literatur#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.-->
                
            </span>
        
    </xsl:template>
    
    <xsl:template match="tei:term[@ref != '']">
        <xsl:variable name="id" select="generate-id()"/>
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-gloss" title="{document(@ref)/tei:label}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
        </xsl:element>
            <span id="{$id}" class="ref-gloss-target margin-right">
                <a href="" class="fa fa-close pull-right" title="Schließen"></a>
                <xsl:for-each select="document(@ref)">
                    <span style="font-weight: bold;">
                        <xsl:value-of select="tei:label"/>                        
                        <xsl:text>:</xsl:text>
                    </span>
                    <xsl:choose>
                        <xsl:when test="@n">
                            <br/><xsl:value-of select="descendant::tei:item[@n=current()/@n]"/>                            
                        </xsl:when>
                        <xsl:otherwise>
                            <br/><xsl:value-of select="descendant::tei:item"/>                            
                        </xsl:otherwise>
                    </xsl:choose>                    
                </xsl:for-each>                
            </span>
        
    </xsl:template>
    
    <xsl:template match="tei:rs[@type = 'abbreviation'][@ref != '']">
        <abbr title="{document(@ref)/tei:term}"><xsl:apply-templates/></abbr>
    </xsl:template>  
    
    <xsl:template match="tei:rs[not(@ref)]">
        <span style="background-color:yellow;"><xsl:apply-templates/></span>
    </xsl:template>
    
    <!--<xsl:template match="tei:rs">
        <xsl:apply-templates/>
    </xsl:template>-->
    
    <xsl:template match="tei:l">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>   
    
    <xsl:template match="tei:lg">
        <xsl:choose>
            <xsl:when test="@xml:lang">
<!--                <p>-->
                <br/>
                    <span lang="{@xml:lang}"><xsl:apply-templates/></span>
                <!--</p>-->
            </xsl:when>
            <xsl:otherwise>
<!--                <p><xsl:apply-templates/></p>-->
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:lb[ancestor::tei:w]">
        <xsl:text>-</xsl:text>
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:lb[ancestor::tei:add]"/>
    
    <xsl:template match="tei:lb[ancestor::tei:note[@place]]"/>
    
    <xsl:template match="tei:unclear">
        <span class="unclear"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:w">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="text()[parent::tei:w]">
        <xsl:value-of select="translate(normalize-space(),':','')"/>
    </xsl:template>
    
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    
    <xsl:template match="tei:add">
        <span>&lt;<xsl:apply-templates/>&gt;</span>
        <!--<span><sup>+</sup><xsl:apply-templates/><sup>+</sup></span>-->
    </xsl:template>
    
    <xsl:template match="tei:choice[descendant::tei:expan]">
        <span title="Auflösung: {./tei:expan}" style="border-bottom: thin dotted;"><xsl:apply-templates/></span>
        <!--<xsl:variable name="id" select="generate-id(./tei:expan)"/>
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">
            <xsl:attribute name="class">ref</xsl:attribute>
            <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
            <span title="{normalize-space(./tei:expan)}" style="border-bottom: thin dotted;">
                <xsl:apply-templates/>
            </span>
        </xsl:element>
        <span id="{$id}" class="ref-gloss-target margin-right">
            <a href="" class="fa fa-close pull-right" title="Schließen"></a>
            <span style="font-weight: bold;">Auflösung:</span>
            <xsl:text> "</xsl:text>
            <xsl:value-of select="normalize-space(./tei:expan)"/>
            <xsl:text>"</xsl:text>
        </span>-->
    </xsl:template>
    
    <xsl:template match="tei:expan"/>
    
    <xsl:template match="tei:abbr">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:choice[descendant::tei:corr]">
        <span title="Lies: {./tei:corr}" style="border-bottom: thin dotted;"><xsl:apply-templates/></span>
        <!--<xsl:variable name="id" select="generate-id(./tei:corr)"/>
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">
            <xsl:attribute name="class">ref</xsl:attribute>
            <xsl:attribute name="href">#<xsl:value-of select="$id"/></xsl:attribute>
            <span title="{normalize-space(./tei:expan)}" style="border-bottom: thin dotted;">
                <xsl:apply-templates/>
            </span>
        </xsl:element>
        <span id="{$id}" class="ref-gloss-target margin-right">
            <a href="" class="fa fa-close pull-right" title="Schließen"></a>
            <span style="font-weight: bold;">Lies:</span>
            <xsl:text> "</xsl:text>
            <xsl:value-of select="normalize-space(./tei:corr)"/>
            <xsl:text>"</xsl:text>
        </span>-->
    </xsl:template>
    
    <xsl:template match="tei:corr"/>
    
    <xsl:template match="tei:sic">
        <xsl:apply-templates/>
        <xsl:text>[!]</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:supplied">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:c | tei:subst">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:c[. = document('')//tei:term/@key]">
        <span title="{document('')//tei:term[@key = current()]}" class="symbol">
            <xsl:apply-templates/>
        </span>
    </xsl:template>  
    
    <xsl:template match="tei:c[@rend = 'super']">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'underline']">
        <u><xsl:apply-templates/></u>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'superscript']">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'center']">
<!--        <div style="text-align:center;">-->
            <xsl:apply-templates/>
        <!--</div>-->
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'right']">
        <!--        <div style="text-align:center;">-->
        <xsl:apply-templates/>
        <!--</div>-->
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'super']">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'text-decoration:double-underline']">
        <span style="border-bottom: double 3px;"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend='italic']">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    <xsl:template match="tei:note[@place]" priority="10">
<!--        <span class="margin-left"><xsl:apply-templates/></span>-->
        <span>&lt;<xsl:apply-templates/>&gt; </span>
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
    
    <xsl:template match="tei:ref[@cRef != '']">
        <xsl:choose>
            <xsl:when test="@type='biblical'">                
                <a id="{concat(@cRef,'_',preceding::tei:pb[1]/@n)}">
                    <xsl:attribute name="href">
                        <xsl:text>javascript:window.open('</xsl:text>
                        <xsl:value-of select="$cRef-biblical-start"/>
                        <xsl:value-of select="translate(@cRef,' _,','++: ')"/>
                        <xsl:value-of select="$cRef-biblical-end_de"/>
                        <xsl:text>&amp;l=de</xsl:text>
                        <xsl:value-of select="@xml:id"/><xsl:text>', "Zweitfenster", "width=1200, height=450, top=300, left=50").focus();</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </a> 
            </xsl:when>
            <xsl:otherwise>
                <span id="{concat(@cRef,'_',preceding::tei:pb[1]/@n)}">
                    <xsl:apply-templates/>
                </span> 
            </xsl:otherwise>
        </xsl:choose>               
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <xsl:text>||</xsl:text>
        <xsl:call-template name="pagebreak"/>
        <xsl:if test="following-sibling::*[1][self::tei:pb]">            
            <xsl:text>[leere Seite]</xsl:text>
            <br/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:facsimile"/>
    
    <xsl:template match="tei:list|tei:listPerson">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item[parent::tei:list or parent::tei:listPerson]">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="tei:milestone"/>
    
    <xsl:template match="tei:cit">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:quote">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="pagebreak">
        <xsl:if test="@facs">
            <xsl:choose>
                <xsl:when test="contains(@facs,'#mss') and @n">
                    <a id="{@n}" class="pagebreak screen-only" target="_facsimile" href="http://diglib.hab.de/mss/{substring-before(substring-after(@facs, '_'),'_')}/{substring-after(substring-after(@facs,'_'),'_')}.jpg">
                        <span class="fa fa-file-o"> <xsl:value-of select="@n"/> </span>
                    </a>
                </xsl:when>                
                <xsl:when test="contains(@facs,'#mss') and not(@n)">
                    <a id="{@n}" class="pagebreak screen-only" target="_facsimile" href="http://diglib.hab.de/mss/{substring-before(substring-after(@facs, '_'),'_')}/{substring-after(substring-after(@facs,'_'),'_')}.jpg">
                        <span class="fa fa-file-o"> 
                            <xsl:value-of select="//tei:facsimile/tei:graphic[concat('#',@xml:id)=current()/@facs]/@n"/> 
                        </span>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <a id="{@n}" class="pagebreak screen-only" target="_facsimile" href="{@facs}">
                        <span class="fa fa-file-o"> <xsl:value-of select="@n"/> </span>
                    </a>
                </xsl:otherwise>
            </xsl:choose>            
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="paginator">
        <!--<div style="float: right; margin-left: 2em;">-->
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
        <!--</div>-->
    </xsl:template>
    
</xsl:transform>