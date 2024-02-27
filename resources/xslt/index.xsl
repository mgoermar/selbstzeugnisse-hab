<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.0"
               exclude-result-prefixes="tei"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:tei="http://www.tei-c.org/ns/1.0">

  <xsl:import href="default.xsl"/>

  <xsl:template match="tei:text/tei:body">
    <nav role="navigation">
      <xsl:call-template name="navigation"/>
    </nav>
    <a class="printer" href="#"></a>
    <div class="content">
      <div style="clear:both"></div>
      
      <div class="startboxes"><ul>
        
        <li>
          <a href="http://selbstzeugnisse.hab.de/repertorium"><img src="assets/imgs/img002.jpg" alt=""/>
          <div class="sWrap">Selbstzeugnis-Repertorium</div></a>
        </li>
        
        <li><a href="http://selbstzeugnisse.hab.de/edition_august">
          <img src="assets/imgs/img001.jpg" alt=""/>
          <div class="sWrap">Reisetagebuch <br/>August II.</div></a>
        </li>
        
        <li><a href="http://selbstzeugnisse.hab.de/edition_sz2">
          <img src="assets/imgs/img004.jpg" alt=""/>
          <div class="sWrap">Tagebücher <br/>Ludwig Rudolph <br/>Christine Luise</div></a>
        </li>
        
        <li><a href="http://selbstzeugnisse.hab.de/edition_grand_tour">
          <img src="assets/imgs/img_gtd_klein.jpg" alt=""/>
          <div class="sWrap">Grand Tour <br/>digital</div></a>
        </li>
        
      </ul>
      </div>
    
    
    <div class="contentWrap">
      <xsl:apply-templates/>
    </div>
    </div>
    <!--<div class="mainpage">
      <xsl:apply-templates/>
    </div>

      <div class="teaser">
        <ul>
          <li class="bg-lgrey">
            <img src="/assets/selbstzeugnisse/images/teaser/img002_klein.jpg"/>
            <a href="http://selbstzeugnisse.hab.de/repertorium">Selbstzeugnis-
            repertorium</a>
          </li>
          <li class="bg-lgrey">
            <img src="/assets/selbstzeugnisse/images/teaser/img001_klein.jpg"/>
            <a href="http://selbstzeugnisse.hab.de/edition/diarium">Diarium August II.</a>            
          </li>
          <!-\- <li class="bg-mgrey"> -\->
          <!-\-   <img src="/assets/selbstzeugnisse/images/teaser/img003.jpg"/> -\->
          <!-\- </li> -\->
          <li class="bg-lgrey">
            <img src="/assets/selbstzeugnisse/images/teaser/img004.jpg"/>
            <a href="http://selbstzeugnisse.hab.de/sz2/cod_guelf_28_blank">Tagebuch Ludwig Rudolph</a>            
          </li>
          <li class="bg-lgrey">
            <img src="/assets/selbstzeugnisse/images/teaser/img005.jpg"/>
            <a href="http://selbstzeugnisse.hab.de/sz2/cod_guelf_211_1_extrav">Tagebuch Christine Luise</a>           
          </li>
        </ul>
        <img src="/assets/selbstzeugnisse/images/banner_logo_nwk.png" />
      </div>
-->
  </xsl:template>

</xsl:transform>
