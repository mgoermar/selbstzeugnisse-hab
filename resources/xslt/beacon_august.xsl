<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/TR/2004/REC-rdf-syntax-grammar-20040210/"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exist="http://exist.sourceforge.net/NS/exist" xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="tei mets xlink exist rdf" version="2.0">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <xsl:result-document href="beacon.txt">
            <xsl:text>#FORMAT: BEACON&#13;#PREFIX: http://d-nb.info/gnd/&#13;#INSTITUTION: Herzog August Bibliothek Wolfenb&#xFC;ttel&#13;#NAME: Personenregister "Selbstzeugnisse der Frühen Neuzeit in der Herzog August Bibliothek I"&#13;#FEED: http://selbstzeugnisse.hab.de/beacon.txt&#13;#TARGET: http://selbstzeugnisse.hab.de/edition/personen#{ID}&#13;#TIMESTAMP: </xsl:text><xsl:value-of select="current-date()"/><xsl:text>&#13;</xsl:text>
            <xsl:for-each select="//tei:person[tei:idno[contains(.,'gnd')]]">
                <xsl:value-of select="tei:idno/normalize-space(substring-after(.,'gnd/'))"/>
                <xsl:text>||</xsl:text>
                <xsl:value-of select="normalize-space(@xml:id)"/>
                <xsl:text>&#13;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>