<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="/">
        <xsl:result-document href="listPlace_geobrowser2.csv">
            <xsl:text>Name,Latitude,Longitude&#xA;</xsl:text>
            <xsl:for-each select="//tei:place">
                <xsl:value-of select="@xml:id"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="tei:location/tei:geo/substring-before(.,' ')"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="tei:location/tei:geo/substring-after(.,' ')"/>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>  
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>