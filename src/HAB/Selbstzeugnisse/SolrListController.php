<?php

namespace HAB\Selbstzeugnisse;

use HAB\Solr\Command\Search;
use HAB\Solr\Command\Invoker;
use HAB\Solr\Facet\FacetCollection;
use HAB\Solr\ParamBag;

use HAB\Paginator\Paginator;

use Symfony\Component\HttpFoundation\Request;

use Twig_Environment;

use RuntimeException;

class SolrListController
{
    private $configuration;
    private $invoker;
    private $twig;

    public function __construct (Configuration $configuration, Invoker $invoker, Twig_Environment $twig)
    {
        $this->configuration = $configuration;
        $this->invoker = $invoker;
        $this->twig = $twig;
    }

    public function handle (Request $request, $targetId = 'html')
    {
        $metsId = $request->attributes->get('_route');

        $sourceUri = $this->configuration->resolveSourceDocumentUri($metsId, true);
        if ($sourceUri == null) {
            throw new RuntimeException('Unable to resolve source');
        }

        $field = $request->query->get('feld', 'origdate_pivot');

        $command = new Search('/select');
        $command->getQuery()->offsetSet('q',  '*');
        $command->getQuery()->offsetSet('qf', '*');

        $params = new ParamBag();
        $params->set('start', '0');
        $params->set('rows',  '-1');
        $params->set('group', 'true');
        $params->set('group.field', $field);
        $params->set('group.limit', '-1');
        $params->set('sort', "{$field} asc, date_min asc");

        $fields = [
            'origdate_pivot' => 'Selbstzeugnisse nach Entstehungszeit',
            'coverage_pivot' => 'Selbstzeugnisse nach Berichtszeitraum',
            'collection_pivot' => 'Selbstzeugnisse nach Bestandsgruppe',
            'genre' => 'Selbstzeugnisse nach Textsorte',
        ];

        $records = $this->invoker->invoke($command, $params);

        $context = array();
        $context['records']   = $records;
        $context['field']     = $field;
        $context['fields']    = $fields;
        $context['available'] = array_map(function ($metsId) { return substr($metsId, 20); }, $this->configuration->listMetsIds());
        
        $sourceData = $this->twig->render($sourceUri, $context);
        $source = Document::createFromString($sourceData);

        $behavior = $this->configuration->resolveBehavior($metsId, $targetId);
        if ($behavior == null) {
            throw new RuntimeException('Unable to resolve behavior');
        }

        $content = $behavior($source);
        return $content->saveHTML();

    }
}