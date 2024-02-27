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
        <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
<!--        <xsl:apply-templates mode="header"/>-->
        <link rel="schema.DC" href="http://purl.org/dc/elements/1.1/"/>
        <link rel="schema.DCTERMS" href="http://purl.org/dc/terms/"/>
        <!-- Assets -->
        <link rel="shortcut icon" href="favicon_hdk.ico"/>         
        <link rel="preconnect" href="https://fonts.gstatic.com"/> 
          <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,300;0,400;0,700;1,300;1,400;1,700&amp;display=swap" rel="stylesheet"/>
            
        <link href="/assets/selbstzeugnisse/css/reset.css" type="text/css" rel="stylesheet"/>
            <link href="/assets/font-awesome/css/font-awesome.min.css" media="screen" rel="stylesheet"/>
              
        <link href="/assets/selbstzeugnisse/css/styles.css" type="text/css" rel="stylesheet"/>
        <link href="/assets/selbstzeugnisse/css/diarium.css" type="text/css" rel="stylesheet"/>
              
              <script type="text/javascript" src="/assets/jquery/jquery.min.js"></script>
              <script type="text/javascript" src="/assets/jquery-zoom/jquery.zoom.min.js"></script>
              <script type="text/javascript" src="/assets/js/selbstzeugnisse2.js"></script>
              <noscript><style type="text/css">.js-toggle { display: inherit; }</style></noscript><!--
        <link rel="stylesheet" href="/assets/selbstzeugnisse/css/reset.css" media="screen"/>
        <link rel="stylesheet" href="/assets/font-awesome/css/font-awesome.min.css" media="screen"/>
        <link rel="stylesheet" href="/assets/selbstzeugnisse/css/selbstzeugnisse.css" media="screen"/>
        <link rel="stylesheet" href="/assets/selbstzeugnisse/css/print.css" media="print"/>
        <script type="text/javascript" src="/assets/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="/assets/jquery-zoom/jquery.zoom.min.js"></script>
        <script type="text/javascript" src="/assets/selbstzeugnisse/js/selbstzeugnisse.js"></script>-->
        <!--<noscript>
          <style type="text/css">.js-toggle { display: inherit; }</style>
        </noscript>-->
      </head>
      <body>
        <div id="mainConti">
          <header>
            
            <div id="bgTop"></div>
            <a href="http://selbstzeugnisse.hab.de" id="logo"></a>
            
            <div id="m_titleConti">
              <span id="m_title1">Selbstzeugnisse&#160;</span><span id="m_title2">der frühen Neuzeit</span><br/>
              <span id="m_subTitle">in der Herzog August Bibliothek</span>
            </div>            
            <a href="http://www.hab.de" target="_blank" id="habLogo"></a>            
          </header>
        <!--<div class="banner">
          <img src="/assets/selbstzeugnisse/images/banner_logo.png" class="brand"/>
          <div class="banner-logo">
            <img src="/assets/selbstzeugnisse/images/banner_logo_hab.png"/>
            <form method="GET" action="/suche">
              <input type="text" name="query" placeholder="&#x1F50E;"/>
            </form>
          </div>
          <div class="banner-slogan">
            <h1>Selbstzeugnisse <small>der Frühen Neuzeit</small></h1>
            <h2>in der Herzog August Bibliothek</h2>
          </div>
        </div>-->
        
          <xsl:apply-templates/>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template name="annumber">
<!--    <xsl:number level="any" format="a" count="//tei:note[@type='annotation'] | //tei:handShift | //tei:choice | //tei:restore | //tei:surplus"/>-->
    <xsl:number level="any" format="a" count="//tei:note[@type='annotation']"/>
  </xsl:template>

  <xsl:template match="tei:text/tei:body">
    <nav role="navigation">
      <xsl:call-template name="navigation"/>
    </nav>
    <a class="printer" href="javascript:print()"></a>
    <div class="content">
      <div class="contentWrap">
        <xsl:apply-templates/>
        <div id="annotation">
          
          <xsl:if test="//tei:note[@type='footnote']">
            <hr/>
            <b>Anmerkungen</b>
          </xsl:if>
          <div>							
            <xsl:for-each select="//tei:note[@type='footnote']">
              <xsl:variable name="footnotenumber">
                <xsl:number level="any" count="tei:note[@type ='footnote']"/>
              </xsl:variable>
              <div style="padding-left: 1em; text-indent: -1em;">
                <a name="fn{$footnotenumber}" href="#fna{$footnotenumber}">
                  <!--<xsl:attribute name="style">
                    <xsl:text>color: blue; font-size: 0.7em; margin-right: 0.3em; vertical-align: super;</xsl:text>
                  </xsl:attribute>-->
                  <span class="note"><xsl:value-of select="$footnotenumber"/><xsl:text> </xsl:text></span>                  
                </a>
                <xsl:apply-templates/>										
              </div>
            </xsl:for-each>
          </div>
          </div>
      </div>
      
      
    </div>
    <!--<div class="infopanel facet">
      <ul class="controls">
        <li>
          <a class="fa fa-print" href="javascript:print()"> Drucken</a>
        </li>
      </ul>
    </div>-->
    <footer>
      
    </footer>
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
  
  <xsl:template match="tei:hi[@rend='bold']">
    <b><xsl:apply-templates/></b>
  </xsl:template>
  
  <xsl:template match="tei:hi[@rend='italic']">
    <i><xsl:apply-templates/></i>
  </xsl:template>
  
  <xsl:template match="tei:hi[@rend='smaller']">
    <span style="font-size:80%; line-height:1.5em"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:label[parent::tei:div]">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>
  
  <xsl:template match="tei:lb[preceding-sibling::tei:lb]">
    <br/>
  </xsl:template>
  
  <xsl:template match="tei:note[@type='footnote']">
    <xsl:variable name="footnotenumber">
      <xsl:number level="any" count="tei:note[@type ='footnote']"/>
    </xsl:variable>
    <a class="note" id="fna{$footnotenumber}" href="#fn{$footnotenumber}" title="{.}">
      <xsl:value-of select="$footnotenumber"/>
    </a>
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
      <p>
        <xsl:for-each select="tei:desc">
          <xsl:apply-templates/>
        </xsl:for-each>
      </p>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tei:list[tei:item/tei:ref]">
    <xsl:apply-templates select="tei:head"/>
    <xsl:for-each select="tei:item">
      <h3><xsl:apply-templates select="tei:ref"/></h3>
      <xsl:for-each select="tei:desc">
        <p>
          <xsl:apply-templates/>
        </p>
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
  
  <xsl:template match="tei:figure[not(@rend='iframe')]">
    <figure class="{@rend}">
      <xsl:apply-templates/>			
    </figure>
  </xsl:template>
  
  <xsl:template match="tei:figure[@rend='iframe']">
    <div id="iframe_container">
      <iframe src="{tei:graphic/@url}" height="1000" width="150%"></iframe>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:graphic">
    <img src="{@url}"/>
  </xsl:template>
  
  <xsl:template match="tei:figDesc">
    <figcaption>
      <xsl:apply-templates/>
    </figcaption>
  </xsl:template>

  <xsl:template match="mets:div[not(@TYPE)][@LABEL]">    
        <li>
          <xsl:choose>
            <xsl:when test="@ID='edition'">
              <a href="/{translate(@ID, '.', '/')}_august">
                <xsl:if test="mets:fptr/@FILEID = $fileId"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
                <xsl:value-of select="@LABEL"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a href="/{translate(@ID, '.', '/')}">
                <xsl:if test="mets:fptr/@FILEID = $fileId"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
                <xsl:value-of select="@LABEL"/>
              </a>
            </xsl:otherwise>
          </xsl:choose>          
          <xsl:if test="mets:div[@LABEL]">
        <ul id="subMen">
          <div style="padding-top:10px;">
            <xsl:apply-templates select="mets:div"/>
          </div>          
        </ul>
      </xsl:if>
        </li>
  </xsl:template>

  <xsl:template name="navigation">
    <div id="menuToggle">    
      
      <input type="checkbox"/>   
      
      <span></span>
      <span></span>
      <span></span>
      
      <ul id="menu">
        <li>
          <a href="/">
            <xsl:if test="$fileId = 'index.xml'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
            Startseite
          </a>
        </li>
        <xsl:apply-templates select="$metsFile/mets:mets/mets:structMap/mets:div/*"/>
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="tei:address">
    <p>
      <ul>
        <xsl:for-each select="*">
          <li>
            <xsl:apply-templates/>
          </li>
        </xsl:for-each>
      </ul>
    </p>
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
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:if test="string-length($datum) > 4">
      <!--<xsl:value-of select="document('')//map:entry[@key = $m]/@value"/>-->
      <xsl:value-of select="$m"/>
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:value-of select="$j"/>
  </xsl:template>

</xsl:transform>
