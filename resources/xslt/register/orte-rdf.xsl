<xsl:transform version="1.0"
               exclude-result-prefixes="tei xrd"
               xmlns:dct="http://purl.org/dc/terms/"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:xrd="http://docs.oasis-open.org/ns/xri/xrd-1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" media-type="application/rdf+xml" indent="yes" encoding="utf-8"/>

  <xsl:variable name="linkmap" select="document('linkmap.xml', /)"/>

  <xsl:template match="tei:TEI">
    <rdf:RDF>
      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <xsl:template match="tei:idno[@type = 'URI']">
    <xsl:variable name="refUri" select="normalize-space()"/>
    <xsl:for-each select="$linkmap/xrd:XRDS/xrd:XRD[xrd:Link[substring-after(@href, '#') = current()/../@xml:id]]">
      <rdf:Description rdf:about="{xrd:Subject}">
        <dct:references rdf:resource="{$refUri}"/>
      </rdf:Description>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:transform>
