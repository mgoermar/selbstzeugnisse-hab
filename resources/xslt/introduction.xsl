<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:mets="http://www.loc.gov/METS/"
	xmlns:rdf="http://www.w3.org/TR/2004/REC-rdf-syntax-grammar-20040210/"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exist="http://exist.sourceforge.net/NS/exist" xmlns:mods="http://www.loc.gov/mods/v3"
	exclude-result-prefixes="tei mets xlink exist rdf" version="1.0">

	<!-- Einbindung der Standard-Templates und Variablen -->
	<xsl:import href="http://diglib.hab.de/rules/styles/param.xsl"/>
<!--	<xsl:import href="http://dev2.hab.de/edoc/param.xsl"/>-->
	<!--<xsl:import href="http://diglib.hab.de/rules/styles/tei-phraselevel.xsl"/>-->



	<xsl:output encoding="UTF-8" indent="yes" method="html" doctype-public="-//W3C//DTD HTML 4.01//EN"
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>

<!--	<xsl:param name="dir">edoc/ed000228</xsl:param>-->
	<xsl:param name="q"/>
	<xsl:param name="qtype"/>
	<xsl:param name="distype"/>
	<xsl:param name="pvID"/>
	<xsl:param name="footerXML"/>
	<xsl:param name="footerXSL"/>
	<xsl:param name="lokal"/>
	<xsl:param name="markup"/>
	<xsl:variable name="metsFile" select="document('../mets.xml')"/>
	<xsl:variable name="fileId"   select="/*/@xml:id"/>
	<xsl:variable name="metsId"   select="$metsFile//mets:div[mets:fptr[@FILEID = $fileId]]/@ID"/>

	<xsl:variable name="smallcase" select="'&#173;'"/>
	<xsl:variable name="uppercase" select="'-'"/>
	
	<xsl:key name="entity-ref" match="tei:rs[@ref][not(contains(@ref, ' '))]" use="substring(@ref,2)"/>
	<xsl:key name="term-ref" match="tei:term" use="substring(@ref, 2)"/>

	<xsl:template match="*" mode="toc">
		<xsl:apply-templates mode="toc"/>
	</xsl:template>

	<xsl:template match="tei:date/tei:note" mode="toc"/>

	<xsl:template match="/">
		
		
		
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title>Selbstzeugnisse der Frühen Neuzeit in der Herzog August Bibliothek</title>
				<!-- Assets -->
				<link rel="stylesheet" href="/assets/selbstzeugnisse/css/reset.css" media="screen"/>
				<link rel="stylesheet" href="/assets/font-awesome/css/font-awesome.min.css" media="screen"/>
				<link rel="stylesheet" href="/assets/selbstzeugnisse/css/selbstzeugnisse.css" media="screen"/>
				<link rel="stylesheet" href="/assets/selbstzeugnisse/css/print.css" media="print"/>
				<script type="text/javascript" src="/assets/jquery/jquery-3.4.1.min.js"></script>
				<script type="text/javascript" src="/assets/jquery-zoom/jquery.zoom.min.js"></script>
				<script type="text/javascript" src="/assets/selbstzeugnisse/js/selbstzeugnisse2.js"></script>
				<noscript>
					<style type="text/css">.js-toggle { display: inherit; }</style>
				</noscript>
			</head>

			<body>
				<div class="banner">
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
						<!--<h3>Digitale Edition des Diariums von Herzog August dem Jüngeren · Digitale Edition der Diarien Herzog Ludwig Rudolphs und Herzogin Christiane Luises von Braunschweig-Wolfenbüttel · Selbstzeugnis-Repertorium · Forschungsportal</h3>-->
					</div>
				</div>
								
				<div class="content">
					<div class="navigation">
						<xsl:call-template name="navigation"/>
					</div>
					<!-- Haupttext -->
					<div class="mainpage">
						<h1><xsl:value-of select="//tei:teiHeader//tei:title"/></h1>
						<xsl:apply-templates select="//tei:teiHeader//tei:respStmt"/>						
						<xsl:apply-templates select="tei:TEI/tei:text"/>					
					<!-- Kommentare  -->
					<xsl:if test="tei:TEI/tei:text/tei:body//tei:note[@type='footnote']">
						<hr/>
					</xsl:if>
					<div id="annotation">
						<xsl:if test="tei:TEI/tei:text/tei:body//tei:note[@type='footnote']">
							<div style="font-weight: bold;">Anmerkungen</div>
						</xsl:if>
						<div>							
							<xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note[@type='footnote']">
								<div style="padding-left: 1em; text-indent: -1em;">
									<a>
										<xsl:attribute name="name">
											<xsl:text>fn</xsl:text>
											<xsl:number level="any" count="tei:note[@type ='footnote']"/>
										</xsl:attribute>
										<xsl:attribute name="style">
											<xsl:text>color: blue; font-size: 0.7em; margin-right: 0.3em; vertical-align: super;</xsl:text>
										</xsl:attribute>
										<xsl:attribute name="href">
											<xsl:text>#fna</xsl:text>
											<xsl:number level="any" count="tei:note[@type ='footnote']"/>
										</xsl:attribute>											
										<span>
											<xsl:number level="any" count="tei:note[@type ='footnote']"/>
										</span>
									</a>
									<xsl:apply-templates/>										
								</div>
							</xsl:for-each>
						</div>
						</div>
					</div>
					<div class="infopanel facet">
						<!--<ul class="controls">
							<li>
								<a class="fa fa-print" href="javascript:print()"> Drucken</a>
							</li>
						</ul>-->
						<xsl:if test=".//tei:head">
							<h1>Schnellauswahl</h1>
							<ul>
								<xsl:for-each select=".//tei:head">
									<li>
										<a href="#{generate-id()}"><xsl:apply-templates/></a>
									</li>
								</xsl:for-each>
							</ul>
						</xsl:if>						
					</div>
				</div>									
			</body>
		</html>
	</xsl:template>

	<xsl:template match="tei:body | tei:front">
		<xsl:apply-templates/>
	</xsl:template>

	<!--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        ++++++++++++++++++++++++++++++++++++++++ editionsspezifische Anweisungen ++++++++++++++++++++++++++++++++++++++++++++
        +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->
	

	<!-- preserve-space schützt alle Whitespaces -->

	<xsl:preserve-space elements="*"/>
	
	<!--Navigation-->
	
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

	

	
	<!-- Haupttext -->

	<xsl:template match="tei:hi">
		<xsl:choose>
			<xsl:when test="@rend='bold'">
				<span style="font-weight:bold;">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test="@rend ='italics' or @rend ='italic'">
				<span style="font-style:italic;">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="tei:p">
		<p>
			<xsl:attribute name="style">
				<xsl:text>margin-top: 1em;</xsl:text>
			</xsl:attribute>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<xsl:template match="tei:head">
		<h2>
			<xsl:attribute name="id">
				<xsl:value-of select="generate-id(.)"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</h2>
	</xsl:template>
	
	<xsl:template match="tei:c[@rend='super']">
	<sup><xsl:apply-templates/></sup>
	</xsl:template>

	<!--    Links -->	
	
	<xsl:template match="tei:ref">
		<a target="_blank">
			<xsl:attribute name="href">
				<xsl:value-of select="@target"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</a>
	</xsl:template>

		<!-- Fußnoten -->
		
	<!--<xsl:template match="tei:note">
		<xsl:param name="caption"/>
		<!-\-  zwei Typen: entweder Fussnoten am Text- oder Seitenende in einem besonderen Abschnitt oder in den Text integriert -\->
		<xsl:choose>
			<xsl:when test="parent::tei:div[@type='footnote' ]">
				<!-\-   Fussnoten am Text- oder Seitenende -\->
				<div class="footnotes">
					<a>
						<xsl:attribute name="name">
							<xsl:text>fn</xsl:text>
							<xsl:value-of select="@n"/>
						</xsl:attribute>
						<a>
							<xsl:attribute name="href">
								<xsl:text>#fna</xsl:text>
								<xsl:value-of select="@n"/>
							</xsl:attribute>
							<span style="font-size:9pt;vertical-align:super;color:blue;margin-right:0.3em;">
								<xsl:value-of select="@n"/>
							</span>
						</a>
					</a>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			
			
			<xsl:when test="@type='footnote'">
				<!-\-  in Text integriert, nur Verweis , Fussnotenabschnitt mit foreach generiert -\->
				<a>
					<xsl:attribute name="name">
						<xsl:text>fna</xsl:text>
						<xsl:number level="any" count="tei:note[@type ='footnote']"/>
					</xsl:attribute>

					<a>
						<xsl:attribute name="href">
							<xsl:text>#fn</xsl:text>

							<xsl:number level="any" count="tei:note[@type ='footnote']"/>

						</xsl:attribute>
						<xsl:attribute name="title">
							<xsl:copy-of select="normalize-space(.)"/>
						</xsl:attribute>
						<span style="font-size:9pt;vertical-align:super;color:blue;">

							<xsl:value-of select="$caption"/>
							<xsl:number level="any" count="tei:note[@type ='footnote']"/>
						</span>

					</a>
				</a>
			</xsl:when>			
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>-->
	
	<xsl:template match="tei:note[@type='footnote']">
		<xsl:variable name="number">
			<xsl:value-of select="count(preceding::tei:note[@type ='footnote'])+1"/>
		</xsl:variable>
		<a href="#fn{$number}" name="fna{$number}" title="{normalize-space(.)}" class="annotation-reference"><xsl:value-of select="$number"/></a>
	</xsl:template>
	
	<xsl:template match="tei:lb">
		<br/>
	</xsl:template>
	
	<xsl:template match="tei:figure[not(@rend='iframe')]">
		<figure class="{@rend}">
			<xsl:apply-templates/>			
		</figure>
	</xsl:template>
	
	<xsl:template match="tei:figure[@rend='iframe']">
		<div id="iframe_container">
			<iframe src="{tei:graphic/@url}" height="1000" width="100%"></iframe>
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
	
	<xsl:template match="tei:respStmt"/>
	
	<!--<xsl:template match="tei:respStmt">
		<xsl:choose>
			<xsl:when test="tei:resp='Umsetzung der Digitalen Edition von'"/>	
			<xsl:otherwise>
				<div class="resp">
					<!-\-<xsl:value-of select="tei:resp"/>-\->
					<xsl:for-each select="tei:persName">
						<xsl:value-of select="substring(tei:forename,1,1)"/>
						<xsl:value-of select="substring(tei:surname,1,1)"/>
						<xsl:if test="position()!=last()">
							<xsl:text>/ </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</div>				
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>-->
	
</xsl:stylesheet>
