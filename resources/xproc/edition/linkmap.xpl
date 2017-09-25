<p:declare-step version="1.0"
                xmlns:p="http://www.w3.org/ns/xproc">

  <p:input  port="source" primary="true"/>
  <p:output port="result" primary="true"/>

  <p:xinclude/>
  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="linkmap.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>

</p:declare-step>
