<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html"/>
    <xsl:strip-space elements="*"/>
  <xsl:variable name="data" select="collection('../daten/sz2/tagebuecher?select=*.xml;recurse=no')"/>
<!--    <xsl:variable name="currentDoc" select="document(concat('../',//tei:TEI/substring-after(@xml:id,'fg_'),'.xml'))"/>-->
  
    
    <xsl:template match="/">
        <xsl:result-document href="network_dates.html">
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title></title>
    <style type="text/css">
      body { margin: 0; background-color: #f3f3f3; }
      #graph { position: absolute; width: 100%; height: 100%; }
  </style>
  </head>

  <body>

    <div id="graph"></div>

    <script src="../../js/sigma/sigma.min.js"></script>
    <script src="../../js/sigma/sigma.layout.forceAtlas2.min.js"></script>
    <script>

window.onload = function () {

var persons = [
      <xsl:for-each select="distinct-values($data//tei:rs[@type='person'][not(contains(@ref,' '))]/@ref)">
        <xsl:variable name="current_person" select="."/>
      {        
            person: "<xsl:value-of select="substring-after(.,'#')"/>",
            paragraphs: [
        <xsl:for-each select="$data//tei:rs[@type='person'][preceding::tei:date[ancestor::tei:div]][@ref=$current_person]/preceding::tei:date[1]">
          <xsl:value-of select="concat('&quot;',./@when,'&quot;')"/>
                <xsl:if test="position()!=last()">
                    <xsl:text>,</xsl:text>
                </xsl:if>
            </xsl:for-each>
            ]
            }
            <xsl:if test="position()!=last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
];

window.g = new sigma("graph");
g.settings({
  defaultNodeColor: '#ec5148',
  sideMargin: 20
});
persons.forEach(function(person, idx){
  var theta = idx*2*Math.PI / persons.length;
  g.graph.addNode({
    id: ""+idx,
    label: person.person,
    x: Math.sin(theta),
    y: Math.cos(theta),
    size: 1
  });
})
for (var srcIdx=0; srcIdx&lt;persons.length; srcIdx++) {
  var src = persons[srcIdx];
  for (var mscIdx=0; mscIdx&lt;src.paragraphs.length; mscIdx++) {
    var msc = src.paragraphs[mscIdx];
    for (var tgtIdx=srcIdx+1; tgtIdx&lt;persons.length; tgtIdx++) {
      var tgt = persons[tgtIdx];
      if (tgt.paragraphs.some(function(tgtMsc) {return tgtMsc === msc;})) {
        g.graph.addEdge({
          id: srcIdx + "." + mscIdx + "-" + tgtIdx,
          source: ""+srcIdx,
          target: ""+tgtIdx
        })
      }
    }
  }
}
g.startForceAtlas2();
setTimeout(function() {g.stopForceAtlas2();}, 1500);
g.bind('clickNode', function(ev) {
  var nodeIdx = ev.data.node.id;
  var neighbors = [];
  g.graph.edges().forEach(function(edge) {
    if ((edge.target === nodeIdx) || (edge.source === nodeIdx)) {
      edge.color = '#555';
      neighbors.push(edge.target);
      neighbors.push(edge.source);
    } else {
      edge.color = '#ec5148';
    }
  });
  g.graph.nodes().forEach(function(node) {
    if (neighbors.some(function(n){return n === node.id})) {
      node.color = '#555';
    } else {
      node.color = '#ec5148';
    }
  });
  g.refresh();
});

};

    </script>
  </body>
</html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>