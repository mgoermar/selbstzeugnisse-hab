<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0"
               exclude-result-prefixes="tei"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:tei="http://www.tei-c.org/ns/1.0">
  
  <xsl:import href="default.xsl"/>

  <xsl:template match="tei:text/tei:body">
    <div class="navigation">
      <xsl:call-template name="navigation"/>
    </div>
    <div class="mainpage">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="tei:p[tei:address]">
    <xsl:apply-templates/>
  </xsl:template>
  
</xsl:transform>
