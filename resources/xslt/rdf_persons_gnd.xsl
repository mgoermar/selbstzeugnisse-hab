<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:ecrm="http://erlangen-crm.org/current/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:gndo="http://d-nb.info/standards/elementset/gnd#"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:schema="http://schema.org/"
    xmlns:wdt="http://www.wikidata.org/prop/direct/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="diaryData" select="collection('../daten/sz2/tagebuecher?select=cod_guelf*.xml;recurse=no')"/>
    
    <xsl:template match="/">
        <xsl:result-document href="sz2_rdf_persons.xml">
            <rdf:RDF xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:ecrm="http://erlangen-crm.org/current/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:gndo="http://d-nb.info/standards/elementset/gnd#"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
                xmlns:schema="http://schema.org/"
                xmlns:wdt="http://www.wikidata.org/prop/direct/">
                <rdf:Description rdf:about="christianii_rdf_persons.xml">
                    <dcterms:title>Daten zu Personen aus der Edition "Selbstzeugnisse der Frühen Neuzeit in der Herzog August Bibliothek II"</dcterms:title>
                    <schema:license>https://creativecommons.org/publicdomain/zero/1.0/</schema:license>
                    <dcterms:created><xsl:value-of select="substring(string(current-date()),1,4)"/></dcterms:created>
                    <dcterms:modified><xsl:value-of select="current-date()"/></dcterms:modified>
                    <dcterms:contributor>Maximilian Görmar, Herzog August Bibliothek Wolfenbüttel (goermar@hab.de)</dcterms:contributor>
                </rdf:Description>
                <xsl:for-each select="//tei:person[descendant::tei:persName/@ref]">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:person[descendant::tei:persName/@ref]">
        <xsl:variable name="person_id" select="@xml:id"/>
        <rdf:Description rdf:about="{tei:persName/@ref}">
            <!--<xsl:if test="document(concat(tei:persName/@ref[contains(.,'gnd')],'/about/lds.rdf'))//owl:sameAs[contains(@rdf:resource,'wikidata')]">
                <owl:sameAs rdf:resource="{document(concat(tei:persName/@ref,'/about/lds.rdf'))//owl:sameAs[contains(@rdf:resource,'wikidata')]/@rdf:resource}"/>
            </xsl:if>-->
            <xsl:if test="tei:listBibl">
                <xsl:for-each select="tei:listBibl">
                    <xsl:apply-templates/>                    
                </xsl:for-each>
            </xsl:if>            
            <rdf:type rdf:resource="http://erlangen-crm.org/current/E21_Person"/>
            <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Person"/>
            <rdf:type rdf:resource="http://schema.org/Person"/>
            <rdf:type rdf:resource="http://www.wikidata.org/entity/Q5"/>
            <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
            <schema:mainEntityOfPage>
                <xsl:text>http://selbstzeugnisse.hab.de/sz2/personen#</xsl:text>
                <xsl:value-of select="@xml:id"/>
            </schema:mainEntityOfPage>
            <rdfs:label>
                <xsl:value-of select="normalize-space(tei:persName[@type='display'])"/>
            </rdfs:label>
            <xsl:if test="tei:birth[.=number()]">
                <xsl:choose>
                    <xsl:when test="tei:birth &lt; 1000 and tei:birth &gt; 100">
                        <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                            <xsl:value-of select="concat('0',tei:birth)"/>
                        </gndo:dateOfBirth>
                    </xsl:when>
                    <xsl:when test="tei:birth &lt; 100 and tei:birth &gt; 10">
                        <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                            <xsl:value-of select="concat('00',tei:birth)"/>
                        </gndo:dateOfBirth>
                    </xsl:when>
                    <xsl:when test="tei:birth &lt; 10">
                        <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                            <xsl:value-of select="concat('000',tei:birth)"/>
                        </gndo:dateOfBirth>
                    </xsl:when>
                    <xsl:otherwise>                        
                        <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                            <xsl:value-of select="tei:birth"/>
                        </gndo:dateOfBirth>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="tei:birth[.!=number()]">
                <xsl:choose>
                    <xsl:when test="tei:birth[contains(.,'n. Chr.')]">
                        <xsl:choose>
                            <xsl:when test="matches(tei:birth/substring-before(.,' n. Chr.'),'^\d\d\d\d$')">
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="tei:birth/substring-before(.,' n. Chr.')"/>
                                </gndo:dateOfBirth>
                            </xsl:when>
                            <xsl:when test="matches(tei:birth/substring-before(.,' n. Chr.'),'^\d\d\d$')">
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('0',tei:birth/substring-before(.,' n. Chr.'))"/>
                                </gndo:dateOfBirth>
                            </xsl:when>
                            <xsl:when test="matches(tei:birth/substring-before(.,' n. Chr.'),'^\d\d$')">
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('00',tei:birth/substring-before(.,' n. Chr.'))"/>
                                </gndo:dateOfBirth>
                            </xsl:when>
                            <xsl:when test="matches(tei:birth/substring-before(.,' n. Chr.'),'^\d$')">
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('000',tei:birth/substring-before(.,' n. Chr.'))"/>
                                </gndo:dateOfBirth>
                            </xsl:when>
                            <xsl:otherwise>                                
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#string">
                                    <xsl:value-of select="tei:birth"/>
                                </gndo:dateOfBirth>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="tei:birth[contains(.,'v. Chr.')]">
                        <xsl:choose>
                            <xsl:when test="matches(tei:birth/substring-before(.,' v. Chr.'),'^\d\d\d\d$')">
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('-',tei:birth/number(substring-before(.,' v. Chr.'))-1)"/>
                                </gndo:dateOfBirth>
                            </xsl:when>
                            <xsl:when test="matches(tei:birth/substring-before(.,' v. Chr.'),'^\d\d\d$')">
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('-0',tei:birth/number(substring-before(.,' v. Chr.'))-1)"/>
                                </gndo:dateOfBirth>
                            </xsl:when>
                            <xsl:when test="matches(tei:birth/substring-before(.,' v. Chr.'),'^\d\d$')">
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('-00',tei:birth/number(substring-before(.,' v. Chr.'))-1)"/>
                                </gndo:dateOfBirth>
                            </xsl:when>
                            <xsl:when test="matches(tei:birth/substring-before(.,' v. Chr.'),'^\d$')">
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('-000',tei:birth/number(substring-before(.,' v. Chr.'))-1)"/>
                                </gndo:dateOfBirth>
                            </xsl:when>
                            <xsl:otherwise>                                
                                <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#string">
                                    <xsl:value-of select="tei:birth"/>
                                </gndo:dateOfBirth>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>                                
                        <gndo:dateOfBirth rdf:datatype="http://www.w3.org/2000/01/rdf-schema#string">
                            <xsl:value-of select="tei:birth"/>
                        </gndo:dateOfBirth>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="tei:death[.=number()]">                
                <xsl:choose>
                    <xsl:when test="tei:death &lt; 1000 and tei:death &gt; 100">
                        <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                            <xsl:value-of select="concat('0',tei:death)"/>
                        </gndo:dateOfDeath>
                    </xsl:when>
                    <xsl:when test="tei:death &lt; 100 and tei:death &gt; 10">
                        <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                            <xsl:value-of select="concat('00',tei:death)"/>
                        </gndo:dateOfDeath>
                    </xsl:when>
                    <xsl:when test="tei:death &lt; 10">
                        <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                            <xsl:value-of select="concat('000',tei:death)"/>
                        </gndo:dateOfDeath>
                    </xsl:when>
                    <xsl:otherwise>                        
                        <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                            <xsl:value-of select="tei:death"/>
                        </gndo:dateOfDeath>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="tei:death[.!=number()]">                
                <xsl:choose>
                    <xsl:when test="tei:death[contains(.,'n. Chr.')]">
                        <xsl:choose>
                            <xsl:when test="matches(tei:death/substring-before(.,' n. Chr.'),'^\d\d\d\d$')">
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="tei:death/substring-before(.,' n. Chr.')"/>
                                </gndo:dateOfDeath>
                            </xsl:when>
                            <xsl:when test="matches(tei:death/substring-before(.,' n. Chr.'),'^\d\d\d$')">
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('0',tei:death/substring-before(.,' n. Chr.'))"/>
                                </gndo:dateOfDeath>
                            </xsl:when>
                            <xsl:when test="matches(tei:death/substring-before(.,' n. Chr.'),'^\d\d$')">
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('00',tei:death/substring-before(.,' n. Chr.'))"/>
                                </gndo:dateOfDeath>
                            </xsl:when>
                            <xsl:when test="matches(tei:death/substring-before(.,' n. Chr.'),'^\d$')">
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('000',tei:death/substring-before(.,' n. Chr.'))"/>
                                </gndo:dateOfDeath>
                            </xsl:when>
                            <xsl:otherwise>                                
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#string">
                                    <xsl:value-of select="tei:death"/>
                                </gndo:dateOfDeath>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="tei:death[contains(.,'v. Chr.')]">
                        <xsl:choose>
                            <xsl:when test="matches(tei:death/substring-before(.,' v. Chr.'),'^\d\d\d\d$')">
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('-',tei:death/number(substring-before(.,' v. Chr.'))-1)"/>
                                </gndo:dateOfDeath>
                            </xsl:when>
                            <xsl:when test="matches(tei:death/substring-before(.,' v. Chr.'),'^\d\d\d$')">
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('-0',tei:death/number(substring-before(.,' v. Chr.'))-1)"/>
                                </gndo:dateOfDeath>
                            </xsl:when>
                            <xsl:when test="matches(tei:death/substring-before(.,' v. Chr.'),'^\d\d$')">
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('-00',tei:death/number(substring-before(.,' v. Chr.'))-1)"/>
                                </gndo:dateOfDeath>
                            </xsl:when>
                            <xsl:when test="matches(tei:death/substring-before(.,' v. Chr.'),'^\d$')">
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#gYear">
                                    <xsl:value-of select="concat('-000',tei:death/number(substring-before(.,' v. Chr.'))-1)"/>
                                </gndo:dateOfDeath>
                            </xsl:when>
                            <xsl:otherwise>                                
                                <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#string">
                                    <xsl:value-of select="tei:death"/>
                                </gndo:dateOfDeath>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>                                
                        <gndo:dateOfDeath rdf:datatype="http://www.w3.org/2000/01/rdf-schema#string">
                            <xsl:value-of select="tei:death"/>
                        </gndo:dateOfDeath>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <rdfs:comment xml:lang="de">
                <xsl:value-of select="normalize-space(tei:note)"/>
            </rdfs:comment>
            <xsl:for-each select="$diaryData//tei:div[@type='volume']/descendant::tei:rs[@type='person'][contains(@ref, concat('#',current()/@xml:id)) and not(contains(@ref, concat(current()/@xml:id,'_')))][not(contains(@ref, preceding::tei:rs[@type='person'][position()=1]/@ref))]">
                <ecrm:P67i_is_referred_to_by>
                    <xsl:attribute name="rdf:resource">                        
                        <xsl:text>http://selbstzeugnisse.hab.de/sz2/</xsl:text>
                        <xsl:value-of select="ancestor::tei:TEI/@xml:id/substring-after(.,'sz2.')"/>
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="$person_id"/>
                        <xsl:text>_</xsl:text>
                        <xsl:value-of select="preceding::tei:pb[1]/@n"/>
                    </xsl:attribute>                                          
                </ecrm:P67i_is_referred_to_by>
            </xsl:for-each>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
        <xsl:for-each select="tei:ptr">
            <foaf:page rdf:resource="{@target}"/>
        </xsl:for-each>        
    </xsl:template>
    
</xsl:stylesheet>