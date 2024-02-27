<xsl:transform version="1.0"
               exclude-result-prefixes="tei"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../default.xsl"/>

  <xsl:variable name="opacUrl">https://opac.lbs-braunschweig.gbv.de/DB=2/CMD?ACT=SRCHA&amp;IKT=1016&amp;SRT=YOP&amp;TRM=</xsl:variable>
  <xsl:variable name="mssUrl">http://diglib.hab.de?db=mss&amp;list=ms&amp;id=</xsl:variable>
  <xsl:variable name="author" select="//tei:author"/>
  <xsl:variable name="authorUri">
    <xsl:if test="//tei:author/@ref">
      <xsl:value-of select="document(//tei:author/@ref)/tei:idno[@type = 'URI']"/>
    </xsl:if>
  </xsl:variable>
  <xsl:variable name="authorGnd">
    <xsl:if test="starts-with($authorUri, 'http://d-nb.info/gnd/')">
      <xsl:value-of select="substring-after($authorUri, 'http://d-nb.info/gnd/')"/>
    </xsl:if>
  </xsl:variable>

  <xsl:template match="tei:teiHeader">
    <nav role="navigation">
      <xsl:call-template name="navigation"/>
    </nav>
    <a class="printer" href="javascript:print()"></a>
    <div class="content">
      <div class="pageWrap">
        <div class="repertorium">
          <div class="rep_list">

          <dl>
            <dt>Verfasser</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:author[normalize-space()]">
                  <xsl:for-each select="//tei:author[normalize-space()]">
                    <xsl:value-of select="."/>
                    <xsl:if test="@cert">
                      <xsl:text> (?)</xsl:text>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>

          <dl>
            <dt>Schreiber/Redaktor</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:respStmt[ancestor::sourceDesc]">
                  <xsl:value-of select="//tei:respStmt[ancestor::sourceDesc]"/>
                </xsl:when>

                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>

          <dl>
            <dt>Sachtitel</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:title[@type = 'uniform']">
                  <xsl:value-of select="//tei:title[@type = 'uniform']"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>

          <dl>
            <dt>Titel in Vorlageform</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:rubric">
                  <xsl:value-of select="//tei:rubric"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>

        </div>
      
        <div class="rep_list">
          <dl>
            <dt>Berichtszeitraum</dt>
            <dd>
              <xsl:variable name="zeitraum">
                <xsl:call-template name="zeitraum">
                  <xsl:with-param name="element" select="//tei:date[@type = 'coverage']"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:choose>
                <xsl:when test="$zeitraum != ''">
                  <xsl:value-of select="$zeitraum"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>

            <dl>
              <dt>Entstehungszeit</dt>
              <dd>
                <xsl:variable name="zeitraum">
                  <xsl:call-template name="zeitraum">
                    <xsl:with-param name="element" select="//tei:origDate"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="$zeitraum != ''">
                    <xsl:value-of select="$zeitraum"/>
                  </xsl:when>
                  <xsl:otherwise>-</xsl:otherwise>
                </xsl:choose>
              </dd>
            </dl>
          

          <dl>
            <dt>Entstehungsort</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:origPlace">
                  <xsl:value-of select="//tei:origPlace"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>

        </div>
      
        <div class="rep_list">
          <dl>
            <dt>Aufbewahrungsort</dt>
            <dd>
              Herzog August Bibliothek Wolfenbüttel,
              <xsl:value-of select="//tei:collection"/>
            </dd>
          </dl>
          <dl>
            <dt>Signatur</dt>
            <dd>
              <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:idno"/>
              <xsl:if test="//tei:msItem/tei:locus/@from">
                <xsl:text>, beginnt auf </xsl:text>
                <xsl:value-of select="//tei:msItem/tei:locus/@from"/>
              </xsl:if>
            </dd>
          </dl>
        </div>
      
        <div class="rep_list">
          <dl>
            <dt>Zusammenfassung</dt>
            <dd>
              <xsl:apply-templates select="//tei:summary/node()"/>
            </dd>
          </dl>
        </div>
      
        <div class="rep_list">
          <dl>
            <dt>Sprache</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:textLang">
                  <xsl:call-template name="label-sprache">
                    <xsl:with-param name="lang" select="//tei:textLang/@mainLang"/>
                  </xsl:call-template>
                  <xsl:if test="//tei:textLang/@otherLangs">
                    <xsl:text>, </xsl:text>
                    <xsl:call-template name="label-sprache">
                      <xsl:with-param name="lang" select="//tei:textLang/@otherLangs"/>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
          <dl>
            <dt>Beschreibstoff</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:material">
                  <xsl:value-of select="//tei:material"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
          <dl>
            <dt>Umfang</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:measure">
                  <xsl:value-of select="//tei:measure"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
          <dl>
            <dt>Maße des Buchblocks</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:dimensions">
                          <xsl:value-of select="translate(//tei:dimensions/tei:width/@quantity, '.', ',')"/>
                          <xsl:text> × </xsl:text>
                          <xsl:value-of select="translate(//tei:dimensions/tei:height/@quantity, '.', ',')"/>
                          <xsl:text> cm</xsl:text>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
          <dl>
            <dt>Seitenzählung</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:foliation">
                  <xsl:apply-templates select="//tei:foliation/tei:p"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
          <dl>
            <dt>Seitenaufbau</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:layout">
                  <xsl:apply-templates select="//tei:layout/tei:p"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
          <dl>
            <dt>Einband</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:bindingDesc">
                  <xsl:apply-templates select="//tei:bindingDesc/node()"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
          <dl>
            <dt>Illustrationen</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:decoNote">
                  <xsl:apply-templates select="//tei:decoNote/node()"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
          <dl>
            <dt>Beigaben</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:accMat">
                  <xsl:apply-templates select="//tei:accMat/*"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
        </div>
      
        <div class="rep_list">
          <dl>
            <dt>Besitzgeschichte</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:provenance or //tei:acquisition">
                  <xsl:apply-templates select="//tei:p[parent::tei:provenance or parent::tei:acquisition]/.."/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
        </div>
      

        <div class="rep_list">
          <dl>
            <dt>Bibliographische Verweise</dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//tei:additional[tei:listBibl]">
                  <ul>
                    <xsl:for-each select="//tei:additional/tei:listBibl/tei:bibl">
                      <li>
                        <xsl:choose>
                          <xsl:when test="tei:ref[@type = 'opac']">
                            <a href="http://opac.lbs-braunschweig.gbv.de/DB=2/PPN?PPN={tei:ref[@type = 'opac']/@cRef}" target="_blank">
                              <xsl:apply-templates/>
                            </a>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:apply-templates/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </li>
                    </xsl:for-each>
                  </ul>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </dd>
          </dl>
        </div>
      

      <xsl:variable name="shelfmark" select="substring-after(.//tei:msDesc/tei:msIdentifier/tei:idno, 'Cod. Guelf. ')"/>
      <xsl:variable name="ident">
        <xsl:call-template name="normalize-shelfmark">
          <xsl:with-param name="shelfmark" select="$shelfmark"/>
        </xsl:call-template>
      </xsl:variable>
        <div class="rep_list">
          <dl>
            <dt>Weitere Informationen</dt>
            <dd>
              <ul>
                <li>
                  Suche nach Literatur im <a href="{concat($opacUrl, 'lde %22cod. guelf. ', $shelfmark, '%22')}" target="_blank">OPAC</a>
                </li>
                <li>
                  Suche nach Informationen in der <a href="{concat($mssUrl, $ident)}" target="_blank">Handschriftendatenbank</a>
                </li>
              </ul>
            </dd>
          </dl>
        </div>
      
    </div>
      </div>
    </div>
    
    <!--<div class="infopanel">
      <ul class="controls">
        <li>
          <a class="fa fa-print" href="javascript:print()"> Drucken</a>
        </li>
      </ul>
    </div>-->
  </xsl:template>

  <xsl:template match="tei:p[normalize-space()]">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="tei:ref[not(starts-with(@target, 'http'))]">
    <xsl:apply-templates/>
    <!-- <a href="{substring-before(@target, '.xml')}"> -->
    <!--   <xsl:apply-templates/> -->
    <!-- </a> -->
  </xsl:template>

  <xsl:template match="tei:ref[@type = 'gbv'][@cRef]">
    <a href="https://gso.gbv.de/DB=2.1/PPNSET?PPN={@cRef}" target="_blank">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template name="label-sprache">
    <xsl:param name="lang"/>
    <xsl:choose>
      <xsl:when test="$lang = 'deu' or $lang = 'de'">Deutsch</xsl:when>
      <xsl:when test="$lang = 'lat' or $lang = 'la'">Latein</xsl:when>
      <xsl:when test="$lang = 'ces' or $lang = 'cs'">Tschechisch</xsl:when>
      <xsl:when test="$lang = 'nld' or $lang = 'nl'">Niederländisch</xsl:when>
      <xsl:when test="$lang = 'fra' or $lang = 'fr'">Französisch</xsl:when>
      <xsl:when test="$lang = 'eng' or $lang = 'en'">Englisch</xsl:when>
      <xsl:otherwise>Unbekannt/Keine Angabe</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="zeitraum">
    <xsl:param name="element"/>
    <xsl:choose>
      <xsl:when test="normalize-space($element) != ''">
        <xsl:value-of select="$element"/>
      </xsl:when>
      <xsl:when test="$element/@from != '' or $element/@to != ''">
        <xsl:if test="$element/@from != ''">
          <xsl:call-template name="datum">
            <xsl:with-param name="datum" select="$element/@from"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:text>–</xsl:text>
        <xsl:if test="$element/@to != ''">
          <xsl:call-template name="datum">
            <xsl:with-param name="datum" select="$element/@to"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:when test="$element/@when != ''">
        <xsl:call-template name="datum">
          <xsl:with-param name="datum" select="$element/@when"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$element/@after">
        <xsl:text>nach </xsl:text>
        <xsl:call-template name="datum">
          <xsl:with-param name="datum" select="$element/@after"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$element/@notBefore">
        <xsl:text>nach </xsl:text>
        <xsl:call-template name="datum">
          <xsl:with-param name="datum" select="$element/@notBefore"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$element/@before">
        <xsl:text>vor </xsl:text>
        <xsl:call-template name="datum">
          <xsl:with-param name="datum" select="$element/@before"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$element/@notAfter">
        <xsl:text>vor </xsl:text>
        <xsl:call-template name="datum">
          <xsl:with-param name="datum" select="$element/@notAfter"/>
        </xsl:call-template>
      </xsl:when>

    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:listBibl"/>

  <xsl:template name="normalize-shelfmark">
    <xsl:param name="shelfmark"/>
    <xsl:variable name="ident" select="translate(normalize-space(translate($shelfmark, '.°', ' f')), ' ', '-')"/>
    <xsl:value-of select="translate($ident, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
  </xsl:template>

</xsl:transform>
