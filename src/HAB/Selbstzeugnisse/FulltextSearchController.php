<?php

namespace HAB\Selbstzeugnisse;

use HAB\Solr\Command\Search;
use HAB\Solr\Command\Invoker;
use HAB\Solr\ParamBag;

use HAB\Paginator\Paginator;

use Symfony\Component\HttpFoundation\Request;

use Twig_Environment;
use RuntimeException;

class FulltextSearchController
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

        $query = $request->query->get('query');
        $page  = $request->query->get('page');

        $command = new Search('/select');
        $command->getQuery()->offsetSet('q',  $query ?: '*');
        $command->getQuery()->offsetSet('qf', 'text');

        $paginator = new Paginator();
        $paginator->setItemsPerPage(15);
        $paginator->setCurrentPage($page);

        $params = new ParamBag();
        $params->set('start', $paginator->getCurrentPageOffset());
        $params->set('rows',  $paginator->getItemsPerPage());
        $params->set('hl', 'true');
        $params->set('hl.fl', 'text');
        $params->set('hl.simple.pre', '{{{');
        $params->set('hl.simple.post', '}}}');
        $params->set('hl.snippets', '5');
        $params->set('hl.highlightMultiTerm', 'true');
        
        $pages = $this->invoker->invoke($command, $params);
        $paginator->setNumberOfItems($pages->getTotal());

        $context = array();
        $context['pages']     = $pages;
        $context['query']     = $query;
        $context['paginator'] = $paginator;

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