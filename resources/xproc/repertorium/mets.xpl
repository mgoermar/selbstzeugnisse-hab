<p:declare-step version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:s="http://selbstzeugnisse.hab.de/ns">

  <p:output port="result"/>

  <p:import href="library.xpl"/>

  <s:repertorium-einträge/>
  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="mets.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>

</p:declare-step>
