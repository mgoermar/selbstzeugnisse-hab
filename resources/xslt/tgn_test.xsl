<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns:gvp="http://vocab.getty.edu/ontology#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:schema="http://schema.org/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns="http://www.tei-c.org/ns/1.0" version="2.0">

    <xsl:template match="/">
      <xsl:apply-templates select="//tei:place[1]"/>
    </xsl:template>
  
  <xsl:template match="tei:place">
    <xsl:for-each select="descendant::tei:idno">
      <xsl:value-of select="doc(concat(.,'.rdf'))//rdfs:label[1]"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
