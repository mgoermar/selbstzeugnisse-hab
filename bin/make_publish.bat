calabash.cmd -o result=resources/daten/repertorium/mets.xml resources/xproc/repertorium/mets.xpl
calabash.cmd -i resources/daten/edition/diarium/diarium.xml -o resources/daten/edition/diarium/linkmap.xml resources/xproc/edition/linkmap.xpl
calabash.cmd -i resources/mets.xml -o public/sitemap.xml resources/xproc/sitemap.xpl
calabash.cmd -o public/repertorium/repository.xml resources/xproc/repertorium/oais.xpl
transform.cmd -o:public/beacon.txt -xsl:resources/xproc/edition/beacon.xsl resources/daten/edition/diarium/linkmap.xml
calabash.cmd resources/xproc/repertorium/solr.xpl
calabash.cmd -i resources/mets.xml resources/xproc/fulltext/fulltext.xpl
robocopy .\\ \\\\devserver\hosting\development\2015\selbstzeugnisse.hab.de /MIR /XD .git /XD tmp