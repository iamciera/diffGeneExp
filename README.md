#README.md

This will be my ongoing analysis directory for my LCM project.  

All changes in differential expression analysis should be done in the `skeletonDE.Rmd` file. Each analysis should be done in a separate directory.  Include regions that are being analyzed in a `de.yml` file corresponding to each analysis and run `skeletonDE.Rmd` in the directory.  

This will output:
1. `DE_all.txt` : all genes in analysis
2. `DE_sig.txt` : all significantly differentially expressed genes (FDR < .05)
3. `skeletonDE.pdf` : A knitted full report of all the steps of the analysis.