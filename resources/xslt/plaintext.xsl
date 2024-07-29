<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">
    <xsl:variable name="data" select="collection('..?select=16*.xml')"/>
    <xsl:output method="text" encoding="UTF-16"/>
<!--    <xsl:strip-space elements="*"/>-->
    
    <xsl:template match="/">
<!--        <xsl:result-document href="{tei:TEI/@xml:id/substring-after(.,'fg_')}.txt">-->
            <xsl:for-each select="//tei:text/tei:body/descendant::tei:div">
                <xsl:apply-templates select="tei:head"/>
                <xsl:apply-templates select="tei:p"/>
            </xsl:for-each>
        <!--</xsl:result-document>-->
    </xsl:template>
    
    <xsl:template match="tei:note[@type!='contemporary']"/>
    
    <xsl:template match="tei:note[not(@type)]"/>
        
    <xsl:template match="tei:w[@lemma]">
        <xsl:value-of select="@lemma"/>
    </xsl:template>
    
    <xsl:template match="tei:w[not(@lemma)]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:lb[ancestor::tei:w]"/>    
    
    <xsl:template match="tei:lb[not(ancestor::tei:w)]">
        <xsl:if test="preceding-sibling::tei:lb">
            <xsl:text> </xsl:text>
        </xsl:if>
<!--        <xsl:text>&#13;</xsl:text>-->
    </xsl:template>
    
    <xsl:template match="tei:head">
<!--        <xsl:text>&#13;</xsl:text>-->
        <xsl:apply-templates/>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <xsl:apply-templates/>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:del"/>
    
    <xsl:template match="text()[normalize-space(.)!='']">
        <xsl:choose>
            <xsl:when test="starts-with (.,' ') and ends-with(.,' ')">
                <xsl:text> </xsl:text>
                <xsl:value-of select="normalize-space()"/>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="starts-with (.,' ') and not(ends-with(.,' '))">
                <xsl:text> </xsl:text>
                <xsl:value-of select="normalize-space()"/>
            </xsl:when>
            <xsl:when test="not(starts-with (.,' ')) and ends-with(.,' ')">
                <xsl:value-of select="normalize-space()"/>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="text()[normalize-space(.)='']">
<!--        <xsl:text> </xsl:text>-->
        <xsl:choose>
            <xsl:when test=".=' '">
                <xsl:value-of select="."/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>