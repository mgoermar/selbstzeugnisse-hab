<?php

namespace HAB\Selbstzeugnisse;

use SplObjectStorage;
use DOMDocument;
use DOMElement;
use DOMXPath;

class Configuration
{
    const METS  = 'http://www.loc.gov/METS/';
    const XLINK = 'http://www.w3.org/1999/xlink';

    private $behaviors = array();
    private $files = array();
    private $divs = array();

    public function __construct ($filename)
    {
        $document  = Document::createFromUri($filename);
        @$document->xinclude();
        $this->documents = new SplObjectStorage;

        $this->index($document);
        foreach ($document->getElementsByTagNameNS(self::METS, 'mptr') as $mptr) {
            $mptrUri = $mptr->getAttributeNS(self::XLINK, 'href');
            $mptrDoc = Document::createFromUri(dirname($mptr->baseURI) . '/' . $mptrUri);
            $this->index($mptrDoc);
        }
    }

    public function listMetsIds ()
    {
        return array_keys($this->divs);
    }

    public function resolveSourceDocumentUri ($metsId, $relativeUri = false)
    {
        if (array_key_exists($metsId, $this->divs)) {
            if ($fptr = $this->getFirstChildElement($this->divs[$metsId])) {
                $fileId = $fptr->getAttribute('FILEID');
                if (array_key_exists($fileId, $this->files)) {
                    if ($flocat = $this->getFirstChildElement($this->files[$fileId])) {
                        $uri = $flocat->getAttributeNS(self::XLINK, 'href');
                        if ($relativeUri) {
                            return $uri;
                        }
                        $baseUri = dirname($flocat->ownerDocument->baseURI);
                        return $baseUri . '/' . $uri;
                    }
                }
            }
        }
    }

    public function resolveBehavior ($metsId, $targetId)
    {
        while (isset($this->divs[$metsId])) {
            if (isset($this->divs[$metsId]) and isset($this->behaviors[$targetId][$metsId])) {
                $behavior = $this->behaviors[$targetId][$metsId];
                $mechanism = $behavior->getElementsByTagNameNS(self::METS, 'mechanism')->item(0);
                if ($mechanism) {
                    $uri = sprintf('%s/%s', dirname($mechanism->baseURI), $mechanism->getAttributeNS(self::XLINK, 'href'));
                    $stylesheet = Document::createFromUri($uri);
                    return new XSLT($stylesheet);
                }
            }
            $metsId = $this->divs[$metsId]->parentNode->getAttribute('ID');
        }
    }

    protected function index (DOMDocument $document)
    {
        foreach ($document->getElementsByTagNameNS(self::METS, 'file') as $node) {
            if ($nodeId = $node->getAttribute('ID')) {
                $this->files[$nodeId] = $node;
            }
        }
        foreach ($document->getElementsByTagNameNS(self::METS, 'div') as $node) {
            if ($nodeId = $node->getAttribute('ID')) {
                $this->divs[$nodeId] = $node;
            }
        }
        foreach ($document->getElementsByTagNameNS(self::METS, 'behaviorSec') as $section) {
            $sectionId = $section->getAttribute('ID');
            foreach ($section->getElementsByTagNameNS(self::METS, 'behavior') as $node) {
                if ($nodeIds = explode(' ', $node->getAttribute('STRUCTID'))) {
                    foreach ($nodeIds as $nodeId) {
                        $this->behaviors[$sectionId][trim($nodeId)] = $node;
                    }
                }
            }
        }
    }

    protected function getFirstChildElement (DOMElement $parent, $localname = null)
    {
        foreach ($parent->childNodes as $node) {
            if ($node instanceof DOMElement) {
                if ($localname === null or $node->localName === $localname) {
                    return $node;
                }
            }
        }
    }
}