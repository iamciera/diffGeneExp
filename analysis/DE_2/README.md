# README.md
## DE_2

Started Monday October 12, 2015.

This project is going to re-do the differential gene expression (DE) for the LCM project.  The first time I performed DE I did 28 pairwise analysis, which is the wrong way to approach my data considering the complexity of my data. 

I have re-designed my approach based on linear modelling approaches.  There are essentially five questions I am attempting to ask. 

## My Data

-  3 groups - Top, Middle, and Base
-  2 tissues - Marginal Blastozone (MBR) and Rachis
-  2 genotypes - Wild Type (WT) and *tf-2*

## Questions

1. **Are there genes that are differentially expressed between MBR and Rachis in all three groups across the longitudinal axis?** Genotype specific. Basically asking what are the genes that define the Marginal Blastozone. What are the genes that define the Rachis. I am most interested in what is occuring in WT. This can be performed in each genotype and compared. **Hypothesis**: There will be genes that overlap between the analysis done between the two genotypes because the Marginal Blastozone.  
2. **Are there genes that are differentially expressed in MBR in all three groups (top, middle, base)?** Genotype specific.  This gets at the longitudinal axis of the MBR.  Are there gene that define the base, middle, and tip.  This will take advantage of ANOVA. 
3. **Are there gene that are differentially expressed in Rachis in all three groups (top, middle, base)?** Genotype specific.  Very similar to Question 2, except in the Rachis. 
4. **Are there genes that are differentially expressed between *tf-2* and WT MBR tissue across logitudinal axis?**  This is essentially a pairwise look between genotypes.  This will get at the cool MBR between the two genotypes questions. 
5. **Are there genes that are differentially expressed between *tf-2* and WT Rachis tissue across logitudinal axis?**  This is similar to Question 4 except with Rachis tissue. 

My **hypothesis** for question 4 and 5 is that there will not be much difference between WT and *tf-2*, with the exception of MBR.  If there is a difference, it will likely reflect how much further differentiated *tf-2* is from WT. 





