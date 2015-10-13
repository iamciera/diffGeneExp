## Comparing Replicates

Required libraries. 

```{r}
library(ggplot2)
library(reshape2)
```

```{r}
# Multiple plot function
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


graph <- function(DF, x, y) {
    ggplot(DF, aes_string(x,y)) + 
      geom_point(alpha=.5) + 
      xlim(0, 15) +
      ylim(0 ,15)
}


normCount <- read.csv("../data/normalized_read_count.csv")

head(normCount)
dim(normCount)

samples <- colnames(normCount)
tCount <- log2(normCount[,2:49])

###tf2ambr

a <- graph(tCount, "tf2ambr1", "tf2ambr3")
b <- graph(tCount, "tf2ambr1", "tf2ambr4")
c <- graph(tCount, "tf2ambr1", "tf2ambr6")
d <- graph(tCount, "tf2ambr3", "tf2ambr6")
e <- graph(tCount, "tf2ambr3", "tf2ambr4")
  
multiplot(a, b, c, d, e, cols=2)
  
png(filename="~/Desktop/tf2ambr.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, cols=2)
dev.off()

###tf2aother

colnames(tCount)

a <- graph(tCount, "tf2aother1", "tf2aother2")
b <- graph(tCount, "tf2aother1", "tf2aother4")
c <- graph(tCount, "tf2aother1", "tf2aother7")
d <- graph(tCount, "tf2aother2", "tf2aother4")
e <- graph(tCount, "tf2aother2", "tf2aother7")
f <- graph(tCount, "tf2aother4", "tf2aother7")

multiplot(a, b, c, d, e, f, cols=2)

png(filename="~/Desktop/tf2aother.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, cols=2)
dev.off()



###tf2bmbr

colnames(tCount)

a <- graph(tCount, "tf2bmbr2", "tf2bmbr5")
b <- graph(tCount, "tf2bmbr2", "tf2bmbr6")
c <- graph(tCount, "tf2bmbr5", "tf2bmbr6")

multiplot(a, b, c, cols=2)

png(filename="~/Desktop/tf2bmbr.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, cols=2)
dev.off()

###tf2bother

colnames(tCount)

a <- graph(tCount, "tf2bother1", "tf2bother3")
b <- graph(tCount, "tf2bother1", "tf2bother4")
c <- graph(tCount, "tf2bother1", "tf2bother6")
d <- graph(tCount, "tf2bother3", "tf2bother4")
e <- graph(tCount, "tf2bother3", "tf2bother6")
f <- graph(tCount, "tf2bother4", "tf2bother6")

multiplot(a, b, c, d, e, f, cols=2)

png(filename="~/Desktop/tf2bother.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, cols=2)
dev.off()

###tf2cmbr

colnames(tCount)

a <- graph(tCount, "tf2cmbr1.4", "tf2cmbr3")
b <- graph(tCount, "tf2cmbr1.4", "tf2cmbr6")
c <- graph(tCount, "tf2cmbr1.4", "tf2cmbr7")
d <- graph(tCount, "tf2cmbr3", "tf2cmbr6")
e <- graph(tCount, "tf2cmbr3", "tf2cmbr7")
f <- graph(tCount, "tf2cmbr6", "tf2cmbr7")

multiplot(a, b, c, d, e, f, cols=2)

png(filename="~/Desktop/tf2cmbr.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, cols=2)
dev.off()

###tf2cother

colnames(tCount)

a <- graph(tCount, "tf2cother2", "tf2cother5")
b <- graph(tCount, "tf2cother2", "tf2cother6")
c <- graph(tCount, "tf2cother2", "tf2cother7")
d <- graph(tCount, "tf2cother5", "tf2cother6")
e <- graph(tCount, "tf2cother5", "tf2cother7")
f <- graph(tCount, "tf2cother6", "tf2cother7")

multiplot(a, b, c, d, e, f, cols=2)

png(filename="~/Desktop/tf2cother.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, cols=2)
dev.off()



####################################################
##WT
#####################################################

###wtambr

a <- graph(tCount, "wtambr2", "wtambr4")
b <- graph(tCount, "wtambr2", "wtambr5")
c <- graph(tCount, "wtambr4", "wtambr5")

multiplot(a, b, c, cols=2)

png(filename="~/Desktop/wtambr.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, cols=2)
dev.off()

###wtaother

colnames(tCount)

a <- graph(tCount, "wtaother1", "wtaother5")
b <- graph(tCount, "wtaother1", "wtaother6")
c <- graph(tCount, "wtaother1", "wtaother7")
d <- graph(tCount, "wtaother1", "wtaother8")
e <- graph(tCount, "wtaother5", "wtaother6")
f <- graph(tCount, "wtaother5", "wtaother7")
g <- graph(tCount, "wtaother6", "wtaother7")
h <- graph(tCount, "wtaother6", "wtaother8")
i <- graph(tCount, "wtaother7", "wtaother8")

multiplot(a, b, c, d, e, f, g, h, i, cols=2)

png(filename="~/Desktop/wtaother.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, f, g, h, i, cols=2)
dev.off()

###wtbmbr

colnames(tCount)

a <- graph(tCount, "wtbmbr2", "wtbmbr3")
b <- graph(tCount, "wtbmbr2", "wtbmbr6")
c <- graph(tCount, "wtbmbr2", "wtbmbr8")
d <- graph(tCount, "wtbmbr3", "wtbmbr6")
e <- graph(tCount, "wtbmbr3", "wtbmbr8")
f <- graph(tCount, "wtbmbr6", "wtbmbr8")

multiplot(a, b, c, d, e, f, cols=2)

png(filename="~/Desktop/wtbmbr.png", width = 700, height = 1000)
multiplot(a, b, c, d, e,f, cols=2)
dev.off()

###wtbother

colnames(tCount)

a <- graph(tCount, "wtbother1.4", "wtbother3")
b <- graph(tCount, "wtbother1.4", "wtbother5")
c <- graph(tCount, "wtbother1.4", "wtbother8")
d <- graph(tCount, "wtbother3", "wtbother5")
e <- graph(tCount, "wtbother3", "wtbother8")
f <- graph(tCount, "wtbother5", "wtbother8")

multiplot(a, b, c, d, e, f, cols=2)

png(filename="~/Desktop/wtbother.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, f, cols=2)
dev.off()

###wtcmbr

colnames(tCount)

a <- graph(tCount, "wtcmbr10", "wtcmbr1.4.6")
b <- graph(tCount, "wtcmbr10", "wtcmbr2")
c <- graph(tCount, "wtcmbr10", "wtcmbr3")
d <- graph(tCount, "wtcmbr10", "wtcmbr7")
e <- graph(tCount, "wtcmbr10", "wtcmbr9")
f <- graph(tCount, "wtcmbr1.4.6", "wtcmbr2")
g <- graph(tCount, "wtcmbr1.4.6", "wtcmbr3")
h <- graph(tCount, "wtcmbr1.4.6", "wtcmbr7")
i <- graph(tCount, "wtcmbr1.4.6", "wtcmbr9")
j <- graph(tCount, "wtcmbr3", "wtcmbr7")
k <- graph(tCount, "wtcmbr3", "wtcmbr9")
l <- graph(tCount, "wtcmbr7", "wtcmbr9")

multiplot(a, b, c, d, e, f, g, h, i, j, k, l, cols=2)

png(filename="~/Desktop/wtcmbr.png", width = 700, height = 1000)
multiplot(a, b, c, d, e, f, g, h, i, j, k, l, cols=2)
dev.off()

###wtcother

colnames(tCount)

a <- graph(tCount, "wtcother1.3.4", "wtcother2")
b <- graph(tCount, "wtcother1.3.4", "wtcother6")
c <- graph(tCount, "wtcother2", "wtcother6")

multiplot(a, b, c, cols=2)

png(filename="~/Desktop/wtcother.png", width = 700, height = 1000)
multiplot(a, b, c, cols=2)
dev.off()



