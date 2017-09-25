<?php

namespace HAB\Selbstzeugnisse;

use RuntimeException;
use DOMDocument;

class Document
{
    public static function createFromUri ($uri, $options = 0)
    {
        $document = new DOMDocument();
        if (@$document->load($uri, $options) === false) {
            throw new RuntimeException(sprintf("Unable to create document from URI '%s'", $uri));
        }
        return $document;
    }

    public static function createFromString ($string, $options = 0)
    {
        $document = new DOMDocument();
        if (@$document->loadXml($string, $options) === false) {
            throw new RuntimeException("Unable to create document from string data");
        }
        return $document;
    }
}