
From Daniela email:

> I had a more detailed look at the disease call, which seems to be quite strange. The associations for disease call finds a gene, which in turn does not find any diseases. Here are the corresponding queries I tried:

http://alpha.openphacts.org:3002/disease/assoc/byDisease?uri=http%3A%2F%2Flinkedlifedata.com%2Fresource%2Fumls%2Fid%2FC0004238&app_id=f91c5b2b&app_key=18a5d823d0e4933ac5fe22a3d52974c1
 
> I took the first gene from this result to generate the return query.
 
http://alpha.openphacts.org:3002/disease/assoc/byTarget?uri=http%3A%2F%2Fidentifiers.org%2Fncbigene%2F3784&app_id=f91c5b2b&app_key=18a5d823d0e4933ac5fe22a3d52974c1

> Same query works in 2.1: 

https://beta.openphacts.org/2.1/disease/assoc/byTarget?uri=http%3A%2F%2Fidentifiers.org%2Fncbigene%2F3784&app_id=f91c5b2b&app_key=18a5d823d0e4933ac5fe22a3d52974c1
 
 
> Looking at the mappings, there is no link to uniprot from this ncbi gene ID

http://alpha.openphacts.org:3002/mapUri?app_id=f91c5b2b&app_key=18a5d823d0e4933ac5fe22a3d52974c1&Uri=http%3A%2F%2Fidentifiers.org%2Fncbigene%2F3784
 

> This seems to be a problem here, as the uniprot URI is required according to the documentation: ?dg_gene_uri ops:encodes ?uniprot_target_uri ;
In addition to adding the corresponding linkset (I think it should be this one 

http://beta.openphacts.org:3004/QueryExpander/mappingSet/16)

> I would suggest to remove this requirement and make it optional, as it would give a wrong impression getting a 404 for a gene where diseases are available (the main interest for the user), but the corresponding protein name is not.
