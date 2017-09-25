<?php

namespace HAB\Selbstzeugnisse;

use HAB\Solr\Facet\StateFilter\StateFilterInterface;

use Symfony\Component\HttpFoundation\ParameterBag;

class ComponentStateFilter implements StateFilterInterface
{
    /**
     * {@inheritDoc}
     */
    public function filter (ParameterBag $state)
    {
        $state = clone($state);
        $state->remove('page');
        return $state;
    }
}