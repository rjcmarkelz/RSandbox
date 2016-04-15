library("devtools")
library("roxygen2")
setwd("~/git.repos/cRops")
create("cRops")

#list objects
n <- 10
m <- 6
marray <- matrix(rnorm(n * m, 10, 5), ncol = m)
pmeta <- data.frame(sampleId = 1:m, condition = rep(c("WT", "MUT"), each = 3))
rownames(pmeta) <- colnames(marray) <- LETTERS[1:m]
fmeta <- data.frame(geneID = 1:n, pathway = sample(LETTERS, n, replace = TRUE))
rownames(fmeta) <- rownames(marray) <- paste0("probe", 1:n)

# put them all together in a list
maxep <- list(marray = marray, fmeta = fmeta, pmeta = pmeta)
rm(marray, fmeta, pmeta)
str(maxep)

# get at each element with $ operator
maxep$pmeta
summary(maxep$marray[, "A"])

wt <- maxep # blah blah blah
boxplot(maxep$marray) 
##### basically a pain to keep all this shit here and access all the 
##### components of the list

### All hail OO programing for keeping us sane with dealing with 
### complext data structures
# S4 example

MArray <- setClass("MArray",
                   slots = c(marray = "matrix",
                        fmeta = "data.frame", 
                        pmeta = "data.frame"))
MArray # class generator function
MArray()

test <- MArray(marray = maxep[[1]],
                pmeta = maxep[["pmeta"]],
                fmeta = maxep[["fmeta"]])
class(test)
test
test@pmeta #access individual slots

#######now for some methods on these objects######
show # generic method from methods package
# S6 classes to not rely on methods package
isGeneric("show")


