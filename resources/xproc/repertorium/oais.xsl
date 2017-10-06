<xsl:transform version="2.0"
               xpath-default-namespace="http://www.tei-c.org/ns/1.0"
               xmlns="http://www.openarchives.org/OAI/2.0/static-repository"
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:oai="http://www.openarchives.org/OAI/2.0/"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="oais-tei2dc.xsl"/>
  
  <xsl:template match="/">
    <Repository xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/static-repository http://www.openarchives.org/OAI/2.0/static-repository.xsd">
      <Identify>
        <oai:repositoryName>Selbstzeugnisse der Frühen Neuzeit in der Herzog August Bibliothek – Repertorium</oai:repositoryName>
        <oai:baseURL>http://selbstzeugnisse.hab.de/repertorium.xml</oai:baseURL>
        <oai:protocolVersion>2.0</oai:protocolVersion>
        <oai:adminEmail>maus@hab.de</oai:adminEmail>
        <oai:earliestDatestamp><xsl:value-of select="format-date(current-date(), '[Y]-[M01]-[D01]')"/></oai:earliestDatestamp>
        <oai:deletedRecord>no</oai:deletedRecord>
        <oai:granularity>YYYY-MM-DD</oai:granularity>
      </Identify>
      <ListMetadataFormats>
        <oai:metadataFormat>
          <oai:metadataPrefix>oai_dc</oai:metadataPrefix>
          <oai:schema>http://www.openarchives.org/OAI/2.0/oai_dc.xsd</oai:schema>
          <oai:metadataNamespace>http://www.openarchives.org/OAI/2.0/oai_dc/</oai:metadataNamespace>
        </oai:metadataFormat>
        <oai:metadataFormat>
          <oai:metadataPrefix>tei</oai:metadataPrefix>
          <oai:schema>http://selbstzeugnisse.hab.de/repertorium.xsd</oai:schema>
          <oai:metadataNamespace>http://www.tei-c.org/ns/1.0</oai:metadataNamespace>
        </oai:metadataFormat>
      </ListMetadataFormats>
      <ListRecords metadataPrefix="tei">
        <xsl:apply-templates mode="tei"/>
      </ListRecords>
      <ListRecords metadataPrefix="oai_dc">
        <xsl:apply-templates mode="oai_dc"/>
      </ListRecords>
    </Repository>
  </xsl:template>

  <xsl:template match="TEI" mode="tei">
    <oai:record>
      <xsl:call-template name="header"/>
      <oai:metadata>
        <xsl:sequence select="."/>
      </oai:metadata>
    </oai:record>
  </xsl:template>

  <xsl:template match="TEI" mode="oai_dc">
    <oai:record>
      <xsl:call-template name="header"/>
      <oai:metadata>
        <xsl:apply-templates select=".//msDesc"/>
      </oai:metadata>
    </oai:record>
  </xsl:template>

  <xsl:template name="header">
    <oai:header>
      <oai:identifier><xsl:value-of select="concat('oai:selbstzeugnisse.hab.de:', tokenize(@xml:id, '\.')[3])"/></oai:identifier> 
      <oai:datestamp><xsl:value-of select="format-date(current-date(), '[Y]-[M01]-[D01]')"/></oai:datestamp>
    </oai:header>
  </xsl:template>
  
</xsl:transform>
