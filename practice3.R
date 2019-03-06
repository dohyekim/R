sys.sleep(10)

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
mtx = read_excel('data/meltop100.xlsx', sheet=1) # default : col_names=T
mtx = mtx[-(nrow(mtx)), ]
tail(mtx)
save(mtx, file="data/meltop100_rmlast.rda") # rda로 저장하는 것은 파일을 쓰는 의미가 아님, 읽을 때 load하면 rda에 있는 변수를 불러옴)

#trythis2 ####
trycsv = read.csv('data/trycsv')
trycsv
save(trycsv, file="data/trycsv.rda")
rm(trycsv) # have to delete it first as it will automatically be generated when loaded
load("data/trycsv.rda")
View(trycsv)

#trythis3 ####
tmp = read.fwf('data/temper.txt', header=F, stringsAsFactor=F, width=c(15,4,68,5,1))
tmp


tmp$V1 = as.character(tmp$V1)
tmp$V4 = as.character(tmp$V4)

str(tmp)
tmp = tmp[,c(2,4,5)]
# tmp$V1 = NULL
# tmp$V3 = NULL
colnames(tmp) = c('년도', '온도', '구분값')
head(tmp)

# ch.7 ##########
str(data)
boxplot(data$국어)
hist(data$국어)

data[data$학번==10337, '예체']
km = data[data$국어 > 90 & data$수학 > 90, ]
km[order(km$수학,decreasing=T),]


mean(data$수학)
sum(data$수학)
median(data$수학)

data$국어
data$국어 + data$영어 + data$수학
data$총점=

data$총점=NULL
data
head(data)
# aggregate(data=data, cbind(국어,영어,수학)~반, mean)


# install.packages('psych')
library('psych')
describe(data)
describe(data, IQR=T)

#trythis3-1 ####
head(data)
str(data)
# km2 = data[data$반 =='난' & data$성별=='남' & data$국어>90 & data$수학>90, ]
# km2[order(km2$국어),]
try1data = data[data$반 =='난' & data$성별=='남' , ]
try1data$전과목성적 = try1data[,4] + try1data[,5] + try1data[,6] + try1data[,7] + try1data[,8]
head(try1data)
hs = try1data[try1data$국어>90 & try1data$수학 > 90, c(1,4,9)]

orderedhs = hs[order-(hs$국어),c(1,3)]
orderedhs

# trythis3-2 ####
data$평균=(data[,4] + data[,5] + data[,6] + data[,7] + data[,8]) / 5
head(data)
# stu = data[data$국어>=80,]
# stu
# head(stu)
aggregate(data=data[data$국어>=80,], cbind(국어,평균)~반, mean)
# aggregate(data=data, 수학~반, mean)
# aggregate(data=data, cbind(국어,영어,수학)~반, mean)

read.csv('data/meltop10022.csv')
options(encoding = 'utf-8')

# ggplot ####
# install.packages("ggplot2")
library()
library(ggplot2)

data$pass=ifelse(data$평균>=60, T, F)
head(data)
data[data$pass,]

data$scout = ifelse(data$pass == T, ifelse(data$성별=='남','BS','GS'),'')

# trythi4-1 ####
qplot(data[data$scout !='',]$scout)

# trythis4-2 ####


data$학점=ifelse(data$평균>=90,'A',ifelse(data$평균>=80,'B',ifelse(data$평균>=70,'C',ifelse(data$평균>=60,'D','F'))))

#trythis4-3 ####
qplot(data$학점)



#mpg data ####
mpg = as.data.frame(ggplot2::mpg)
?mpg
str(mpg)
#통합연비는 두 연비의 평균 의미

# 시험1 mpg 데이터에서 통합 연비(도시와(cty) 고속도로(hwy))가 높은 순으로 출력하시오. ####
mpg$fuel = (mpg[,'cty'] + mpg[,'hwy'])/2
mpg$fule = NULL
head(mpg)
mpg[order(-(mpg$fuel)),]

# 시험2 mpg 데이터에서 생산연도별 연료 종류에 따른 통합연비를 연도순으로 출력하시오. ####

fperyrfl = aggregate(data=mpg, fuel~(fl+year), mean)
fperyrfl
fperyrfl[order(fperyrfl$year),]

#삽질
ordereds
str(mpg)
summary(mpg)
dim(mpg)
y = mpg[order(mpg$year,mpg$fl),]
head(y)
aggregate(data=y, fuel~(fl), mean)
?aggregate
aggregate(data=y, fl~year)

y19 = mpg[mpg$year==1999 ,c('year', 'fl', 'fuel')]
aggregate(data=y19, fuel~fl, mean)
y08 = mpg[mpg$year==2008, c('year','fl','fuel')]
aggregate(data=y08, fuel~fl, mean)


# column
# manufacturer: 제조사
# displ: 배기량(displacement)
# trans: 변속기 종류
# cyl: 실린더 개수
# drv: 구동방식(drive wheel)
# cty: 도시 연비
# hwy: 고속도로 연비
# fl: 연료종류(fuel)

#시험3 midwest 데이터를 data.frame으로 불러온 후, 데이터의 특징을 설명하시오. ####
library(psych)
describe(middf)
describe(midwest)
str(midwest)

middf = as.data.frame(midwest)

totaldensity=aggregate(data=middf, popdensity~state,mean)
totaldensity[order(-(totaldensity$popdensity)),]

asiandensity=aggregate(data=middf, percasian~state,mean)
asiandensity
asiandensity[order(-(asiandensity$percasian)),]

#PID는561부터3052까지있다. county는 총 437개가존재한다. state는총5개이다.총 백인의수는 416에서 많게는 32034947명,흑인은0~1317147,인디언은4부터10289,아시아인은0~188565,그외384119,와더불어 비율까지 알 수 있다. 성인의수와대학진학률,전문직,도시거주비율등을알수있다.표준편차가 클수록 kurtosis와skew값도크다. OH-MI-IL-IN-WI순으로인구밀도가높고, 주별평균백인비율이가장높은곳은IN-WI-OH-IL-MI,흑인(IL-OH-MI-IN-WI), 아시아인(IL-WI-MI-OH-IN), 인디언(WI-MI-IN-OH-IL), 그외(IL-MI-OH-WI-IN).



#시험4 poptotal 변수(컬럼)를 total로, popasian 변수를 asian으로 변수명을 변경하는 코드를 작성하시오. ####
colnames(middf)[colnames(middf)=="poptotal"] = "total"
colnames(middf)[colnames(middf)=="popasian"] = "asian"
colnames(middf)=="total"
colnames(middf)[colnames(middf)=="total"] 

??midwest
# 시험5 전체 아시아계 인구수와, asian 변수를 이용해 `전체 인구 대비 아시아계 인구 백분율` 파생변수(asianpct)를 추가하고, 히스토그램을 그리시오.####
summedasian = sum(middf$asian)
midwest$asianpct = middf[,'asian'] / summedasian * 100
ff = aggregate(data=middf, asianpct~state, mean)
hist(ff$asianpct)
histdata = middf[,c('asianpct', 'county')]
hist(histdata$asianpct)
histdata$asianpct
hist(histdata$asianpct)
aa = histdata[histdata$asianpct <= 5,]
aa
hist(aa$asianpct)
bb = histdata[histdata$asianpct <= 1,]
bb
hist(bb$asianpct)
cc = histdata[histdata$asianpct <= 0.1,]
hist(cc$asianpct)

dd = histdata[histdata$asianpct <= 0.01,]
hist(dd$asianpct)
qplot(dd$asianpct)

boxplot(dd$asianpct)

histdata$asianpct
data
a = data$수학
a
hist(a)

hist(data$영어)
qplot(data$영어)
histdata
qplot(data$scout)
qplot(data$pass)
hist(data$pass)
summary(data$pass)
qplot(histdata$asianpct)


?hist()
boxplot(histdata$asianpct)
# 시험6 ####
asianperstate= aggregate(data=histdata, asianpct~state, mean)
asianperstate[order(-asianperstate$asianpct),]

# 시험7 아시아계 인구 백분율(asianpct)의 전체 평균을 구하고, 평균을 초과하면 "lg", 그 외는 "sm"을 부여하는 파생변수(asianrate)를 추가하는 코드를 작성하시오. ####

mean(middf$asianpct)
middf$asianrate = ifelse(middf$asianpct > mean(middf$asianpct),"lg","sm")
head(middf$asianrate)

#시험8 "lg"와 "sm"에 해당하는 지역이 얼마나 되는지 빈도 막대그래프(qplot)을 그려보시오.####
library(ggplot2)
qplot(middf$asianrate)

# rep, seq ####
1:3
rep(1:3,times=2)
rep(1:3, each=2)
rep(1:10, by=2)
rep(c('I','am'), length.out=7)
data.frame(customer=rep(c('김일수','김이수'), each=2), menu=rep(c('짜장','짬뽕'),times=2))

-3:5
5.5:-4.5 # default 1
seq(5.5,-4.5)

seq(from=1, to=10, by=0.5)
seq(5.4, -4.5, length.out=10)
# seed가 같으면 같은 난수가 나옴
set.seed(100); sample(1:5, size=3)

#runif n
runif(20)
t= runif(n=30, min=10, max=20)
t
plot(t[order(t)])
hist(t[order(t)])

# sample ####

sample(1:5, size=3)
sample(1:5, 3) # size=3
set.seed(100)
sample(1:5, size=3)

#sample(size) : n개
sample(1:5, size=30,replace=T)
data[sample(1:nrow(data), size=5),]
data[sample(1:nrow(data),size=5,replace=F),]

data$c1 = sample(c('A','B','O','AB','Others'), size=nrow(data), replace=T)
head(data)
colnames(data)[13]='BType'
data$c1 = sample(c('AA', 'BB'), size=nrow(data), replace=T)

data$c1 = rep(c('AA', 'BB'), size=nrow(data), replace=T)
nrow(data[data$c1 =="AA",])
data
set.seed(255)
smdt = data.frame(stuno=1:5,
                  Korean=sample(60:100, 5),
                  English=sample((5:10)*10, 5),
                  Math=sample(50:100, 5))
smdt


#substring ####
s = "abc,efg,abc"
nchar(s)
toupper(s)
tolower(s)

substr(s,1,5)  # "abc,e"
strsplit(s,',') # "abc" "efg" "abc"
sub('abc','ttt',s) # "ttt,efg,abc"
gsub('abc','ttt',s) # "ttt,efg,ttt"

s
sub(pattern='abc/g', replacement='ttt',s)
# "abc,efg,abc"

d = "first\tsecond\nthird"
print(d)
cat(d)

paste('aaa-bbb','ccc-ddd',sep="**")
paste0('aaa-bbb', 'ccc-ddd')
paste('aaa-bbb','ccc-ddd')

class(data[1:3, '반'])
paste(data[1:3, '반'], collapse='**')
#paste factor를 paste할때는collapse필요

outer(month.abb, 2011:2020, paste, sep='-')
?outer
outer(LETTERS,2010:2020, paste0)
#paste0

grep(pattern='^2.*0$', x=data$학번, value=T)
grep(pattern='^2.*0$', x=data$학번, value=F)
#value=T값출력,value=F행의index출력


#sub(pattern=..) ####
ss="abcdTEGwg HWEf"
sub(pattern='abc/g', replacement='ttt', x=ss)
ss

#,반드시있고(+)a이후에올수있는모든문자
gsub(pattern='[,]+a(.*)', replacement='ttt', x=s)

# install.packages('lubridate')
library(lubridate)

as.Date('2019-03-04 09:00')
dt1 = as.POSIXct('2019-03-04 09:00')
dt1
seq(dt1, as.POSIXct('2019-04-01'), by='day')
seq(dt1, as.POSIXct('2019-04-01'), by='2 hour')

ymd('2019/02/28')
ymd('20190228')
mdy('02282019')
dmy('28022019')

year(dt1)
quarter(dt1)

day(dt1) = 15
dt1

days_in_month(1:12)
ddays(10)
dhours(50)
duration(1000) #seconds
round(as.POSIXct('2019-03-05 11:51:42'), 'min')
round(as.POSIXct('2019-03-05 11:51:02'), 'min')


# for loop ####
for (i in 1:3) {print(i)}
for(r in 1:nrow(data)) 
{if (data[r,'scout']=="") 
    print("None")
  else 
  {print(data[r,'scout'])}}

# while ####

i=0
while(i<10)
{print(i);
  i = i + 1}

i=0
while(TRUE) {
  i = i + 1
  if (i %% 2 == 0)
    next
  if ( i > 10)
    break
  print(i)
}

1:5

# apply #### (when you want to execute all at once)
smdt
smdt[,2:4]
apply(smdt[,2:4], MARGIN=1, FUN=mean)
apply(smdt[,2:4], MARGIN=2, FUN=mean)
apply(smdt[,2:4], MARGIN=2, FUN=quantile)

# lapply ####

apply(smdt[,2:4], MARGIN=2, FUN=mean)
llll = lapply(smdt[,2:4],FUN=mean)
llll
unlist(lapply(smdt[,2:4],FUN=mean))
llll['Korean']

# sapply ####
apply(smdt[,2:4], MARGIN=2, FUN=mean)
sapply(smdt[,2:4], FUN=mean, simplify=T) #알아서margin=2
sapply(smdt[,2:4], FUN=mean, simplify=F) #lapply

# vapply ####
vapply(smdt[,2:4], FUN=mean, FUN.VALUE=1) # int/num만취급
vapply(smdt[,2:4], FUN=mean, FUN.VALUE=10) # same
vapply(smdt[,2:4], FUN=mean, FUN.VALUE='') # error(chr)

# reshape2 ####
library(reshape2)
#가로세로뒤집고싶을때melt->dcast
#한개의row를여러개로풀고싶을때melt

data.frame(no=1:4, year=2016:2019)
runif(16)
round(runif(16), 3)
round(runif(16), 3)*1000
matrix(round(runif(16), 3)*1000, ncol=4)

list(NULL,paste0('Q',1:4))
matrix(round(runif(16), 3)*1000, ncol=4, dimnames=list(NULL,paste0('Q',1:4)))

mtmatrix = matrix(round(runif(16), 3)*1000, ncol=4, dimnames=list(NULL,paste0('Q',1:4)))
dfsum = cbind( data.frame(no=1:4, year=2016:2019),mtmatrix)
dfsum

# melt ####
#(id.vars=year을 첫번째 column으로, 열을 variable컬럼의 row로, data를 value컬럼의 row로)
melt(data=dfsum[,2:6], id.vars="year")
meltsum = melt(dfsum[,2:6], id.vars="year", variable.name = "Sales")
head(meltsum)

# dcast(data, <기준컬럼>~<나열컬럼>, value.var=<키 변수 명>) 
# '~별' 이 기준 컬럼으로 제일 맨 왼쪽에 온다
# 나열컬럼이 열이 된다
# value.var = 행렬의 값을 채울 애들
dcsum= dcast(meltsum, Sales~year, value.var = "value")
dcsum
dfsum

# try this 7-1 ####
# data$group 컬럼에 A조~C조 랜덤으로 160명씩 고르게 분포시키시오.

data$group = sample(rep(paste0(LETTERS[1:3],"조"), times=nrow(data)/3), size=nrow(data))
head(data)
nrow(data[data$group=="A조",])
nrow(data[data$group=="B조",])
nrow(data[data$group=="C조",])

# try this 7-2 ####
# fibonacci.R 파일을 작성하고 console에서 실행하시오.
  
#try this 7-3 ####
# apply를 이용하여 smdt에 1. 과목별 (총)평균점수 행을 추가하고, 2. 총점과 평균 변수(컬럼)을 추가하시오.

#1. 과목별 (총)평균점수 행을 추가
apply(smdt[,2:4], MARGIN=2, FUN=mean)
smdt[nrow(smdt)+1, 2:4] = apply(smdt[,2:4], MARGIN=2, FUN=mean)
smdt[nrow(smdt),1] = "계"
smdt

#2. 총점과 평균 변수(컬럼) 추가
smdt$"total"=apply(smdt[,2:4], MARGIN=1, FUN=sum)
smdt$"mean"=apply(smdt[,2:4], MARGIN=1, FUN=mean)
smdt

# try this 7-4 ####
#2016~2019년 연도별 1월(Jan) ~ 12월(Dec) 매출액 데이터를 `no year Jan Feb … Dec` 형태로 만든 다음, 아래와 같이 출력하시오.
ny = data.frame(no=1:4, year=2016:2019)
ny
sm = matrix(round(runif(n=4 * 12, min=300, max=700),3)*1000, nrow=4, dimnames = list(NULL, month.abb))
sm
salespm = cbind(ny, sm) #sales per month
salespm
yy=melt(data=salespm[,2:14], id.vars="year")
yy
yms = melt(data=salespm[,2:14], id.vars="year", variable.name="month", value.name="saleamt")
yms


for (i in 1:0){
  print(i)
}

# switch ####
switch("color", "color" = "red", "shape" = "square", "length" = 5)

switch("length", "color" = "red", "shape" = "square", "length" = 5)

switch(2,"red","green","blue")

x <- switch(4,"red","green","blue")
x

