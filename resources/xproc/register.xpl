<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xml:base="../"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:d="http://dmaus.name/ns/xproc"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">

  <p:serialization port="result" method="xml" normalization-form="NFC"/>

  <p:input port="source"/>
  <p:output port="result"/>

  <p:declare-step type="d:load-rdf">
    <p:option name="targetUri" required="true"/>
    <p:output port="result" primary="true"/>

    <p:choose>
      <p:when test="doc-available($targetUri)">
        <p:load>
          <p:with-option name="href" select="$targetUri"/>
        </p:load>
      </p:when>
      <p:otherwise>
        <p:identity>
          <p:input port="source">
            <p:inline>
              <rdf:RDF/>
            </p:inline>
          </p:input>
        </p:identity>
      </p:otherwise>
    </p:choose>
  </p:declare-step>

  <p:declare-step type="d:load-rdf.tgn">
    <p:option name="id" required="true"/>
    <p:output port="result"/>
    <d:load-rdf>
      <p:with-option name="targetUri" select="concat('auxdata/tgn/', $id, '.rdf')"/>
    </d:load-rdf>
  </p:declare-step>

  <p:declare-step type="d:load-rdf.gnd">
    <p:option name="id" required="true"/>
    <p:output port="result"/>
    <d:load-rdf>
      <p:with-option name="targetUri" select="concat('auxdata/gnd/', $id, '.rdf')"/>
    </d:load-rdf>
  </p:declare-step>

  <p:declare-step type="d:rdf-to-tei.gnd" name="rdf-to-tei.gnd">
    <p:input port="source"/>
    <p:output port="result"/>

    <p:variable name="gndId" select="normalize-space(tei:person/tei:persName/@key)"/>

    <d:load-rdf.gnd>
      <p:with-option name="id" select="$gndId"/>
    </d:load-rdf.gnd>

    <p:xslt>
      <p:input port="parameters"><p:empty/></p:input>
      <p:input port="stylesheet">
        <p:document href="xslt/gnd2tei.xsl"/>
      </p:input>
    </p:xslt>

    <p:set-attributes match="/*">
      <p:input port="attributes">
        <p:pipe port="source" step="rdf-to-tei.gnd"/>
      </p:input>
    </p:set-attributes>

  </p:declare-step>

  <p:declare-step type="d:rdf-to-tei.tgn" name="rdf-to-tei.tgn">
    <p:input port="source"/>
    <p:output port="result"/>

    <p:variable name="tgnId" select="normalize-space(tei:place/tei:placeName/@key)"/>

    <d:load-rdf.tgn>
      <p:with-option name="id" select="$tgnId"/>
    </d:load-rdf.tgn>

    <p:try>
      <p:group>
        <p:xslt>
          <p:input port="parameters"><p:empty/></p:input>
          <p:input port="stylesheet">
            <p:document href="xslt/tgn2tei.xsl"/>
          </p:input>
        </p:xslt>
      </p:group>
      <p:catch>
        <p:identity>
          <p:input port="source">
            <p:inline>
              <error/>
            </p:inline>
          </p:input>
        </p:identity>
      </p:catch>
    </p:try>


    <p:set-attributes match="/*">
      <p:input port="attributes">
        <p:pipe port="source" step="rdf-to-tei.tgn"/>
      </p:input>
    </p:set-attributes>

  </p:declare-step>

  <p:viewport match="tei:person[normalize-space(tei:persName/@key)]">
    <d:rdf-to-tei.gnd/>
  </p:viewport>

  <p:viewport match="tei:place[normalize-space(tei:placeName/@key)]">
    <d:rdf-to-tei.tgn/>
  </p:viewport>

</p:declare-step>
