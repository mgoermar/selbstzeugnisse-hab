<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0"
               exclude-result-prefixes="tei mets html map"
               xmlns:map="urn:uuid:88a07861-a998-4c1b-bc3f-cf169a4aab52"
               xmlns:html="http://www.w3.org/1999/xhtml"
               xmlns:mets="http://www.loc.gov/METS/"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:variable name="metsFile" select="document('../mets.xml')"/>
  <xsl:variable name="fileId"   select="/*/@xml:id"/>
  <xsl:variable name="metsId"   select="$metsFile//mets:div[mets:fptr[@FILEID = $fileId]]/@ID"/>

  <map:map>
    <map:entry key="01" value="Januar"/>
    <map:entry key="02" value="Februar"/>
    <map:entry key="03" value="März"/>
    <map:entry key="04" value="April"/>
    <map:entry key="05" value="Mai"/>
    <map:entry key="06" value="Juni"/>
    <map:entry key="07" value="Juli"/>
    <map:entry key="08" value="August"/>
    <map:entry key="09" value="September"/>
    <map:entry key="10" value="Oktober"/>
    <map:entry key="11" value="November"/>
    <map:entry key="12" value="Dezember"/>
  </map:map>

  <xsl:template match="/tei:TEI">
    <html>
      <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <xsl:apply-templates mode="header"/>
        <link rel="schema.DC" href="http://purl.org/dc/elements/1.1/"/>
        <link rel="schema.DCTERMS" href="http://purl.org/dc/terms/"/>
        <!-- Assets -->
        <link rel="stylesheet" href="http://selbstzeugnisse.hab.de/assets/selbstzeugnisse/css/reset.css" media="screen"/>
        <link rel="stylesheet" href="http://selbstzeugnisse.hab.de/assets/font-awesome/css/font-awesome.min.css" media="screen"/>
        <link rel="stylesheet" href="http://selbstzeugnisse.hab.de/assets/selbstzeugnisse/css/selbstzeugnisse.css" media="screen"/>
        <link rel="stylesheet" href="http://selbstzeugnisse.hab.de/assets/selbstzeugnisse/css/print.css" media="print"/>
        <script type="text/javascript" src="http://selbstzeugnisse.hab.de/assets/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="http://selbstzeugnisse.hab.de/assets/jquery-zoom/jquery.zoom.min.js"></script>
        <script type="text/javascript" src="http://selbstzeugnisse.hab.de/assets/selbstzeugnisse/js/selbstzeugnisse.js"></script>
        <script type="text/javascript" src="http://diglib.hab.de/edoc/ed000228/javascript/jquery/jquery-1.11.0.js"/>
        <script type="text/javascript" src="http://diglib.hab.de/edoc/ed000228/javascript/jquery/functions.js"/>
        <script src="http://diglib.hab.de/navigator.js" type="text/javascript"/>
        <!--<script src="http://diglib.hab.de/navigator.js" type="text/javascript"><noscript>please activate javascript to enable wdb functions</noscript></script>
        <noscript>
          <style type="text/css">.js-toggle { display: inherit; }</style>
        </noscript>-->
      </head>
      <body>
        <div class="banner">
          <img src="http://selbstzeugnisse.hab.de/assets/selbstzeugnisse/images/banner_logo.png" class="brand"/>
          <div class="banner-logo">
            <img src="http://selbstzeugnisse.hab.de/assets/selbstzeugnisse/images/banner_logo_hab.png"/>
            <form method="GET" action="/suche">
              <input type="text" name="query" placeholder="&#x1F50E;"/>
            </form>
          </div>
          <div class="banner-slogan">
            <h1>Selbstzeugnisse <small>der Frühen Neuzeit</small></h1>
            <h2>in der Herzog August Bibliothek</h2>
            <h3>Digitale Edition des Diariums von Herzog August dem Jüngeren · Selbstzeugnis-Repertorium · Forschungsportal</h3>
          </div>
        </div>
        <div class="content">
          <xsl:apply-templates/>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="tei:text/tei:body">
    <div class="navigation">
      <xsl:call-template name="navigation"/>
    </div>
    <div class="mainpage">
      <xsl:apply-templates/>
    </div>
    <div class="infopanel facet">
      <ul class="controls">
        <li>
          <a class="fa fa-print" href="javascript:print()"> Drucken</a>
        </li>
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="tei:teiHeader"/>

  <xsl:template match="tei:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="tei:div">
    <div><xsl:apply-templates/></div>
  </xsl:template>

  <xsl:template match="tei:head">
    <xsl:element name="h{count(ancestor::*/tei:head)}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tei:label[parent::tei:div]">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>

  <xsl:template match="tei:ref[@target]">
    <a href="{@target}" target="_blank"><xsl:apply-templates/></a>
  </xsl:template>

  <xsl:template match="tei:ref[@type = 'opac']">
    <a href="http://opac.lbs-braunschweig.gbv.de/DB=2/PPN?PPN={normalize-space(@cRef)}" target="_blank">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="tei:title[ancestor::tei:body]">
    <span class="title"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:list[tei:item/tei:label]">
    <xsl:apply-templates select="tei:head"/>
    <xsl:for-each select="tei:item">
      <h3><xsl:apply-templates select="tei:label"/></h3>
      <ul>
        <xsl:for-each select="tei:desc">
          <li><xsl:apply-templates/></li>
        </xsl:for-each>
      </ul>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tei:list[tei:item/tei:ref]">
    <xsl:apply-templates select="tei:head"/>
    <xsl:for-each select="tei:item">
      <h3><xsl:apply-templates select="tei:ref"/></h3>
      <xsl:for-each select="tei:desc">
        <div>
          <xsl:apply-templates/>
        </div>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tei:listBibl">
    <xsl:apply-templates select="tei:head"/>
    <ul class="list-styled">
      <xsl:for-each select="tei:bibl">
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="mets:div[not(@TYPE)][@LABEL]">
    <li>
      <a href="/{translate(@ID, '.', '/')}">
        <xsl:if test="mets:fptr/@FILEID = $fileId"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
        <xsl:value-of select="@LABEL"/>
      </a>
      <xsl:if test="mets:div">
        <ul>
          <xsl:apply-templates select="mets:div"/>
        </ul>
      </xsl:if>
    </li>
  </xsl:template>

  <xsl:template name="navigation">
    <ul>
      <li>
        <a href="/">
          <xsl:if test="$fileId = 'index.xml'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
          Startseite
        </a>
      </li>
      <xsl:apply-templates select="$metsFile/mets:mets/mets:structMap/mets:div/*"/>
    </ul>
  </xsl:template>

  <xsl:template match="tei:address">
    <address>
      <ul>
        <xsl:for-each select="*">
          <li>
            <xsl:apply-templates/>
          </li>
        </xsl:for-each>
      </ul>
    </address>
  </xsl:template>

  <!-- === Dynamische Inhalte ==================================================================== -->
  <xsl:template match="html:*">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- === Kopfzeilen ============================================================================ -->

  <xsl:template match="tei:title[ancestor::tei:titleStmt]" mode="header">
    <title><xsl:value-of select="normalize-space()"/></title>
    <meta name="DC.title" content="{normalize-space()}"/>
  </xsl:template>

  <xsl:template match="tei:principal[ancestor::tei:fileDesc]" mode="header">
    <meta name="DC.creator" content="{normalize-space()}"/>
    <link rel="DCTERMS.creator" href="{@ref}"/>
  </xsl:template>

  <xsl:template match="tei:respStmt[ancestor::tei:fileDesc]" mode="header">
    <meta name="DC.contributor" content="{normalize-space(tei:name)}"/>
    <xsl:if test="tei:name/@ref">
      <link rel="DCTERMS.contributor" href="{tei:name/@ref}"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:publisher[ancestor::tei:fileDesc]" mode="header">
    <meta name="DC.publisher" content="{normalize-space(tei:name)}"/>
    <link rel="DCTERMS.publisher" href="{tei:name/@ref}"/>
  </xsl:template>

  <xsl:template match="tei:license[ancestor::tei:fileDesc]" mode="header">
    <link rel="DCTERMS.license" href="{@target}"/>
  </xsl:template>

  <xsl:template match="text()" mode="header"/>

  <xsl:template name="datum">
    <xsl:param name="datum"/>
    <xsl:variable name="j" select="substring($datum, 1, 4)"/>
    <xsl:variable name="m" select="substring($datum, 6, 2)"/>
    <xsl:variable name="d" select="substring($datum, 9, 2)"/>

    <xsl:if test="string-length($datum) = 10">
      <xsl:value-of select="$d"/>
      <xsl:text>. </xsl:text>
    </xsl:if>
    <xsl:if test="string-length($datum) > 4">
      <xsl:value-of select="document('')//map:entry[@key = $m]/@value"/>
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:value-of select="$j"/>
  </xsl:template>

</xsl:transform>
