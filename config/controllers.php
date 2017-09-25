<?php

$app['controller.staticpage'] = $app->factory(
    function () use ($app) {
        $configuration = $app['mets'];
        return new HAB\Selbstzeugnisse\StaticPageController($configuration);
    }
);

$app['controller.dynamicpage'] = $app->factory(
    function () use ($app) {
        $configuration = $app['mets'];
        return new HAB\Selbstzeugnisse\DynamicPageController($configuration);
    }
);

$app['controller.search'] = $app->factory(
    function () use ($app) {
        $twig    = $app['twig'];
        $config  = $app['mets'];
        $invoker = $app['solr.ft.invoker'];
        $controller = new HAB\Selbstzeugnisse\FulltextSearchController($config, $invoker, $twig);
        return $controller;
    }
);

$app['controller.repertorium.results'] = $app->factory(
    function () use ($app) {
        $twig    = $app['twig'];
        $config  = $app['mets'];
        $invoker = $app['solr.invoker'];

        $controller = new HAB\Selbstzeugnisse\SolrResultsController($config, $invoker, $twig);

        $facet = new HAB\Solr\Facet\DefaultFacetAdapter(new HAB\Solr\Facet\Impl\FieldFacet('genre', array('facet.mincount' => '1', 'facet.sort' => 'index')));
        $facet->setName('genre');
        $facet->setLabel('Textsorte');
        $controller->getFacets()->addFacet($facet);

        $facet = new HAB\Solr\Facet\DefaultFacetAdapter(new HAB\Solr\Facet\Impl\FieldFacet('language', array('facet.mincount' => '1', 'facet.limit' => 10)));
        $facet->setName('lang');
        $facet->setLabel('Sprache');
        $controller->getFacets()->addFacet($facet);

        $filter = new HAB\Selbstzeugnisse\ComponentStateFilter();
        $controller->getFacets()->setComponentStateFilter($filter);

        return $controller;
    }
);

$app['controller.repertorium.list'] = $app->factory(
    function () use ($app) {
        $twig    = $app['twig'];
        $config  = $app['mets'];
        $invoker = $app['solr.invoker'];

        $controller = new HAB\Selbstzeugnisse\SolrListController($config, $invoker, $twig);
        return $controller;
    }
);