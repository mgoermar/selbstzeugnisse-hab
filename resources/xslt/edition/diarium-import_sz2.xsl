<xsl:transform version="1.0"
    exclude-result-prefixes="tei"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <tei:index>
        <tei:term key="&#x263D;">Montag</tei:term>
        <tei:term key="&#x2642;">Dienstag</tei:term>
        <tei:term key="&#x263F;">Mittwoch</tei:term>
        <tei:term key="&#x2643;">Donnerstag</tei:term>
        <tei:term key="&#x2640;">Freitag</tei:term>
        <tei:term key="&#x2644;">Samstag</tei:term>
        <tei:term key="&#x2609;">Sonntag</tei:term>
    </tei:index>
    
    <xsl:template name="annumber">
        <xsl:number level="any" format="a" count="//tei:note[@type='annotation'] | //tei:handShift | //tei:choice | //tei:restore | //tei:surplus"/>
    </xsl:template>
    
    <xsl:template match="tei:text/tei:body">
        <div class="navigation navigation-collapse">
            <span class="fa fa-lg fa-navicon"></span>
            <xsl:call-template name="navigation"/>
        </div>
        
        <div class="mainpage diarium">
            
            <div class="pagination" style="margin-bottom: 2em;">
                <xsl:call-template name="paginator"/>
                <div style="padding: .5em 0;">
                    <xsl:value-of select="//tei:teiHeader//tei:titleStmt/tei:title"/>
                </div>
            </div>
            
            <div style="clear: both; border-right: thin solid; padding-right: 2.5em; ">
                <xsl:apply-templates/>
            </div>
            
            <!--Apparate-->
            <xsl:if
                test="//tei:note[@type='annotation']
                | //tei:note[@type='footnote']
                | //tei:surplus">
                <div id="annotation" style="border-right: thin solid; padding-right: 2.5em;">
                    <hr/>
                    <xsl:if
                        test="//tei:note[@type='annotation']
                        | //tei:surplus">
                        <div id="textapparat">
                            <span class="appheading">Textapparat</span>
                            <xsl:for-each select="//tei:note[@type='annotation'] | //tei:surplus">
                                <xsl:variable name="number">
                                    <xsl:call-template name="annumber" />
                                </xsl:variable>  
                                <br/>
                                <a name="an{$number}" href="#ana{$number}">
                                    <xsl:value-of select="$number"/>
                                </a>
                                <xsl:text> </xsl:text>
                                <xsl:choose>
                                    <xsl:when test="self::tei:note">
                                        <xsl:apply-templates/>
                                    </xsl:when>
                                    <xsl:when test="self::tei:surplus">													
                                        Im Original steht überflüssiges <xsl:value-of select="."/>.
                                    </xsl:when>
                                </xsl:choose>                  
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                    <xsl:if test="//tei:note[@type='footnote']">
                        <hr/>
                        <div id="kommentar">
                            <span class="appheading">Kommentar</span>                            
                            <xsl:for-each select="//tei:note[@type='footnote']">
                                <xsl:variable name="number">
                                    <xsl:number level="any" count="tei:note[@type ='footnote']"/>
                                </xsl:variable>
                                <br/>
                                <a name="fn{$number}" href="#fna{$number}">
                                    <xsl:value-of select="$number"/>
                                </a>
                                <xsl:text> </xsl:text>
                                <xsl:apply-templates/>
                            </xsl:for-each>
                        </div>
                    </xsl:if>
                </div>       
            </xsl:if>
            
            <div class="pagination" style="margin-bottom: 2em;">
                <xsl:call-template name="paginator"/>
            </div>
            
        </div>
        <div class="infopanel diarium">
            <div class="facet">
                <h1>Schnellauswahl</h1>
                <form>
                    <label for="pages">Seite/Blatt: </label>
                    <select name="pages" id="pages" onchange="window.location.hash = value;">
                        <xsl:for-each select="descendant::tei:pb">
                            <option value="{@n}"><xsl:value-of select="@n"/></option>
                        </xsl:for-each>
                    </select>
                </form>
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
                <br/><a href="#">Zurück zum Seitenanfang</a>
                <!--<xsl:choose>
                    <xsl:when test="count(descendant::tei:div[@type='chapter'])&gt;1">
                        <form>
                            <label for="dates">Datum: </label>
                            <select name="dates" id="dates" onchange="window.location.hash = value;">
                                <xsl:for-each select="descendant::tei:div[@type='chapter']">
                                    <optgroup>
                                        <xsl:attribute name="label">
                                            <xsl:text>Kapitel </xsl:text>
                                            <xsl:value-of select="@n"/>
                                        </xsl:attribute>
                                        <xsl:for-each select="descendant::tei:date">
                                            <xsl:sort select="@when"/>
                                            <option value="{concat(@when,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="concat(substring(@when,9,2),'.',substring(@when,6,2),'.',substring(@when,1,4))"/></option>
                                        </xsl:for-each>
                                    </optgroup>
                                </xsl:for-each>                                
                            </select>
                        </form>
                    </xsl:when>
                    <xsl:otherwise>
                        <form>
                            <label for="dates">Datum: </label>
                            <select name="dates" id="dates" onchange="window.location.hash = value;">
                                <xsl:for-each select="descendant::tei:date">
                                    <xsl:sort select="@when"/>
                                    <option value="{concat(@when,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="concat(substring(@when,9,2),'.',substring(@when,6,2),'.',substring(@when,1,4))"/></option>
                                </xsl:for-each>
                            </select>
                        </form>
                    </xsl:otherwise>
                </xsl:choose>-->                
            </div>
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
    
    <xsl:template match="tei:surplus" priority="-10"/>
    
    <xsl:template match="tei:note" priority="-10"/>
    
    <xsl:template match="tei:head[not(tei:date)]">
        <xsl:call-template name="pagebreak"/>
        <h2>
            <xsl:if test="@place">
                <xsl:attribute name="class">margin-left</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </h2>                
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
    
    <xsl:template match="tei:milestone"/>
    
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
    
    <xsl:template match="tei:rs[@type = 'person'][@ref != ''][not(contains(@ref,' '))]">
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-{@type}" title="{document(@ref)/tei:persName[@type='display']}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
            <span id="{generate-id()}" class="ref-{@type}-target margin-right">
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
                    <br/><xsl:value-of select="parent::tei:person/tei:note"/>                
                    <xsl:if test="parent::tei:person/tei:persName/@ref">
                        <br/>Weitere Informationen in der <a href="http://beaconfinder.mww-forschung.de/index.php?gnd={substring-after(parent::tei:person/tei:persName/@ref,'gnd/')}" target="_blank">MWW-Personensuche</a>.
                    </xsl:if>                    
                </xsl:for-each>
                <br/><a href="personen#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.                                
            </span>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type = 'place'][@ref != ''][not(contains(@ref,' '))]">
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-{@type}" title="{document(@ref)/tei:placeName}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
            <span id="{generate-id()}" class="ref-{@type}-target margin-right">
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
                    <br/><a href="orte#{substring-after(@ref, '#')}">Registereintrag</a> mit weiteren Fundstellen.                                
            </span>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type = 'bibl'][@ref != ''][not(contains(@ref,' '))]">
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-{@type}" title="{document(@ref)/self::tei:bibl}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
            <span id="{generate-id()}" class="ref-{@type}-target margin-right">
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
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:term[@ref != '']">
        <xsl:variable name="local-name">span</xsl:variable>
        <xsl:element name="{$local-name}">            
            <xsl:attribute name="class">ref</xsl:attribute>
            <a id="{concat(substring-after(@ref, '#'),'_',preceding::tei:pb[1]/@n)}" class="ref-gloss" title="{document(@ref)/tei:label}"  href="javascript:void(0);">  
                <xsl:apply-templates/>
            </a>
            <span id="{generate-id()}" class="ref-gloss-target margin-right">
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
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type = 'abbreviation'][@ref != '']">
        <abbr title="{document(@ref)/tei:term}"><xsl:apply-templates/></abbr>
    </xsl:template>
    
    <xsl:template match="tei:rs">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:lb[ancestor::tei:w]">
        <xsl:text>-</xsl:text>
        <br/>
    </xsl:template>
    
    <xsl:template match="text()[parent::tei:w]">
        <xsl:value-of select="normalize-space()"/>
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
    
    <xsl:template match="tei:c[not(@rend = 'super')] | tei:subst">
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
    
    <xsl:template match="tei:hi[@rend = 'center']">
        <div style="text-align:center;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'super']">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>
    
    <xsl:template match="tei:c[@rend = 'super']">
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
    
    <xsl:template match="tei:ref[@type='biblical'][@cRef != '']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:pb"> 
        <xsl:call-template name="pagebreak"/>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:ab">
        <div class="row">
            <xsl:for-each select="tei:cb">
                <div class="column">
                    <xsl:apply-templates select="following-sibling::node()[preceding-sibling::tei:cb[1]/@n = current()/@n][not(self::tei:cb)]"/>
                </div>				
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="pagebreak">
        <xsl:if test="@facs">
            <span class="ref">
                <!--DFG-Viewer-->
                <!--<a class="pagebreak" href="http://dfg-viewer.de/show?id=9&amp;tx_dlf%5Bid%5D=http%3A%2F%2Foaimss.hab.de%2Foai-pmh%3Fverb%3DGetRecord%26metadataPrefix%3Doai_mets%26identifier%3DHAB_mss_{substring-before(substring-after(@facs, '_'),'_')}_tei-msDesc&amp;tx_dlf%5Bpage%5D={substring-after(substring-after(@facs,'_'),'_')}" target="facs_{substring-after(substring-after(@facs,'_'),'_')}" style="position: absolute; left: 15em;">                    
                    <span class="fa fa-file-o"> <xsl:value-of select="@n"/> </span>
                </a>-->          
                <!--WDB-->
                <!--<a class="pagebreak" href="http://diglib.hab.de/show_image.php?dir=mss/{substring-before(substring-after(@facs, '_'),'_')}&amp;image={substring-after(substring-after(@facs,'_'),'_')}" target="facs_{substring-after(substring-after(@facs,'_'),'_')}" style="position: absolute; left: 15em;">                    
                    <span class="fa fa-file-o"> <xsl:value-of select="@n"/> </span>
                </a>-->
                <!--WDB_Bilddatei-->
                <a id="{@n}" class="pagebreak" href="http://diglib.hab.de/mss/{substring-before(substring-after(@facs, '_'),'_')}/max/{substring-after(substring-after(@facs,'_'),'_')}.jpg" target="facs_{substring-after(substring-after(@facs,'_'),'_')}" style="position: absolute; left: 15em;">                    
                    <span class="fa fa-file-o"> <xsl:value-of select="@n"/> </span>
                </a>
                <span class="facsimile margin-right">
                    <a href="" class="fa fa-close pull-right" title="Schließen"></a>
                    <iframe src="" name="facs_{substring-after(substring-after(@facs,'_'),'_')}"/>
                </span>
            </span>            
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
    
</xsl:transform>