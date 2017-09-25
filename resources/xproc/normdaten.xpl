<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xml:base="../"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:d="http://dmaus.name/ns/xproc"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">

  <p:documentation>Download der in einem Register verlinkten Normdaten</p:documentation>

  <p:input port="source"/>

  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>

  <p:declare-step type="d:download-record">
    <p:input port="source"/>
    <p:output port="download-record" primary="true"/>

    <p:variable name="sourceUri" select="record/@source"/>
    <p:variable name="targetUri" select="record/@target"/>

    <cx:message>
      <p:with-option name="message" select="concat($sourceUri, ' >> ', $targetUri)"/>
    </cx:message>

    <p:xslt>
      <p:input port="stylesheet">
        <p:inline>
          <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
            <xsl:template match="record">
              <c:request href="{@source}" method="get" detailed="true">
                <c:header name="Accept" value="application/rdf+xml"/>
              </c:request>
            </xsl:template>
          </xsl:stylesheet>
        </p:inline>
      </p:input>
      <p:input port="parameters"><p:empty/></p:input>
    </p:xslt>

    <p:try>
      <p:group>
        <p:http-request/>
        <p:choose>
          <p:when test="/c:response[@status = '200']/c:body/rdf:RDF">
            <p:filter select="/c:response[@status = '200']/c:body/rdf:RDF"></p:filter>
            <p:store>
              <p:with-option name="href" select="$targetUri"></p:with-option>
            </p:store>
            <p:identity>
              <p:input port="source">
                <p:inline>
                  <record status="200"/>
                </p:inline>
              </p:input>
            </p:identity>
          </p:when>
          <p:otherwise>
            <p:variable name="status" select="/c:response/@status"/>
            <p:identity>
              <p:input port="source">
                <p:inline>
                  <record/>
                </p:inline>
              </p:input>
            </p:identity>
            <p:add-attribute match="record" attribute-name="status">
              <p:with-option name="attribute-value" select="$status"/>
            </p:add-attribute>
          </p:otherwise>
        </p:choose>
      </p:group>
      <p:catch>
        <p:identity>
          <p:input port="source">
            <p:inline>
              <record status="error"/>
            </p:inline>
          </p:input>
        </p:identity>
      </p:catch>
    </p:try>

    <p:add-attribute match="*" attribute-name="source">
      <p:with-option name="attribute-value" select="$sourceUri"/>
    </p:add-attribute>

    <p:add-attribute match="*" attribute-name="target">
      <p:with-option name="attribute-value" select="$targetUri"/>
    </p:add-attribute>

  </p:declare-step>

  <p:xslt>
    <p:input port="parameters"><p:empty/></p:input>
    <p:input port="stylesheet">
      <p:inline>
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

          <xsl:template match="/">
            <download>
              <xsl:apply-templates/>
            </download>
          </xsl:template>

          <xsl:template match="tei:persName[@key != '']">
            <xsl:variable name="key" select="normalize-space(@key)"/>
            <record source="http://d-nb.info/gnd/{$key}" target="auxdata/gnd/{$key}.rdf" id="{$key}"/>
          </xsl:template>

          <xsl:template match="tei:placeName[@key != '']">
            <xsl:variable name="key" select="normalize-space(@key)"/>
            <record source="http://vocab.getty.edu/tgn/{$key}" target="auxdata/tgn/{$key}.rdf" id="{$key}"/>
          </xsl:template>

          <xsl:template match="text()"/>

        </xsl:stylesheet>
      </p:inline>
    </p:input>

  </p:xslt>

  <p:viewport match="record">
    <p:choose>
      <p:when test="not(doc-available(record/@target))">
        <d:download-record/>
      </p:when>
      <p:otherwise>
        <cx:message>
          <p:with-option name="message" select="concat('OK ', record/@target)"/>
        </cx:message>
        <p:identity/>
      </p:otherwise>
    </p:choose>
  </p:viewport>

  <p:sink/>

</p:declare-step>
