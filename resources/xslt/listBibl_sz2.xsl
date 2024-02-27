<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="tei mets html map"
    xmlns:map="urn:uuid:88a07861-a998-4c1b-bc3f-cf169a4aab52"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:import href="default.xsl"/>
    
    <xsl:output method="html" encoding="utf-8" indent="yes"/>
    
    <xsl:variable name="metsFile" select="document('../mets.xml')"/>
    <xsl:variable name="fileId"   select="/*/@xml:id"/>
    <xsl:variable name="metsId"   select="$metsFile//mets:div[mets:fptr[@FILEID = $fileId]]/@ID"/>
    <xsl:variable name="currentFile" select="document('../daten/sz2/register/listBibl_s2.xml')"/>
    <xsl:variable name="glossFile" select="document('../daten/sz2/register/listGloss_s2.xml')"/>
    <xsl:variable name="cod_guelf_28_blank_Data" select="document('../daten/sz2/tagebuecher/cod_guelf_28_blank.xml')//tei:text"/>
    <xsl:variable name="cod_guelf_286_blank_Data" select="document('../daten/sz2/tagebuecher/cod_guelf_286_blank.xml')//tei:text"/>
    <xsl:variable name="cod_guelf_286a_blank_Data" select="document('../daten/sz2/tagebuecher/cod_guelf_286a_blank.xml')//tei:text"/>
    <xsl:variable name="cod_guelf_211_1_extrav_Data" select="document('../daten/sz2/tagebuecher/cod_guelf_211_1_extrav.xml')//tei:text"/>
    <xsl:param name="cRef-biblical-start"><xsl:text>http://www.biblija.net/biblija.cgi?m=</xsl:text></xsl:param>
    <xsl:param name="cRef-biblical-end_de"><xsl:text>&amp;id12=1&amp;id8=1&amp;set=1</xsl:text></xsl:param>
    
    <map:map>
        <map:entry key="01" value="Januar"/>
        <map:entry key="02" value="Februar"/>
        <map:entry key="03" value="März"/>
        <map:entry key="04" value="April"/>
        <map:entry key="05" value="Mai"/>
        <map:entry key="06" value="Juni"/>
        <map:entry key="07" value="Juli"/>
        <map:entry key="08" value="August"/>
        <map:entry key="09" value="September"/>
        <map:entry key="10" value="Oktober"/>
        <map:entry key="11" value="November"/>
        <map:entry key="12" value="Dezember"/>
    </map:map>
        
    <xsl:template match="tei:listBibl">
        <h1>Register der erwähnten oder zitierten Literaturwerke und Theaterstücke</h1>
        <p style="font-size: 1em;">Zu den verwendeten bibliographischen Abkürzungen siehe die WDB-Dokumentation für <a target="_blank" href="http://diglib.hab.de/rules/documentation/quoting_biblical.xml">Bibelstellen</a> sowie für <a target="_blank" href="http://diglib.hab.de/rules/documentation/quoting_mediaeval.xml">kanonische und römische Rechtsquellen</a>, für antike Autoren und Werke das Abkürzungsverzeichnis im <a target="_blank" href="https://opac.lbs-braunschweig.gbv.de/DB=2/XMLPRS=N/PPN?PPN=211821454">Neuen Pauly</a>.</p>
        <h3 id="Literatur">Literaturwerke</h3>
        <h2 id="biblical">Bibelstellen</h2>        
        <dl>
            <xsl:for-each select="$cod_guelf_211_1_extrav_Data//tei:ref[@type='biblical']|$cod_guelf_286_blank_Data//tei:ref[@type='biblical']|$cod_guelf_286a_blank_Data//tei:ref[@type='biblical']|$cod_guelf_28_blank_Data//tei:ref[@type='biblical']">
                <xsl:sort select="@cRef"/>            
                <dt>
                    <xsl:value-of select="translate(@cRef,'_',' ')"/>
                </dt>
                <dd>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:text>javascript:window.open('</xsl:text>
                            <xsl:value-of select="$cRef-biblical-start"/>
                            <xsl:value-of select="translate(@cRef,' _,','++: ')"/>
                            <xsl:value-of select="$cRef-biblical-end_de"/>
                            <xsl:text>&amp;l=de</xsl:text>
                            <xsl:value-of select="@xml:id"/><xsl:text>', "Zweitfenster", "width=1200, height=450, top=300, left=50").focus();</xsl:text>
                        </xsl:attribute>
                        [biblija.net]
                    </a>
                    <xsl:value-of select="ancestor::tei:TEI/@n"/>: <a href="{substring-after(ancestor::tei:TEI/@xml:id,'.')}#{concat(@cRef,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                </dd>
            </xsl:for-each>
        </dl>
        <h2 id="classical">Antike Autoren und Werke</h2>
        <dl>
            <xsl:for-each select="$cod_guelf_211_1_extrav_Data//tei:ref[@type='classical']|$cod_guelf_286_blank_Data//tei:ref[@type='classical']|$cod_guelf_286a_blank_Data//tei:ref[@type='classical']|$cod_guelf_28_blank_Data//tei:ref[@type='classical']">
                <xsl:sort select="@cRef"/>            
                <dt><xsl:value-of select="@cRef"/></dt>
                <dd>
                    <xsl:choose>
                        <xsl:when test="child::tei:rs">
                            <xsl:if test="child::tei:rs/@type='bibl'">
                                Siehe unter <a href="{child::tei:rs/@ref}">Frühneuzeitliche Textausgaben</a>.
                            </xsl:if>
                            <xsl:if test="child::tei:rs/@type='person'">
                                Siehe unter <a href="personen{child::tei:rs/@ref}">Personen</a>.
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="ancestor::tei:TEI/@n"/>: <a href="{substring-after(ancestor::tei:TEI/@xml:id,'.')}#{concat(@cRef,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                        </xsl:otherwise>
                    </xsl:choose>                    
                </dd>    
            </xsl:for-each>
        </dl>
        <h2 id="medieval">Römische und kanonische Rechtsquellen</h2>
        <dl>
            <xsl:for-each select="$cod_guelf_211_1_extrav_Data//tei:ref[@type='medieval']|$cod_guelf_286_blank_Data//tei:ref[@type='medieval']|$cod_guelf_286a_blank_Data//tei:ref[@type='medieval']|$cod_guelf_28_blank_Data//tei:ref[@type='medieval']">
                <xsl:sort select="@cRef"/>            
                <dt><xsl:value-of select="@cRef"/></dt>   
                <dd><xsl:value-of select="ancestor::tei:TEI/@n"/>: <a href="{substring-after(ancestor::tei:TEI/@xml:id,'.')}#{concat(@cRef,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a></dd> 
            </xsl:for-each>
        </dl>
        <h2 id="FNZ">Frühneuzeitliche Werke und Textausgaben</h2>
        <dl>
            <xsl:for-each select="$currentFile//tei:bibl">
                <xsl:sort select="."/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </dl>        
        <h3 id="Dramen">Dramen</h3>
        <h2 id="Komödien">Komödien</h2>
        <dl>
            <xsl:for-each select="$glossFile//tei:item[starts-with(@xml:id,'komoedie')]">
                <xsl:sort select="@xml:id"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each> 
        </dl>               
        <h2 id="Tragödien">Tragödien</h2>
        <dl>
            <xsl:for-each select="$glossFile//tei:item[starts-with(@xml:id,'tragoedie')]">
                <xsl:sort select="@xml:id"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </dl>        
        <h3 id="Opern">Opern</h3>
        <dl>
            <xsl:for-each select="$glossFile//tei:item[starts-with(@xml:id,'oper')]">
                <xsl:sort select="@xml:id"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </dl>        
    </xsl:template>
    
    <xsl:template match="tei:text/tei:body">
        <div class="navigation">
            <xsl:call-template name="navigation"/>
        </div>
        <div class="content">
            <div class="contentWrap">
                <div class="register">
                    <xsl:apply-templates select="tei:listBibl"/>
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
                <!--<ul>
                    <li>
                        <a href="#Literatur">Literaturwerke</a>
                    </li>
                    <li>
                        <a href="#Dramen">Dramen</a>
                        <ul>
                            <li>
                                <a href="#Komödien">Komödien</a>
                            </li>                    
                            <li>
                                <a href="#Tragödien">Tragödien</a>
                            </li>
                        </ul>
                    </li>                    
                    <li>
                        <a href="#Opern">Opern</a>
                    </li>
                </ul>-->
                    <ul>
                        <li>
                            <a href="#biblical">Bibelstellen</a>
                        </li>
                        <li>
                            <a href="#classical">Antike Werke</a>
                        </li>
                        <li>
                            <a href="#medieval">Rechtsquellen</a>
                        </li>
                        <li>
                            <a href="#FNZ">Frühneuzeitliche Werke</a>
                        </li>
                        <li>
                            <li>
                                    <a href="#Komödien">Komödien</a>
                                </li>                    
                                <li>
                                    <a href="#Tragödien">Tragödien</a>
                                </li>
                        </li>                    
                        <li>
                            <a href="#Opern">Opern</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
            <dt id="{@xml:id}">
                <xsl:value-of select="./text()"/> 
            </dt>
            <dd>
                <xsl:if test="tei:note">
                    <xsl:value-of select="tei:note"/>
                </xsl:if>
                <xsl:apply-templates select="tei:ptr"/>
            </dd>
            <table>
                <tbody>
                    <xsl:if test="$cod_guelf_28_blank_Data//tei:rs[@type='bibl'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/@xml:id]">
                        <tr>
                            <td><h4>Cod. Guelf. 28 Blank.:</h4></td>
                            <td>
                                <xsl:for-each select="$cod_guelf_28_blank_Data//tei:rs[@type='bibl'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/@xml:id]">
                                    <a href="cod_guelf_28_blank{concat(@ref,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                                    <xsl:if test="position()!=last()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="$cod_guelf_211_1_extrav_Data//tei:rs[@type='bibl'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/@xml:id]">
                        <tr>
                            <td><h4>Cod. Guelf. 211,1 Extrav.:</h4></td>
                            <td>
                                <xsl:for-each select="$cod_guelf_211_1_extrav_Data//tei:rs[@type='bibl'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/@xml:id]">
                                    <a href="cod_guelf_211_1_extrav{concat(@ref,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                                    <xsl:if test="position()!=last()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="$cod_guelf_286_blank_Data//tei:rs[@type='bibl'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/@xml:id]">
                        <tr>
                            <td><h4>Cod. Guelf. 286 Blank.:</h4></td>
                            <td>
                                <xsl:for-each select="$cod_guelf_286_blank_Data//tei:rs[@type='bibl'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/@xml:id]">
                                    <a href="cod_guelf_286_blank{concat(@ref,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                                    <xsl:if test="position()!=last()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </xsl:if> 
                    <xsl:if test="$cod_guelf_286a_blank_Data//tei:rs[@type='bibl'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/@xml:id]">
                        <tr>
                            <td><h4>Cod. Guelf. 286a Blank.:</h4></td>
                            <td>
                                <xsl:for-each select="$cod_guelf_286a_blank_Data//tei:rs[@type='bibl'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/@xml:id]">
                                    <a href="cod_guelf_286a_blank{concat(@ref,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                                    <xsl:if test="position()!=last()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </xsl:if>                
                </tbody>
            </table>            
        
    </xsl:template>
    
    <xsl:template match="tei:item">
            <xsl:apply-templates select="tei:label"/>
        
    </xsl:template>
    
    <xsl:template match="tei:label">
        <dt id="{parent::tei:item/@xml:id}">
            <xsl:value-of select="substring-after(.,' ')"/>
        </dt>
        <dd>
            <xsl:apply-templates select="parent::tei:item/tei:list"/>
        </dd>
        <table>
            <tbody>
                <xsl:if test="$cod_guelf_28_blank_Data//tei:term[not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:item/@xml:id]">
                    <tr>
                        <td><h4>Cod. Guelf. 28 Blank.:</h4></td>
                        <td>
                            <xsl:for-each select="$cod_guelf_28_blank_Data//tei:term[not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:item/@xml:id]">
                                <a href="cod_guelf_28_blank{concat(@ref,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                                <xsl:if test="position()!=last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="$cod_guelf_211_1_extrav_Data//tei:term[not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:item/@xml:id]">
                    <tr>
                        <td><h4>Cod. Guelf. 211,1 Extrav.:</h4></td>
                        <td>
                            <xsl:for-each select="$cod_guelf_211_1_extrav_Data//tei:term[not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:item/@xml:id]">
                                <a href="cod_guelf_211_1_extrav{concat(@ref,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                                <xsl:if test="position()!=last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="$cod_guelf_286_blank_Data//tei:term[not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:item/@xml:id]">
                    <tr>
                        <td><h4>Cod. Guelf. 286 Blank.:</h4></td>
                        <td>
                            <xsl:for-each select="$cod_guelf_286_blank_Data//tei:term[not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:item/@xml:id]">
                                <a href="cod_guelf_286_blank{concat(@ref,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                                <xsl:if test="position()!=last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="$cod_guelf_286a_blank_Data//tei:term[not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:item/@xml:id]">
                    <tr>
                        <td><h4>Cod. Guelf. 286a Blank.:</h4></td>
                        <td>
                            <xsl:for-each select="$cod_guelf_286a_blank_Data//tei:term[not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:item/@xml:id]">
                                <a href="cod_guelf_286a_blank{concat(@ref,'_',preceding::tei:pb[1]/@n)}"><xsl:value-of select="preceding::tei:pb[1]/@n"/></a>
                                <xsl:if test="position()!=last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>                
            </tbody>
        </table> 
    </xsl:template>
    
    <xsl:template match="tei:list[not(@type='gloss')]">
        <xsl:value-of select="tei:item"/>
    </xsl:template>
    
    <xsl:template match="tei:ptr">
        <xsl:choose>
            <xsl:when test="@type='opac'">
                Eintrag im <a target="_blank" href="http://opac.lbs-braunschweig.gbv.de/DB=2/XMLPRS=N/PPN?PPN={@cRef}">HAB-OPAC</a>.
            </xsl:when>
            <xsl:when test="@type='gvk'">
                Eintrag im <a target="_blank" href="https://kxp.k10plus.de/DB=2.1/PPNSET?PPN={@cRef}">GVK</a>.
            </xsl:when>
            <xsl:when test="@type='msDB'">
                Eintrag in der <a target="_blank" href="https://diglib.hab.de/?db=mss&amp;list=ms&amp;id={@cRef}">Handschriftendatenbank</a>.
            </xsl:when>
            <xsl:when test="@type='bvb'">
                Eintrag im <a target="_blank" href="https://gateway-bayern.de/{@cRef}">BVB</a>.
            </xsl:when>
            <xsl:when test="@type='worldcat'">
                Eintrag in <a target="_blank" href="http://www.worldcat.org/oclc/{@cRef}">worldcat</a>.
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>