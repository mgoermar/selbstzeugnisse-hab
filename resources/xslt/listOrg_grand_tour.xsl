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
        <xsl:strip-space elements="*"/>
    
        <!--<xsl:variable name="metsFile" select="document('../mets.xml')"/>
        <xsl:variable name="fileId"   select="/*/@xml:id"/>
        <xsl:variable name="metsId"   select="$metsFile//mets:div[mets:fptr[@FILEID = $fileId]]/@ID"/>-->
        <xsl:variable name="currentFile" select="document('../daten/grandtour/register/listOrg_grand_tour.xml')"/>
        <xsl:variable name="cod_guelf_267_1_extrav_Data" select="document('../daten/grandtour/Reiseberichte/cod_guelf_267_1_extrav.xml')//tei:text"/>
        <xsl:variable name="cod_guelf_89_blank_Data" select="document('../daten/grandtour/Reiseberichte/cod_guelf_89_blank.xml')//tei:text"/>
        
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
    
    <xsl:template match="tei:listOrg">
        <h1>Körperschaftsregister</h1>
        <h2 id="A">A</h2>
        <xsl:for-each select="$currentFile//tei:org[translate(substring(tei:orgName, 1, 1),'Ä','A')='A']">
            <xsl:sort select="translate(tei:orgName,'Ä','A')"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="B">B</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='B']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="C">C</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='C']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="D">D</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='D']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="E">E</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='E']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="F">F</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='F']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="G">G</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='G']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="H">H</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='H']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="I">I</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='I']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="J">J</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='J']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="K">K</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='K']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="L">L</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='L']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="M">M</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='M']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="N">N</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='N']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="O">O</h2>
        <xsl:for-each select="$currentFile//tei:org[translate(substring(tei:orgName, 1, 1),'Ö','O')='O']">
            <xsl:sort select="translate(tei:orgName,'Ö','O')"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="P">P</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='P']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="Q">Q</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='Q']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="R">R</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='R']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="S">S</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='S']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="T">T</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='T']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="U">U</h2>
        <xsl:for-each select="$currentFile//tei:org[translate(substring(tei:orgName, 1, 1),'Ü','U')='U']">
            <xsl:sort select="translate(tei:orgName,'Ü','U')"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="V">V</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='V']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="W">W</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='W']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="X">X</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='X']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="Y">Y</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='Y']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <h2 id="Z">Z</h2>
        <xsl:for-each select="$currentFile//tei:org[substring(tei:orgName, 1, 1)='Z']">
            <xsl:sort select="tei:orgName"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:text/tei:body">
        <div class="navigation">
            <xsl:call-template name="navigation"/>
        </div>
        <div class="content">
            <div class="contentWrap">
                <div class="register">
                    <xsl:apply-templates select="tei:listOrg"/>
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
                    <li>
                        <a href="#A">A</a>
                    </li>
                    <li>
                        <a href="#B">B</a>
                    </li>
                    <li>
                        <a href="#C">C</a>
                    </li>
                    <li>
                        <a href="#D">D</a>
                    </li>
                    <li>
                        <a href="#E">E</a>
                    </li>
                    <li>
                        <a href="#F">F</a>
                    </li>
                    <li>
                        <a href="#G">G</a>
                    </li>
                    <li>
                        <a href="#H">H</a>
                    </li>
                    <li>
                        <a href="#I">I</a>
                    </li>
                    <li>
                        <a href="#J">J</a>
                    </li>
                    <li>
                        <a href="#K">K</a>
                    </li>
                    <li>
                        <a href="#L">L</a>
                    </li>
                    <li>
                        <a href="#M">M</a>
                    </li>
                    <li>
                        <a href="#N">N</a>
                    </li>
                    <li>
                        <a href="#O">O</a>
                    </li>
                    <li>
                        <a href="#P">P</a>
                    </li>
                    <li>
                        <a href="#Q">Q</a>
                    </li>
                    <li>
                        <a href="#R">R</a>
                    </li>
                    <li>
                        <a href="#S">S</a>
                    </li>
                    <li>
                        <a href="#T">T</a>
                    </li>
                    <li>
                        <a href="#U">U</a>
                    </li>
                    <li>
                        <a href="#V">V</a>
                    </li>
                    <li>
                        <a href="#W">W</a>
                    </li>
                    <li>
                        <a href="#X">X</a>
                    </li>
                    <li>
                        <a href="#Y">Y</a>
                    </li>
                    <li>
                        <a href="#Z">Z</a>
                    </li>
                </ul>
                </div>
            </div>
            </div>
        </div>
    </xsl:template>
    
    
    <xsl:template match="tei:org">
        <dl>
            <xsl:apply-templates select="tei:orgName"/>
        </dl>
    </xsl:template>
    
    <xsl:template match="tei:orgName">
        <dt id="{parent::tei:org/@xml:id}">
            <xsl:value-of select="."/>
            <xsl:text>:</xsl:text>
        </dt>
        <dd>
            <xsl:if test="@ref">
                <xsl:choose>
                    <xsl:when test="contains(@ref, 'gnd')">
                        <a target="_blank" href="{@ref}">GND-Eintrag</a>
                    </xsl:when>
                    <xsl:when test="contains(@ref, 'wikidata')">
                        <a target="_blank" href="{@ref}">Wikidata-Eintrag</a>
                    </xsl:when>
                </xsl:choose>                
            </xsl:if>
            <xsl:apply-templates select="parent::tei:org/tei:note"/>
        </dd>
        <table>
            <tbody>
                <xsl:if test="$cod_guelf_267_1_extrav_Data//tei:rs[@type='org'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:org/@xml:id]">
                    <tr>
                        <td><h4>Cod. Guelf. 267.1 Extrav.: </h4></td>
                        <td>
                            <xsl:for-each select="$cod_guelf_267_1_extrav_Data//tei:rs[@type='org'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:org/@xml:id]">
                                <a href="cod_guelf_267_1_extrav{concat('#',document('http://diglib.hab.de/mss/267-1-extrav/facsimile.xml')//tei:facsimile/tei:graphic[concat('#',@xml:id)=current()/preceding::tei:pb[1]//@facs]/@n)}">
                                    <xsl:value-of select="document('http://diglib.hab.de/mss/267-1-extrav/facsimile.xml')//tei:facsimile/tei:graphic[concat('#',@xml:id)=current()/preceding::tei:pb[1]//@facs]/@n"/>
                                </a>
                                <xsl:if test="position()!=last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="$cod_guelf_89_blank_Data//tei:rs[@type='org'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:org/@xml:id]">
                    <tr>
                        <td><h4>Cod. Guelf. 89 Blank.:</h4></td>
                        <td>
                            <xsl:for-each select="$cod_guelf_89_blank_Data//tei:rs[@type='org'][not(contains(@ref,' '))][substring-after(@ref,'#')=current()/parent::tei:org/@xml:id]">
                                <a href="cod_guelf_89_blank{concat('#',current()/preceding::tei:pb[1]/@n)}">
                                    <xsl:value-of select="current()/preceding::tei:pb[1]/@n"/>
                                </a>
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
    
    <xsl:template match="tei:note">
        <xsl:if test="parent::tei:org/tei:orgName/@ref">
            <xsl:text>; </xsl:text>   
        </xsl:if>        
        <xsl:apply-templates/>                        
    </xsl:template>
    
</xsl:stylesheet>