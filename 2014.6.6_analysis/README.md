#README.md

June 5, 2014

This was the original analysis done as stringent as possible, but unfortunaltley I lost many differentially expressed (DE) genes and was unable to create any GO categories from the list of DE genes.  The lists are great for looking at individual gene expression analysis. 

Sig gene cutoff is FDR < .05.

June 6, 2014

There was a problem in the skeleton script during the merging with annotation files. The problem was that it was throwing away unmatched rows, thus significantly decreasing the number of genes in the sig. gene list (because of the `all.x=TRUE` was not present)

    results.sig.annotated <- merge(results.sig,annotation,by = "ITAG", all.x=TRUE)

I re-ran with the correct line above. Now I need to re-do the GO enrichment analysis. 