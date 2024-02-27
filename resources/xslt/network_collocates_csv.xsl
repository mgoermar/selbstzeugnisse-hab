<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="data" select="collection('../daten/sz2/tagebuecher?select=*.xml;recurse=no')"/>
    
    <xsl:template match="/">
        <xsl:result-document href="network_dates_edges.csv">
            <xsl:text>source;target;manuscript&#xA;</xsl:text>
            <xsl:for-each select="$data//tei:rs[@type='person'][not(contains(@ref,' '))][preceding::tei:date[ancestor::tei:div][1]][ancestor::tei:div[@type='volume']]/@ref">
                <!--<xsl:variable name="current_person" select="."/>-->
                <xsl:value-of select="substring-after(.,'#')"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="preceding::tei:date[ancestor::tei:div][1]/@when"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="ancestor::tei:TEI/@n"/>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
        <xsl:result-document href="network_dates_nodes.csv">
            <xsl:text>id;label;type&#xA;</xsl:text>
            <xsl:for-each select="$data//tei:rs[@type='person'][not(contains(@ref,' '))][preceding::tei:date[ancestor::tei:div][1]]/@ref">
                <!--<xsl:variable name="current_person" select="."/>-->
                <xsl:value-of select="substring-after(.,'#')"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="substring-after(.,'#')"/>
                <xsl:text>;person</xsl:text>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
            <xsl:for-each select="$data//tei:date/@when">
                <xsl:value-of select="."/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>;date</xsl:text>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
            
            
</xsl:stylesheet>