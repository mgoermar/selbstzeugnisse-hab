<?xml version="1.0" encoding="utf-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
  <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
  <pattern>
    <rule context="tei:rs[@type = 'person' or @type = 'place'][@ref]">
      <assert test="not(matches(substring-after(@ref, '#'), '[^a-zA-Z0-9_.+\-]'))">
        Der Wert des @ref-Attributs enthält ungültige Zeichen. Erlaubt sind Buchstaben, Ziffern sowie die Zeichen '_', '.', '+' und '-'.
      </assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="tei:*[contains(string-join(text() | */text(), ''), 'facit')]">
      <assert test="self::tei:foreign or child::tei:foreign[.='facit']">
        Experimentell: 'facit' noch nicht als fremdsprachige Passage markiert
      </assert>
    </rule>
  </pattern>
</schema>
