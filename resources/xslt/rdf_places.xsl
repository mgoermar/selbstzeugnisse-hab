<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:ecrm="http://erlangen-crm.org/current/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:gndo="http://d-nb.info/standards/elementset/gnd#"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:schema="http://schema.org/"
    xmlns:wdt="http://www.wikidata.org/prop/direct/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="diaryData" select="collection('../daten/sz2/tagebuecher?select=cod_guelf*.xml;recurse=no')"/>
    
    <xsl:template match="/">
        <xsl:result-document href="sz2_rdf_places.xml">
            <rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:ecrm="http://erlangen-crm.org/current/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:gndo="http://d-nb.info/standards/elementset/gnd#"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
                xmlns:schema="http://schema.org/"
                xmlns:wdt="http://www.wikidata.org/prop/direct/">
                <rdf:Description rdf:about="christianii_rdf_places.xml">
                    <dcterms:title>Daten zu Orten aus der Edition "Selbstzeugnisse der Frühen Neuzeit in der Herzog August Bibliothek II"</dcterms:title>
                    <schema:license>https://creativecommons.org/publicdomain/zero/1.0/</schema:license>
                    <dcterms:created><xsl:value-of select="substring(string(current-date()),1,4)"/></dcterms:created>
                    <dcterms:modified><xsl:value-of select="current-date()"/></dcterms:modified>
                    <dcterms:contributor>Maximilian Görmar, Herzog August Bibliothek Wolfenbüttel (goermar@hab.de)</dcterms:contributor>
                </rdf:Description>
                <xsl:for-each select="//tei:place[descendant::tei:placeName/@ref]">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:place[descendant::tei:placeName/@ref]">
        <xsl:variable name="place_id" select="@xml:id"/>
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:choose>
                    <xsl:when test="contains(tei:placeName/@ref,'geonames')">
                        <xsl:text>http://sws.geonames.org/</xsl:text>
                        <xsl:value-of select="substring-before(substring-after(tei:placeName/@ref,'www.geonames.org/'),'/')"/>
                        <xsl:text>/</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tei:placeName/@ref"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>          
            <rdf:type rdf:resource="http://erlangen-crm.org/current/E53_Place"/>
            <rdf:type rdf:resource="http://schema.org/Place"/>
            <schema:mainEntityOfPage>
                <xsl:text>http://selbstzeugnisse.hab.de/sz2/orte#</xsl:text>
                <xsl:value-of select="@xml:id"/>
            </schema:mainEntityOfPage>
            <rdfs:label>
                <xsl:value-of select="normalize-space(tei:placeName)"/>
            </rdfs:label>
            <xsl:if test="tei:note">
                <rdfs:comment xml:lang="de">
                    <xsl:value-of select="normalize-space(tei:note)"/>
                </rdfs:comment>
            </xsl:if>            
            <xsl:for-each select="$diaryData//tei:div[@type='volume']/descendant::tei:rs[@type='place'][contains(@ref, concat('#',current()/@xml:id)) and not(contains(@ref, concat(current()/@xml:id,'_')))][not(contains(@ref, preceding::tei:rs[@type='place'][position()=1]/@ref))]">
                <ecrm:P67i_is_referred_to_by>
                    <xsl:attribute name="rdf:resource">
                        <xsl:text>http://selbstzeugnisse.hab.de/sz2/</xsl:text>
                        <xsl:value-of select="ancestor::tei:TEI/@xml:id/substring-after(.,'sz2.')"/>
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="$place_id"/>
                        <xsl:text>_</xsl:text>
                        <xsl:value-of select="preceding::tei:pb[1]/@n"/>
                    </xsl:attribute>  
                </ecrm:P67i_is_referred_to_by>                
            </xsl:for-each>
        </rdf:Description>
    </xsl:template>
    
</xsl:stylesheet>