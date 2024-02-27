<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:agrelon="https://d-nb.info/standards/elementset/agrelon#"
    xmlns:gndo="https://d-nb.info/standards/elementset/gnd#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="tei xs"
    version="2.0">
    <xsl:output method="text"/>
    
    <xsl:template match="/">
        <xsl:result-document href="netzwerk_ludwig_rudolph_edges.csv">
            <xsl:text>source,target,edgetype&#13;</xsl:text>
            <xsl:for-each select="//tei:person[descendant::tei:persName/@ref[contains(.,'gnd')]]">
                <xsl:apply-templates select="." mode="edges"/>
            </xsl:for-each>
        </xsl:result-document>
        <xsl:result-document href="netzwerk_ludwig_rudolph_nodes.csv">
            <xsl:text>id;label&#13;</xsl:text>
            <xsl:for-each select="//tei:person[descendant::tei:persName/@ref[contains(.,'gnd')]]">
                <xsl:apply-templates select="." mode="nodes"/>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:person" mode="edges">
        <xsl:variable name="currentperson" select="descendant::tei:persName/@ref[contains(.,'gnd')]"/>
        <xsl:for-each select="document(concat('https://d-nb.info/gnd/',substring-after($currentperson,'gnd/'),'/about/lds.rdf'))">
            <xsl:for-each select="//agrelon:hasParent">
                <xsl:value-of select="@rdf:resource"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="$currentperson"/>
                <xsl:text>,Elternteil von&#13;</xsl:text>                
            </xsl:for-each>
            <xsl:for-each select="//agrelon:hasSpouse">
                <xsl:value-of select="$currentperson"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="@rdf:resource"/>
                <xsl:text>,verheiratet mit&#13;</xsl:text>                
            </xsl:for-each>
            <xsl:for-each select="//agrelon:hasChild">
                <xsl:value-of select="$currentperson"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="@rdf:resource"/>
                <xsl:text>,Elternteil von&#13;</xsl:text>                
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:person" mode="nodes">
        <xsl:variable name="currentperson" select="descendant::tei:persName/@ref[contains(.,'gnd')]"/>
        <xsl:value-of select="$currentperson"/>
        <xsl:text>;</xsl:text>
        <xsl:value-of select="normalize-space($currentperson/ancestor::tei:person/tei:persName[@type='display'])"/>
        <xsl:text>&#13;</xsl:text>
        <xsl:for-each select="document(concat('https://d-nb.info/gnd/',substring-after($currentperson,'gnd/'),'/about/lds.rdf'))">
            <xsl:for-each select="//agrelon:hasParent">
                <xsl:value-of select="@rdf:resource"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="document(concat(@rdf:resource,'/about/lds.rdf'))//gndo:preferredNameForThePerson"/>
                <xsl:text>&#13;</xsl:text>                
            </xsl:for-each>
            <xsl:for-each select="//agrelon:hasSpouse">
                <xsl:value-of select="@rdf:resource"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="document(concat(@rdf:resource,'/about/lds.rdf'))//gndo:preferredNameForThePerson"/>
                <xsl:text>&#13;</xsl:text>                
            </xsl:for-each>
            <xsl:for-each select="//agrelon:hasChild">
                <xsl:value-of select="@rdf:resource"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="document(concat(@rdf:resource,'/about/lds.rdf'))//gndo:preferredNameForThePerson"/>
                <xsl:text>&#13;</xsl:text>                
            </xsl:for-each>        
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>