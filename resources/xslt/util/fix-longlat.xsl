<xsl:transform version="3.0"
               expand-text="yes"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:template match="geo">
    <xsl:variable name="geo" select="tokenize(normalize-space(), ' ')"/>
    <xsl:copy>{$geo[2]} {$geo[1]}</xsl:copy>
  </xsl:template>

</xsl:transform>
