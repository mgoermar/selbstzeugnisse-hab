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

class SolrResultsController
{
    private $configuration;
    private $invoker;
    private $facets;
    private $twig;

    private $fieldmap = array(
        'all' => 'title abstract creator contributor identifier^2.0',
        'tit' => 'title',
        'per' => 'creator contributor',
        'abs' => 'abstract',
        'sgn' => 'identifier'
    );

    private $fieldlabel = array(
        'all' => 'Alle Felder',
        'tit' => 'Titel',
        'per' => 'Personen',
        'abs' => 'Zusammenfassung',
        'sgn' => 'Signatur'
    );

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

        $query = $request->query->get('query');
        $field = $request->query->get('field') ?: 'all';
        $sort  = $request->query->get('sort')  ?: 'date_min asc';
        $page  = $request->query->get('page');

        if (!array_key_exists($field, $this->fieldmap)) {
            $field = 'all';
        }

        $command = new Search('/select');
        $command->getQuery()->offsetSet('q',  $query ?: '*');
        $command->getQuery()->offsetSet('qf', $this->fieldmap[$field]);
        $command->getQuery()->offsetSet('sort', $sort);

        $facets = $this->getFacets();
        $facets->setComponentState($request->query);
        $paginator = new Paginator();
        $paginator->setItemsPerPage(30);
        $paginator->setCurrentPage($page);
        $params = new ParamBag($facets->getSearchParameters());
        $params->set('start', $paginator->getCurrentPageOffset());
        $params->set('rows',  $paginator->getItemsPerPage());

        $records = $this->invoker->invoke($command, $params);
        $facets->setRecordCollection($records);

        $paginator->setNumberOfItems($records->getTotal());

        $context = array();
        $context['records']   = $records;
        $context['fields']    = $this->fieldlabel;
        $context['field']     = $field;
        $context['query']     = $query;
        $context['facets']    = $facets;
        $context['paginator'] = $paginator;
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

    public function getFacets ()
    {
        if (is_null($this->facets)) {
            $this->facets = new FacetCollection();
        }
        return $this->facets;
    }

    private static function escape ($value)
    {
        return htmlspecialchars($value, ENT_XML1|ENT_COMPAT);
    }

}