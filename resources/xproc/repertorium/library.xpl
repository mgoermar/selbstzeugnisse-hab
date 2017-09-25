<p:library version="1.0"
           xmlns:c="http://www.w3.org/ns/xproc-step"
           xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:s="http://selbstzeugnisse.hab.de/ns">

  <p:declare-step type="s:repertorium-einträge">
    <p:output port="result" primary="true" sequence="false"/>

    <p:directory-list path="../../daten/repertorium/mss"/>
    <p:viewport match="c:directory/c:directory">
      <p:directory-list>
        <p:with-option name="path" select="concat(base-uri(), c:directory/@name)"/>
      </p:directory-list>
    </p:viewport>
  </p:declare-step>

</p:library>
