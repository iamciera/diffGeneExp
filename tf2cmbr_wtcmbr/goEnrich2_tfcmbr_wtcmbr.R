# GO analysis on gene lists of Solyc genes 

library(goseq)
library(GO.db)

#### transcripts file ####
Sol_trans_len <- read.table("ITAG2.3_cds.mod.length.txt", sep="\t", h=T)

colnames(Sol_trans_len) <- c("Gene", "length")
Sol_trans_lenf <- Sol_trans_len[, 1]
Sol_trans_len2 <- Sol_trans_len[, 2]
genes.in.annot <- Sol_trans_lenf

head(genes.in.annot)

#### GO file ####
go <- read.table("GO.table.txt", h = T)
colnames(go) <- c("Gene", "GO")
go.list <- strsplit(as.character(go[, 2]),split = ",", fixed = T)
names(go.list) <- as.character(go[, 1])


#### expression file ####
genes <- read.csv("tf2cmbr_wtcmbr_DE1_full.csv", row.names = 1) # Note: you need ALL the genes, not just the sig ones!!

# If you are using a gene expression file with ALL the genes in it, use this code!
genes.DEup.all <-  as.numeric(genes$FDR[genes$logFC >= 0] < 0.05) #genes that are differentially expressed


genes.DEdn.all <-  as.numeric(genes$FDR[genes$logFC < 0] < 0.05) #genes that are differentially expressed
#genes.DEup <- as.numeric(genes$FDR < 0.01) # use this instead if you have more than one logFC so you can't choose up/down
names(genes.DEup.all) <- genes$Row.names[genes$logFC >= 0]
names(genes.DEdn.all) <- genes$Row.names[genes$logFC < 0]

################################################################################################
#### ONLY IF you are using a gene expression file with only the sig genes it, use this code ####
genes.DEup <- as.numeric(genes$Row.names[genes$logFC >= 0] != 1) 
names(genes.DEup) <- genes$Row.names[genes$logFC >= 0]

genes.DEup.zero.names <- Sol_trans_lenf[!Sol_trans_lenf %in% genes$Row.names[genes$logFC >= 0]]
genes.DEup.zero <- rep(0, length(genes.DEup.zero.names))
names(genes.DEup.zero) <- genes.DEup.zero.names

genes.DEup.all <- c(genes.DEup, genes.DEup.zero)
genes.DEup.all <- genes.DEup.all[names(genes.DEup.all) %in% names(go.list)]

genes.DEdn <- as.numeric(genes$Row.names[genes$logFC < 0] != 1) 
names(genes.DEdn) <- genes$Row.names[genes$logFC < 0]

genes.DEdn.zero.names <- Sol_trans_lenf[!Sol_trans_lenf %in% genes$Row.names[genes$logFC < 0]]
genes.DEdn.zero <- rep(0, length(genes.DEdn.zero.names))
names(genes.DEdn.zero) <- genes.DEdn.zero.names

genes.DEdn.all <- c(genes.DEdn, genes.DEdn.zero)
genes.DEdn.all <- genes.DEdn.all[names(genes.DEdn.all) %in% names(go.list)]
###############################################################################################

# only include genes in the go.list
genes.DEup.all <- genes.DEup.all[names(genes.DEup.all) %in% names(go.list)]
genes.DEdn.all <- genes.DEdn.all[names(genes.DEdn.all) %in% names(go.list)]

# pulls out length of genes in DEup and DEdn dataframes
bias <- Sol_trans_len2
names(bias) <- genes.in.annot
UP_bias <- bias[names(bias) %in% names(genes.DEup.all)]
DOWN_bias <- bias[names(bias) %in% names(genes.DEdn.all)]

# calcs the Probability Weighting Function! 
pwfup <- nullp(genes.DEup.all, bias.data = UP_bias) # they should not all be at 1.0 proportion DE -- double check plot
pwfdn <- nullp(genes.DEdn.all, bias.data = DOWN_bias) 

# does the go analysis using PWF
go.analysis.up <- goseq(pwfup, gene2cat = go.list)
go.analysis.dn <- goseq(pwfdn, gene2cat = go.list)

print(length(go.analysis.up$category[p.adjust(go.analysis.up$over_represented_pvalue, method="BH") < 0.01]))

# builds a GO enrichment table from the analysis
enriched.GO_category <- go.analysis.up$category[go.analysis.up$over_represented_pvalue < 0.01]
enriched.GO_p_value <- go.analysis.up$over_represented_pvalue[go.analysis.up$over_represented_pvalue < 0.01]
enriched.GO.up <- as.data.frame(cbind(enriched.GO_category, enriched.GO_p_value))
enriched.GO.up$term <- Term(as.character(enriched.GO.up$enriched.GO_category))
enriched.GO.up$ont <- Ontology(as.character(enriched.GO.up$enriched.GO_category))
enriched.GO.up$updn <- "up"

enriched.GO_category <- go.analysis.dn$category[go.analysis.dn$over_represented_pvalue < 0.01]
enriched.GO_p_value <- go.analysis.dn$over_represented_pvalue[go.analysis.dn$over_represented_pvalue < 0.01]
enriched.GO.dn <- as.data.frame(cbind(enriched.GO_category, enriched.GO_p_value))
enriched.GO.dn$term <- Term(as.character(enriched.GO.dn$enriched.GO_category))
enriched.GO.dn$ont <- Ontology(as.character(enriched.GO.dn$enriched.GO_category))
enriched.GO.dn$updn <- "dn"

enriched.GO <- rbind(enriched.GO.up, enriched.GO.dn)

print(head(enriched.GO))
write.csv(enriched.GO, file = outname)



