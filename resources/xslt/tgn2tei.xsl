<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns:gvp="http://vocab.getty.edu/ontology#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:schema="http://schema.org/"
    xmlns="http://www.tei-c.org/ns/1.0" version="2.0">

    <xsl:template match="/rdf:RDF">
      <place>
        <idno type="URI"><xsl:value-of select="gvp:Subject/@rdf:about"/></idno>
        <xsl:apply-templates select="gvp:Subject"/>
        <xsl:apply-templates select="schema:Place"/>
      </place>
    </xsl:template>

    <xsl:template match="skos:prefLabel[1]">
      <placeName><xsl:value-of select="normalize-space()"/></placeName>
    </xsl:template>

    <xsl:template match="schema:Place[geo:lat and geo:long]">
      <location>
        <geo>
          <xsl:value-of select="geo:lat"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="geo:long"/>
        </geo>
      </location>
    </xsl:template>

    <xsl:template match="text()"/>

</xsl:stylesheet>
