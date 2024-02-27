<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <xsl:variable name="listPlace" select="document('../../daten/edition/diarium/register_orte.xml')"/>
    
    <xsl:output method="text"/>
    
    <xsl:template match="/">
        <xsl:result-document href="Geobrowserdaten/listPlace_geobrowser_{//tei:TEI/@n}.csv">
            <xsl:text>Name,TimeStamp,Latitude,Longitude&#xA;</xsl:text>
            <xsl:for-each select="//tei:rs[@type='place']">
                <xsl:value-of select="substring-after(@ref,'#')"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="ancestor::tei:div/substring-after(@xml:id,'E')"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$listPlace//tei:place[@xml:id=current()/substring-after(@ref,'#')]/descendant::tei:location/tei:geo/substring-before(.,' ')"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$listPlace//tei:place[@xml:id=current()/substring-after(@ref,'#')]/descendant::tei:location/tei:geo/substring-after(.,' ')"/>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>  
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>