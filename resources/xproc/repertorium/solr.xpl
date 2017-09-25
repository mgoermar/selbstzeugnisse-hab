<p:declare-step version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:s="http://selbstzeugnisse.hab.de/ns">

  <p:documentation>Alle Selbstzeugnisbeschreibungen für die Suche indexieren</p:documentation>

  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>
  <p:import href="library.xpl"/>

  <p:declare-step type="s:repertorium-solr">
    <p:documentation>Indexiert einen einzelnen Datensatz</p:documentation>
    
    <p:input  port="source" primary="true" sequence="true"/>
    <p:output port="result" primary="true" sequence="true"/>
    
    <cx:message>
      <p:with-option name="message" select="concat('Indexiere ', document-uri(/))"/>
    </cx:message>

    <p:xslt>
      <p:input port="stylesheet">
        <p:document href="solr.xsl"/>
      </p:input>
      <p:input port="parameters">
        <p:empty/>
      </p:input>
    </p:xslt>

    <p:http-request method="xml"/>

  </p:declare-step>

  <s:repertorium-einträge/>
  <p:for-each>
    <p:iteration-source select="/c:directory/c:directory/c:file"/>
    <p:load>
      <p:with-option name="href" select="concat(base-uri(), /c:file/@name)"/>
    </p:load>
    <p:xinclude/>
    <s:repertorium-solr/>
  </p:for-each>

  <p:sink/>

</p:declare-step>
