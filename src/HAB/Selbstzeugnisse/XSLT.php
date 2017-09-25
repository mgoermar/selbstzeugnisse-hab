<?php

namespace HAB\Selbstzeugnisse;

use Symfony\Component\HttpFoundation\Response;

use RuntimeException;
use XSLTProcessor;
use DOMDocument;

class XSLT implements BehaviorInterface
{
    private $stylesheet;

    public function __construct (DOMDocument $stylesheet)
    {
        $this->stylesheet = $stylesheet;
    }

    public function __invoke ($source)
    {
        $processor = new XSLTProcessor();
        if ($processor->importStylesheet($this->stylesheet) === false) {
            throw new RuntimeException();
        }
        $target = @$processor->transformToDoc($source);
        if ($target === false) {
         throw new RuntimeException();
        }

        $output = $this->stylesheet->getElementsByTagNameNS('http://www.w3.org/1999/XSL/Transform', 'output');
        if ($output->length > 0) {
            $output = $output->item(0);
            $method = $output->getAttribute('method') ?: 'xml';
            $mimetype = $output->getAttribute('media-type');
            if (!$mimetype) {
                if ($method === 'xml') {
                    $mimetype = 'application/xml';
                } else {
                    $mimetype = 'text/html';
                }
            }
        } else {
            $mimetype = 'text/html';
            $method   = 'html';
        }

        if ($method === 'html') {
            return $target;
        }

        $content = $target->saveXml();
        $headers = array('Content-Type' => $mimetype);
        $response = new Response($content, 200, $headers);
        return $response;
    }
}
