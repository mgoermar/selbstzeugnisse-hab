<?php

namespace HAB\Selbstzeugnisse;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

use RuntimeException;

class StaticPageController
{
    private $configuration;

    public function __construct (Configuration $configuration)
    {
        $this->configuration = $configuration;
    }

    public function handle (Request $request, $targetId = 'html')
    {
        $metsId = $request->attributes->get('_route');
        $targetId = $request->query->get('target', $targetId);

        $sourceUri = $this->configuration->resolveSourceDocumentUri($metsId);
        if ($sourceUri == null) {
            throw new NotFoundHttpException('Unable to resolve source');
        }
        $source = Document::createFromUri($sourceUri);
        @$source->xinclude();

        $behavior = $this->configuration->resolveBehavior($metsId, $targetId);
        if ($behavior == null) {
            throw new NotFoundHttpException('Unable to resolve behavior');
        }

        $content = $behavior($source);
        if ($content instanceof Response) {
            $content->prepare($request);
            return $content;
        }
        return $content->saveHTML();
    }
}