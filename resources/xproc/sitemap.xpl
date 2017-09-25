<p:declare-step version="1.0"
                xmlns:p="http://www.w3.org/ns/xproc">

  <p:input  port="source" sequence="false" primary="true"/>
  <p:output port="result" sequence="false" primary="true"/>

  <p:xinclude/>

  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="sitemap.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>
  
</p:declare-step>
