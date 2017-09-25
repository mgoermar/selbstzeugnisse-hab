<?php

$app->register(new Silex\Provider\TwigServiceProvider());
$app->register(new Silex\Provider\ServiceControllerServiceProvider());

$app['solr.url'] = 'http://194.95.134.40:8080/solr/selbst';
$app['solr.client'] = $app->factory(
    function () use ($app) {
        return new GuzzleHttp\Client();
    }
);
$app['solr.invoker'] = $app->factory(
    function () use ($app) {
        $url = $app['solr.url'];
        $client = $app['solr.client'];
        return new HAB\Solr\Command\Invoker($url, $client);
    }
);

$app['solr.ft.url'] = 'http://194.95.134.40:8080/solr/selbst-ft';
$app['solr.ft.client'] = $app->factory(
    function () use ($app) {
        return new GuzzleHttp\Client();
    }
);
$app['solr.ft.invoker'] = $app->factory(
    function () use ($app) {
        $url = $app['solr.ft.url'];
        $client = $app['solr.ft.client'];
        return new HAB\Solr\Command\Invoker($url, $client);
    }
);


$app['mets'] = $app->factory(
    function () use ($app) {
        return new HAB\Selbstzeugnisse\Configuration(__DIR__ . '/../resources/mets.xml');
    }
);

$app['twig.path'] = array(__DIR__ . '/../resources');
