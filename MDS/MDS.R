#analyzing RNAseq for differential expression


library(edgeR)

#read in raw count data per gene
counts <- read.delim("sam2countsResults.tsv",row.names=1)

#check the file
head(counts)
summary(counts)
#need to convert NA to 0 counts
counts[is.na(counts)] <- 0

#convert data to a form that edgeR wants
data <- DGEList(counts=counts,group=rep(c("35SUFO","VF36"),times=c(3,3)))
  
data$samples
#Filter to exclude genes that have <2 counts in (N Rep)-1
cpm.data<- cpm(data)
data<- data[rowSums(cpm.data>2)>=3,] #CHANGED TO 2
             
#normalize library
data <- calcNormFactors(data)
data$pseudo<- equalizeLibSizes(data)
write.csv (data$pseudo$pseudo,"normalized_read_count.csv")

# read in norm data
data_norm <- read.csv("normalized_read_count.csv", row.names=1)
dim(data_norm) 

#Boxplot
Normexplog<- log(data_norm,2)  
pdf("boxplot.norm.all.pdf")
boxplot (Normexplog)
dev.off()

## MDS using dist and cmdscale
# library
library(ggplot2)

m <- cmdscale(dist(scale(t(data_norm))))
colnames(m) <- c("x", "y")
m<-as.data.frame(m)
m$sample <- c("flowers","flowers","flowers","flowers","flowers","flowers","flowers","flowers",
"haustoria","haustoria","haustoria","haustoria","haustoria","haustoria","haustoria","haustoria",
"prehaustoria","prehaustoria","prehaustoria","prehaustoria","prehaustoria","prehaustoria","prehaustoria","prehaustoria",
"seedlings","seedlings","seedlings","seedlings","seed","seed","seed","seed",
"stem","stem","stem","stem","stem","stem","stem","stem")

pdf("MDScmdscale.all.pdf",height=6,width=8)
ggplot(m, aes(x,y,colour=sample))+geom_point(size=5)+theme_bw()
dev.off()

