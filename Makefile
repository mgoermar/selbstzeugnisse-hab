.PHONY: server
server:
	php -S 127.0.0.1:9999 -t public public/index.php

.PHONY: mets
mets:
	calabash -o result=resources/daten/repertorium/mets.xml resources/xproc/repertorium/mets.xpl

.PHONY: solr
solr:
	calabash resources/xproc/repertorium/solr.xpl
	calabash -i resources/mets.xml resources/xproc/fulltext/fulltext.xpl

.PHONY: normdaten
normdaten:
	calabash -i resources/daten/edition/register/orte.xml resources/xproc/normdaten.xpl
	calabash -i resources/daten/edition/register/personen.xml resources/xproc/normdaten.xpl
	calabash -i resources/daten/repertorium/register/orte.xml resources/xproc/normdaten.xpl
	calabash -i resources/daten/repertorium/register/personen.xml resources/xproc/normdaten.xpl

.PHONY: linkmap
linkmap:
	calabash -i resources/daten/edition/diarium/diarium.xml -o resources/daten/edition/diarium/linkmap.xml resources/xproc/edition/linkmap.xpl

.PHONY: deploy
deploy:
	robocopy .\\ \\\\devserver\hosting\development\2015\selbstzeugnisse.hab.de /MIR /XD .git /XD tmp

.PHONY: sitemap
sitemap:
	calabash -i resources/mets.xml -o public/sitemap.xml resources/xproc/sitemap.xpl

.PHONY: repository
repository:
	calabash -o public/repertorium/repository.xml resources/xproc/repertorium/oais.xpl

.PHONY: beacon
beacon: linkmap
	transform -o:public/beacon.txt -xsl:resources/xproc/edition/beacon.xsl resources/daten/edition/diarium/linkmap.xml

.PHONY: publish
publish: mets linkmap sitemap repository beacon solr deploy
