<p:declare-step version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:s="http://selbstzeugnisse.hab.de/ns"
                xmlns:p="http://www.w3.org/ns/xproc">

  <p:import href="library.xpl"/>

  <p:documentation xmlns="http://www.w3.org/1999/xhtml">
    Repertoriumseinträge in <a href="http://www.openarchives.org/OAI/2.0/guidelines-static-repository.htm"
    target="_blank">OAI Static Repository</a> zusammenfasen.
  </p:documentation>

  <p:output port="result" primary="true"/>

  <s:repertorium-einträge/>

  <p:viewport match="c:file">
    <p:load>
      <p:with-option name="href" select="concat(base-uri(), /c:file/@name)"/>
    </p:load>
    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="oais-resolve.xsl"/>
      </p:input>
      <p:input port="parameters">
        <p:empty/>
      </p:input>
    </p:xslt>
  </p:viewport>

  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="oais.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>

</p:declare-step>
