<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs tei" version="2.0">

    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">

        <xsl:result-document indent="yes" href="listBibl_s2_vereinfacht.xml">
            <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="sz2_bibliographie">
                <xsl:copy-of select="tei:teiHeader"/>
                <text>
                    <body>
                        <listBibl xml:id="bibliographie">
                            <xsl:for-each select="//tei:bibl">
                                <bibl xml:id="{@xml:id}">
                                    <xsl:if test="tei:author">
                                        <xsl:call-template name="authorname"/>
                                    </xsl:if>
                                    <xsl:if test="@type = 'book'">
                                        <xsl:value-of
                                            select="normalize-space(tei:title[@level = 'm'])"/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="tei:editor[@role = 'translator']">
                                        <xsl:call-template name="translator"/>
                                    </xsl:if>
                                    <xsl:if test="tei:pubPlace">
                                        <xsl:value-of select="tei:pubPlace"/>
                                        <xsl:text>: </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="tei:publisher">
                                        <xsl:value-of select="tei:publisher"/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="tei:date">
                                        <xsl:value-of select="tei:date"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:choose>
                                        <xsl:when test="tei:ptr[@type = 'opac']">
                                            <xsl:copy-of select="tei:ptr"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <ptr type="gvk" cRef="{substring-after(@ref,'ppn_')}"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="tei:note">
                                        <xsl:copy-of select="tei:note"/>
                                    </xsl:if>
                                </bibl>
                            </xsl:for-each>
                        </listBibl>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>

    </xsl:template>

    <xsl:template name="authorname">
        <xsl:choose>
            <xsl:when test="tei:author/tei:name[not(. = 'N. N.')]">
                <xsl:value-of select="tei:author/tei:name"/>
                <xsl:text>: </xsl:text>
            </xsl:when>
            <xsl:when test="tei:author/tei:forename">
                <xsl:value-of select="tei:author/tei:surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="tei:author/tei:forename"/>
                <xsl:if test="tei:author/tei:nameLink">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="tei:author/tei:nameLink"/>
                </xsl:if>
                <xsl:text>: </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="translator">
        <xsl:text>übers. von </xsl:text>
        <xsl:value-of select="tei:editor[@role = 'translator']/tei:forename"/>
        <xsl:text> </xsl:text>
        <xsl:if test="tei:editor[@role = 'translator']/tei:nameLink">
            <xsl:value-of select="tei:editor[@role = 'translator']/tei:nameLink"/>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="tei:editor[@role = 'translator']/tei:surname"/>
        <xsl:text>, </xsl:text>
    </xsl:template>

</xsl:stylesheet>
