<xsl:transform version="2.0"
               xmlns="http://www.loc.gov/METS/"
               xmlns:c="http://www.w3.org/ns/xproc-step"
               xmlns:xlink="http://www.w3.org/1999/xlink"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/c:directory">
    <mets>
      <fileSec>
        <fileGrp xml:id="files">
          <xsl:apply-templates mode="fileSec"/>
        </fileGrp>
      </fileSec>
      <structMap>
        <div ID="repertorium.eintrag" xml:id="divs">
          <xsl:apply-templates mode="structMap"/>
        </div>
      </structMap>
    </mets>
  </xsl:template>

  <xsl:template match="c:file" mode="fileSec">
    <file ID="repertorium.eintrag.{@name}" MIMETYPE="application/tei+xml">
      <FLocat xlink:href="daten/repertorium/mss/{../@name}/{@name}" LOCTYPE="URL"/>
    </file>
  </xsl:template>

  <xsl:template match="c:file" mode="structMap">
    <div ID="repertorium.eintrag.{substring-before(@name, '.xml')}">
      <fptr FILEID="repertorium.eintrag.{@name}"/>
    </div>
  </xsl:template>

</xsl:transform>
