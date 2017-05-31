
### Details on disease/assoc/byTarget issue

Query works in 2.1 (beta) but not in new 2.2 (alpha)

* [2.1 beta](https://beta.openphacts.org/2.1/disease/assoc/byTarget?uri=http%3A%2F%2Fpurl.uniprot.org%2Funiprot%2FQ9Y5Y9&app_id=f91c5b2b&app_key=18a5d823d0e4933ac5fe22a3d52974c1)

* [2.2 alpha](http://alpha.openphacts.org:3002/disease/assoc/byTarget?uri=http%3A%2F%2Fpurl.uniprot.org%2Funiprot%2FQ9Y5Y9)

/disease/assoc/byTarget

* uri=http://purl.uniprot.org/uniprot/Q9Y5Y9
* uri=http%3A%2F%2Fpurl.uniprot.org%2Funiprot%2FQ9Y5Y9

```
curl --get --data-urlencode uri="http://purl.uniprot.org/uniprot/Q9Y5Y9" http://beta.openphacts.org:3002/disease/assoc/byTarget
```

----

Cause: The generated SPARQL queries differ on beta vs alpha.  The two queries are identical, except for line 22.

The queries are here:

* [beta 2.1](beta-2.1.sparql)
* [alpha 2.2](alpha-2.2.sparql)

On beta line 22 is:
```
 VALUES ?dg_gene_uri { <http://identifiers.org/ncbigene/6336> } GRAPH <http://rdf.imim.es> {
```

On alpha line 22 is:
```
 VALUES ?dg_gene_uri { <http://www.openphacts.org/api#no_mappings_found> } GRAPH <http://rdf.imim.es> {
```

Difference is that in 2.1 the input protein/gene appears to get mapped to:  `http://identifiers.org/ncbigene/6336`.
But that doesn't happen in 2.2 on alpha.

QueryExpander returns more entries on beta than on alpha for the following for uri=http://purl.uniprot.org/uniprot/Q9Y5Y9 

Results on beta:
http://beta.openphacts.org:3004/QueryExpander/mapUri?Uri=http%3A%2F%2Fpurl.uniprot.org%2Funiprot%2FQ9Y5Y9&lensUri=http%3A%2F%2Fopenphacts.org%2Fspecs%2F%2FLens%2FDefault&Pattern+Filter=&overridePredicateURI=&format=text%2Fhtml

Results on alpha:
http://alpha.openphacts.org:3004/QueryExpander/mapUri?Uri=http%3A%2F%2Fpurl.uniprot.org%2Funiprot%2FQ9Y5Y9&lensUri=http%3A%2F%2Fopenphacts.org%2Fspecs%2F%2FLens%2FDefault&Pattern+Filter=&overridePredicateURI=&format=text%2Fhtml

The notable difference is than on alpha there is no "Entrez Gene" section.  On beta the Entrez section shows
the gene with ID = '6336'.

Using QueryExpander to check linksets for Entrez Gene, there is a difference.  beta (2.1) has one additional
linkset between Entrez and Ensembl that is not in alpha (2.2).

[beta](http://beta.openphacts.org:3004/QueryExpander/mappingSet?sourceCode=L&targetCode=En&lensUri=All)

[alpha](http://alpha.openphacts.org:3004/QueryExpander/mappingSet?sourceCode=L&targetCode=En&lensUri=All)

The difference is that the following Linkset file is in 2.1 but not 2.2:  `Ensembl_Hs_ncbigene.direct.LS.ttl.gz`.

Here is where I was directed to get these linkset files from:  http://www.bridgedb.org/data/linksets/current/HomoSapiens/


----
