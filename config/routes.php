<?php

$app->get('/', 'controller.staticpage:handle')
    ->bind('home');

$app->get('/edition_august', 'controller.staticpage:handle')
    ->bind('edition');
    
$app->get('/edition/einleitung',  'controller.staticpage:handle')
    ->bind('edition.einleitung');

$app->get('/edition/beschreibung',  'controller.staticpage:handle')
    ->bind('edition.beschreibung');

$app->get('/edition/richtlinien',  'controller.staticpage:handle')
    ->bind('edition.richtlinien');

$app->get('/edition/diarium/register.xml', 'controller.staticpage:handle')
    ->bind('edition.diarium.register');

$app->get('/edition/diarium/download', 'controller.staticpage:handle')
    ->bind('edition.diarium.download');

$app->get('/edition/diarium/{metsId}', 'controller.dynamicpage:handle')
    ->bind('edition.diarium.jahr')
    ->convert('metsId', function ($metsId) { return "edition.diarium.{$metsId}"; });

$app->get('/edition/diarium/', 'controller.staticpage:handle')
    ->bind('edition.diarium');

$app->get('/edition/personen', 'controller.staticpage:handle')
    ->bind('edition.personen');

$app->get('/edition/orte', 'controller.staticpage:handle')
    ->bind('edition.orte');

$app->get('/repertorium/', 'controller.staticpage:handle')
    ->bind('repertorium');

$app->get('/repertorium/suche/', 'controller.repertorium.results:handle')
    ->bind('repertorium.suche');

$app->get('/repertorium/eintrag/{metsId}', 'controller.dynamicpage:handle')
    ->bind('repertorium.eintrag')
    ->convert('metsId', function ($metsId) { return "repertorium.eintrag.{$metsId}"; });

$app->get('/repertorium/liste', 'controller.repertorium.list:handle')
    ->bind('repertorium.liste');


$app->get('/repertorium/vokabular', 'controller.staticpage:handle')
    ->bind('repertorium.vokabular');

$app->get('/bibliographie', 'controller.staticpage:handle')
    ->bind('bibliographie');

$app->get('/projekt', 'controller.staticpage:handle')
    ->bind('projekt');

$app->get('/extern', 'controller.staticpage:handle')
    ->bind('extern');

$app->get('/impressum', 'controller.staticpage:handle')
    ->bind('impressum');

$app->get('/dienste', 'controller.staticpage:handle')
    ->bind('dienste');

$app->get('/suche', 'controller.search:handle')
    ->bind('suche');
    
$app->get('/edition_sz2', 'controller.staticpage:handle')
    ->bind('edition_sz2');

$app->get('/sz2/projektbeschreibung', 'controller.staticpage:handle')
    ->bind('sz2.projektbeschreibung');

$app->get('/sz2/kurzbiographien', 'controller.staticpage:handle')
    ->bind('sz2.kurzbiographien');

$app->get('/sz2/editionsrichtlinien', 'controller.staticpage:handle')
    ->bind('sz2.editionsrichtlinien');

$app->get('/sz2/bibliographie', 'controller.staticpage:handle')
    ->bind('sz2.bibliographie');
    
$app->get('/sz2/introduction_cod_guelf_28_blank', 'controller.staticpage:handle')
    ->bind('sz2.introduction_cod_guelf_28_blank');
    
$app->get('/sz2/introduction_cod_guelf_286_blank', 'controller.staticpage:handle')
    ->bind('sz2.introduction_cod_guelf_286_blank');

$app->get('/sz2/introduction_cod_guelf_286a_blank', 'controller.staticpage:handle')
    ->bind('sz2.introduction_cod_guelf_286a_blank');

$app->get('/sz2/introduction_cod_guelf_211_1_extrav', 'controller.staticpage:handle')
    ->bind('sz2.introduction_cod_guelf_211_1_extrav');

$app->get('/sz2/cod_guelf_28_blank', 'controller.staticpage:handle')
    ->bind('sz2.cod_guelf_28_blank');
    
$app->get('/sz2/cod_guelf_28_blank_teil2', 'controller.staticpage:handle')
    ->bind('sz2.cod_guelf_28_blank_teil2');
    
$app->get('/sz2/cod_guelf_28_blank_teil3', 'controller.staticpage:handle')
    ->bind('sz2.cod_guelf_28_blank_teil3');
    
$app->get('/sz2/cod_guelf_28_blank_teil4', 'controller.staticpage:handle')
    ->bind('sz2.cod_guelf_28_blank_teil4');
    
$app->get('/sz2/cod_guelf_211_1_extrav', 'controller.staticpage:handle')
    ->bind('sz2.cod_guelf_211_1_extrav');
    
$app->get('/sz2/cod_guelf_286a_blank', 'controller.staticpage:handle')
    ->bind('sz2.cod_guelf_286a_blank');
    
$app->get('/sz2/cod_guelf_286_blank', 'controller.staticpage:handle')
    ->bind('sz2.cod_guelf_286_blank');

$app->get('/sz2/personen', 'controller.staticpage:handle')
    ->bind('sz2.personen');
    
$app->get('/sz2/personen.html', 'controller.staticpage:handle')
    ->bind('sz2.personen.html');

$app->get('/sz2/orte', 'controller.staticpage:handle')
    ->bind('sz2.orte');

$app->get('/sz2/literatur', 'controller.staticpage:handle')
    ->bind('sz2.literatur');
    
$app->get('/sz2/geobrowser', 'controller.staticpage:handle')
    ->bind('sz2.geobrowser');
    
$app->get('/sz2/itinerar_geobrowser', 'controller.staticpage:handle')
    ->bind('sz2.itinerar_geobrowser');
    
$app->get('/sz2/itinerar', 'controller.staticpage:handle')
    ->bind('sz2.itinerar');

$app->get('/edition_grand_tour', 'controller.staticpage:handle')
    ->bind('edition_grand_tour');

$app->get('/grand_tour/projektbeschreibung', 'controller.staticpage:handle')
    ->bind('grand_tour.projektbeschreibung');

$app->get('/grand_tour/introduction_cod_guelf_267_1_extrav', 'controller.staticpage:handle')
    ->bind('grand_tour.introduction_cod_guelf_267_1_extrav');
	
$app->get('/grand_tour/cod_guelf_267_1_extrav', 'controller.staticpage:handle')
    ->bind('grand_tour.cod_guelf_267_1_extrav');
    
$app->get('/grand_tour/introduction_cod_guelf_89_blank', 'controller.staticpage:handle')
    ->bind('grand_tour.introduction_cod_guelf_89_blank');
	
$app->get('/grand_tour/cod_guelf_89_blank', 'controller.staticpage:handle')
    ->bind('grand_tour.cod_guelf_89_blank');
	
$app->get('/grand_tour/personen', 'controller.staticpage:handle')
    ->bind('grand_tour.personen');
	
$app->get('/grand_tour/orte', 'controller.staticpage:handle')
    ->bind('grand_tour.orte');
	
$app->get('/grand_tour/koerperschaften', 'controller.staticpage:handle')
    ->bind('grand_tour.koerperschaften');
    
$app->get('/editionen', 'controller.staticpage:handle')
    ->bind('editionen');
