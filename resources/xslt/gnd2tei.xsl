<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="gnd rdf"
    xmlns:gnd="http://d-nb.info/standards/elementset/gnd#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns="http://www.tei-c.org/ns/1.0" version="2.0">
    
    <xsl:template match="/">
        <person>
            <idno type="URI"><xsl:value-of select="/rdf:RDF/rdf:Description/@rdf:about"/></idno>
            <xsl:apply-templates/>
        </person>
    </xsl:template>
    
    <xsl:template match="gnd:preferredNameForThePerson">
        <persName type="display"><xsl:value-of select="normalize-space()"/></persName>
    </xsl:template>
    
    <xsl:template match="text()"/>
    
</xsl:stylesheet>
