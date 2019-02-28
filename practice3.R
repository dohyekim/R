# read.delim####
sepdata = read.delim('data/sep.txt', sep='#')
sepdata
str(sepdata) #dim(), class()의 결과까지 다 나옴
dim(sepdata) # 9, 4
class(sepdata) #data.frame
summary(sepdata) # summed data
View(sepdata) # shown as a reader-friendly table

sepdata$name =  as.character(sepdata$name)
str(sepdata)

head(sepdata) #useful when handling BigData
tail(sepdata)

# read.table ####
# X2019 (R does not allow column names to start with numbers)

tsvdata = read.table("data/tcv.tsv", sep='\t')
tsvdata
tsvdata = read.table("data/tcv.tsv", sep='\t', header=T)
tsvdata
str(tsvdata)
tsvdata = read.table("data/tcv.tsv", sep='\t', header=T, stringsAsFactors = F)
str(tsvdata)

# read.fwf(fixed width file) ####
# has to end with \n bc it separates data by 'readline'

#read_excel ####

install.packages('readxl')
library('readxl')
mtx = read_excel('data/meltop100.xlsx')
mtx
mtx = read_excel('data/meltop100.xlsx', sheet=1)
mtx
mtx = read_excel('data/meltop100.xlsx', sheet=1, col_names=F) # Header does not exist
mtx
colnames(mtx)

str(mtx)
dim(mtx)
View(mtx)
mtx = read_excel('data/meltop100.xlsx', sheet=1, col_names=T)
mtx
colnames(mtx)
colnames(mtx)
rownames(mtx)

#trythis1 ####
mtx = mtx[-(nrow(mtx)), ]
tail(mtx)

#trythis2 ####
trycsv = read.csv('data/trycsv')
trycsv
save(trycsv, file="data/trycsv.rda")
rm(trycsv) # have to delete it first as it will automatically generated when loaded
load("data/trycsv.rda")
View(trycsv)

mtx = read_excel('data/meltop100.xlsx', sheet=1, col_names=T)
mtx = mtx[-(nrow(mtx)), ]
tail(mtx)
save(mtx, file='data/meltop100.csv')
read.csv('data/meltop100.csv')

#trythis3 ####
tmp = read.fwf('data/temper.txt', header=F, stringsAsFactor=F, width=c(15,4,68,5,1))
tmp$V1 = as.character(tmp$V1)
tmp$V4 = as.character(tmp$V4)

str(tmp)
tmp = tmp[,c(2,4,5)]
colnames(tmp) = c('년도', '온도', '구분값')
head(tmp)
