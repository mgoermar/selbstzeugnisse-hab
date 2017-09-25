<xsl:transform version="2.0"
               exclude-result-prefixes="#all"
               xmlns:c="http://www.w3.org/ns/xproc-step"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="metsId" required="yes"/>

  <xsl:template match="/">
    <c:request method="POST" href="http://194.95.134.40:8080/solr/selbst-ft/update" detailed="true">
      <c:body content-type="application/xml">
        <add commitWithin="100">
          <doc>
            <field name="id"><xsl:value-of select="$metsId"/></field>
            <field name="title"><xsl:value-of select="/html/head/title"/></field>
            <xsl:apply-templates select="//div[tokenize(@class, ' ') = 'mainpage']"/>
          </doc>
        </add>
      </c:body>
    </c:request>
  </xsl:template>

  <xsl:template match="h1" priority="10">
    <field name="title">
      <xsl:apply-templates select="."/>
    </field>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*">
    <field name="text">
      <xsl:value-of select="normalize-space(string-join(descendant::text(), ' '))"/>
    </field>
  </xsl:template>

</xsl:transform>
