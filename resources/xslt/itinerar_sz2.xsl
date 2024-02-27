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
    <xsl:variable name="currentFile" select="document('../daten/sz2/register/listPlace_s2.xml')"/>
    <xsl:variable name="cod_guelf_28_blank_Data" select="document('../daten/sz2/tagebuecher/cod_guelf_28_blank.xml')//tei:text"/>
    <xsl:variable name="cod_guelf_286_blank_Data" select="document('../daten/sz2/tagebuecher/cod_guelf_286_blank.xml')//tei:text"/>
    <xsl:variable name="cod_guelf_286a_blank_Data" select="document('../daten/sz2/tagebuecher/cod_guelf_286a_blank.xml')//tei:text"/>
    <xsl:variable name="cod_guelf_211_1_extrav_Data" select="document('../daten/sz2/tagebuecher/cod_guelf_211_1_extrav.xml')//tei:text"/>
    <xsl:variable name="placedata" select="document('../daten/sz2/register/listPlace_s2.xml')"/>
    
    <xsl:template match="tei:index[@indexName='itinerary'][child::tei:term]">
        <h2 id="{parent::tei:div/@xml:id}"><xsl:value-of select="parent::tei:div/@n"/></h2>
        <table>
            <!--<thead>
                <tr>
                    <th>Datum</th>
                    <th>Ort</th>
                </tr>
            </thead>-->
            <tbody>
                <xsl:for-each select="descendant::tei:term">
                    <xsl:sort select="tei:placeName/@when"/>
                    <tr>
                        <td><xsl:value-of select="substring(tei:placeName/@when,9,2)"/>.<xsl:value-of select="substring(tei:placeName/@when,6,2)"/>.<xsl:value-of select="substring(tei:placeName/@when,1,4)"/></td>
                        <td style="padding-left: 15px;"><xsl:value-of select="tei:placeName"/></td>
                        <td>[<a href="orte#{$placedata//tei:place[tei:placeName=current()/tei:placeName]/@xml:id}">Registereintrag</a>]</td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="tei:text/tei:body">
        <div class="navigation">
            <xsl:call-template name="navigation"/>
        </div>
        <div class="content">
            <div class="contentWrap">
                <div class="register">
                    <h1>Itinerar</h1>
                    <xsl:apply-templates/>
                </div>
            </div>
        </div>
        <div id="infopanel">
            <input class="trigInp" type="checkbox" role="button"/>
            <a id="trigBtn" role="button">
                <span></span>
                <span></span>
            </a>
            <div class="facet large">
                <div class="formWrap" style="position: fixed;">
                    <h1>Schnellauswahl</h1>
                    <ul>
                        <xsl:for-each select="//tei:index[@indexName='itinerary'][child::tei:term]">
                            <li>
                                <a href="#{parent::tei:div/@xml:id}"><xsl:value-of select="parent::tei:div/@n"/></a>
                            </li>
                        </xsl:for-each>
                        <li>
                            <a href="#">Zum Seitenanfang ↑</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </xsl:template>
    
</xsl:stylesheet>