<p:declare-step name="main" version="1.0"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:p="http://www.w3.org/ns/xproc">

  <p:input  port="source" primary="true"/>
  <p:output port="result" primary="true" sequence="true"/>

  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>

  <p:xinclude/>

  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="prepare-mets.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>

  <p:for-each>
    <p:iteration-source select="/transformations/transformation"/>
    <p:variable name="metsId" select="transformation/@id"/>
    <p:variable name="source" select="transformation/@source"/>
    <p:variable name="stylesheet" select="transformation/@stylesheet"/>
    <p:load name="source">
      <p:with-option name="href" select="concat('../../', $source)"/>
    </p:load>
    <p:load name="stylesheet">
      <p:with-option name="href" select="concat('../../', $stylesheet)"/>
    </p:load>
    <p:xslt>
      <p:input port="source">
        <p:pipe step="source" port="result"/>
      </p:input>
      <p:input port="stylesheet">
        <p:pipe step="stylesheet" port="result"/>
      </p:input>
      <p:input port="parameters">
        <p:empty/>
      </p:input>
    </p:xslt>

    <p:xslt>
      <p:with-param name="metsId" select="$metsId"/>
      <p:input port="stylesheet">
        <p:document href="fulltext.xsl"/>
      </p:input>
    </p:xslt>

    <cx:message>
      <p:with-option name="message" select="concat('Indexiere ', $metsId)"/>
    </cx:message>

    <p:http-request method="xml"/>

  </p:for-each>

</p:declare-step>
