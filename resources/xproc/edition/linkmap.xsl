<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns="http://docs.oasis-open.org/ns/xri/xrd-1.0"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="TEI">
    <XRDS>
      <xsl:apply-templates/>
    </XRDS>
  </xsl:template>

  <xsl:template match="div[head/date][descendant::rs[starts-with(@ref, 'register.xml#')]]">
    <XRD>
      <Subject>
        <xsl:text>http://selbstzeugnisse.hab.de/edition/diarium/</xsl:text>
        <xsl:value-of select="substring-before(tokenize(base-uri(.), '/')[last()], '.xml')"/>
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@xml:id"/>
      </Subject>
      <xsl:call-template name="references">
        <xsl:with-param name="label" select="string-join(reverse(tokenize(head/date/@when, '-')), '.')" />
      </xsl:call-template>
    </XRD>
  </xsl:template>

  <xsl:template name="references">
    <xsl:param name="label" as="xs:string?"/>
    <xsl:for-each-group select=".//rs[starts-with(@ref, 'register.xml#')]" group-by="@ref">
      <xsl:sort select="@ref"/>
      <Link rel="http://purl.org/dc/terms/references" href="{@ref}">
        <Title><xsl:value-of select="$label"/></Title>
      </Link>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:transform>
