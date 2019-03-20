# data ####

data = read.csv('data/성적.csv')
#data = dplyr::rename(data, stuno=학번, cls=반, gen=성별, kor=국어, eng=영어, sci=과학, art=예체, avg=평균, grade=학점)

data = dplyr::rename(data, stuno=학번, cls=반, gen=성별, kor=국어, eng=영어, sci=과학, art=예체)

data = dplyr::rename(data, math=수학)

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
data
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
mpg$fuel = (mpg$cty + mpg$hwy)/2
head(mpg)

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
data=read.csv('data/성적.csv')
data
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

#혹은 rbind
#정수화
for (i in 2:4){
  smdt[,1]  = as.integer(smdt[,])
}
  

#2. 총점과 평균 변수(컬럼) 추가
smdt$"total"=apply(smdt[,2:4], MARGIN=1, FUN=sum)
smdt$"mean"=apply(smdt[,2:4], MARGIN=1, FUN=mean)
smdt
#정수화
smdt$mean = round(smdt$mean)

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

t = c(5,7,2,4,1,55,61,24)
t[order(t)]

smdt[order(smdt$mean, -smdt$Korean),]

t
rev(t)
sort(t)
sort(smdt$mean,decreasing=T)

#mising values ####
t = c(1:5, NA, 7, NA, 9, 10)
m1=m2=m3=matrix(c(1:3,NA,9:3,NA,1:3),nrow=3)

is.na(t) #FALSE FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE

table(is.na(t))
is.na(t)
t[is.na(t)] # NA인 것들만
t[!is.na(t)] # NA가 아닌 것들만
mean(t)
mean(t, na.rm=T)

t=ifelse(is.na(t),0,t)
t
m1
m1[is.na(m1)]=0
m1

m2[is.na(m2[,2]),2] = 55
m2
is.na(m2[,2])

#dplyr ####
install.packages('dplyr')
library('dplyr')

#data$국어 --> data
attach(data)
with(data, mean(math))
detach(data)

data

data = dplyr::rename(data, stuno=학번, cls=반, gen=성별, kor=국어, eng=영어, sci=과학, art=예체, avg=평균, grade=학점)
colnames(data)

head(data)
data = dplyr::rename(data, eng=English, sci=Science, kor=Korean, grade=Grade, art=Art)
data = dplyr::rename(data, cls=class, gen=gender)
data = dplyr::rename(data, class=반)

data

data[data$group=='C조',]
data %>% filter(group=='C조')
data %>% filter(group=='C조' $ math > 90)
# %in% == or
data %>% filter(group %in% c('A조','C조'))

# except 반,영어
data%>% select(-반, -영어)
data %>% filter(math>95) %>%
  select(학번,국어,영어,math)
# %>% \n
data %>%
  filter(math > 95) %>% 
  select(학번, 국어, 영어, math) %>%
  head

# %>%하면 첫번째인자로앞의data가들어간다고볼수있다
data %>% rename(Pass=pass)
mean(data$국어)

#arrange, mutate ####

data %>% arrange(kor)
data %>% arrange(desc(kor))
data %>% arrange(math) %>% head
data %>% arrange(desc(math))%>% head
data %>% arrange(math,kor,eng) %>% head

data = data %>% mutate(subTotal = kor + eng + math)
data = data %>% mutate(subTotal =  kor + eng + math, subMean=round((kor+eng+math)/3))
data = data %>% mutate(subMean=round((kor+eng+math)/3))

data = data %>% mutate(kor_eng = kor + eng) %>% arrange(desc(kor_eng)) %>% head

head(data)

data%>% arrange(math,desc(English)) %>% head

# summarize, group_by ####
mean(data$math)
data %>% mean(math)
data %>% dplyr::summarize(t = mean(math))
data[data$cls=='죽',]
data %>% group_by(cls,gen) %>% 
  summarize(m=mean(math)) 

data %>% group_by(cls) %>% 
  summarize(mean_math=mean(math))
summary(data)

# join ####
dfsum = cbind( data.frame(yno=1:4, year=2016:2019), 
               matrix(round(runif(16), 3) * 1000, ncol=4, dimnames = list(NULL, paste0('Q', 1:4))))
dfsum
sales = cbind( data.frame(no=1:12, year=2016:2019), 
               matrix(round(runif(144), 3) * 100000, ncol=12, dimnames = list(NULL, month.abb)) )
sales

left_join(sales, dfsum, by=c('year'='year'))
left_join(dfsum, sales, by=c('year'='year'))
right_join(sales,dfsum, by=c('year'='year'))

dfsum

inner_join(sales, dfsum, by=c('year'='year', 'no'='yno'))
semi_join(sales, dfsum, by=c('year'='year', 'no'='yno'))

# 없는 값은 NA로
full_join(sales, dfsum, by=c('year'='year', 'no'='yno'))
# 교집합 제외
anti_join(sales, dfsum, by=c('no'='yno'))


#bind_rows, bind_cols ####

topsales4 = sales[1:4,] %>% select(year,Jan,Apr,Jul,Oct)
topsales4

top4 = sales[5:8,] %>% select(1:4, year, Jan, Apr, Jul, Oct) %>%
  rename(yno=no, Q1=Jan, Q2=Apr, Q3=Jul, Q4=Oct)
top4

dfsum
topsales4
top4
bind_rows(dfsum, topsales4)
bind_rows(dfsum, top4)
bind_rows(dfsum, top4, .id='group')

dfsum
top4
# column명 자동으로 중복 방지
bind_cols(dfsum, top4)
# column명 중복됨
cbind(dfsum, top4)
bind_cols(dfsum, top4) %>% select(-yno1, -year1, -Feb)

#trythis 8-1 ####
# mpg데이터에서 차종(class)가 suv, compact인 자동차의 모델과 연비관련 변수만 출력하세요.

library(ggplot2)
mpg %>% filter(class %in% c('suv', 'compact')) %>% 
  select(model, cty, hwy)

#trythis 8-2 ####
#mpg데이터에서 고속도로연비(hwy) 1 ~ 5위에 해당하는 자동차의 데이터를 출력하세요.
a = mpg %>% arrange(desc(hwy))
a[1:5,]

mpg %>% arrange(desc(hwy)) %> %head(5)

#trythis 8-3 ####
mpg$fuel
#회사별로 suv 차들의 통합연비(평균) 구해 1 ~ 5위를 출력하세요.
mpg %>% filter(class=='suv') %>% 
  group_by(manufacturer) %>% 
  summarize(avg=mean(fuel)) %>%
  arrange(desc(avg)) %>%
  head(5)

#trythis 8-4 ####
# 다음과 같이 연료별 가격이 정해져 있을 때, mpg에 fl_price라는 컬럼을 추가하세요.

mpg = as.data.frame(ggplot2::mpg)
mpgprc = data.frame(fl=c('c','d','e','p','r'), type=c('CNG', 'diesel', 'E85', 'Premi', "regular"), price=c(1.33,1.02,0.92,1.99,1.22), stringsAsFactors = F)

mpg = inner_join(mpg, mpgprc, by=c('fl'='fl')) %>% 
  rename(fl_price=price)

inner_join(mpg, mpgprc, by=c('fl'='fl')) %>% 
  rename(fl_price=price) %>% head

# plot ####
data

?points

plot(x=1, y=1)
plot(x=1:10, y=1:10)
plot(sin, -pi, pi * 3)
smdt
plot(smdt$stuno, smdt$Korean)
plot(smdt$stuno, smdt$Korean, col='#0000FF')

str(smdt)
smdt$stuno = as.numeric(smdt$stuno)
str(smdt)

colors()

#pch : point(점)유형
#cex : text/symbol size
#las: label axis style (y축 기준값 모양 - 0: 세로, 1: 가로)
#mar: margin(bottom, left, top, right)
#type:graph type (p, l, b, c, o, s)
#bty: box type(o, L, 7, c, u, ])
#lty: line type(0, 1: solid, 2: dashed, 3: dotted, 4: dotdash, ...)

plot(x = smdt$stuno, y=smdt$Korean,
     col='#0000FF',
     cex=3,
     las=1,
     # type='l',
     xlim=c(0,5.5),
     ylim=c(60,100),
     pch=8,
     xlab='학번', ylab='국어',
     main = '그래프 타이틀'
     )
?type

xl=c(-0.5,5.5)
yl=c(60,100)

plot(x = smdt$stuno, y=smdt$Korean,
     col="#00FF00",
     cex=3,
     pch=8,
     xlim=xl,
     ylim=yl,
     xlab='학번',
     ylab='국어,수학',
     main='우리반 국어/수학 성적')

par(new=T)

plot(x = smdt$stuno, y = smdt$Math,
     col='#FF0000',
     cex=3,
     pch=21,
     xlim=xl,
     ylim=yl,
     xlab='',
     ylab='')

legend('bottomright',
       legend=c('국어','수학'),
       pch=c(8,21),
       col=c('green', 'red'),
       bg='gray')

# barplot data must be one of these: vector, matrix, table (ex. If 'cls' only --> it would be vector type, 'cls','gen' --> it would be either matrix or table)
par(new=F)
library('dplyr')
t = data %>% filter(eng>90) %>%
  select('cls') %>%
  table
nrow(t)
barplot(t,
        border = 'dark blue',
        density=50,
        xlab='학급별 성별',
        ylab='영어',
        legend=rownames(t),
        col=heat.colors(nrow(t))
                )
t = data %>% filter(eng > 90) %>% select('cls', 'gen') %>% table

barplot(t,
          horiz=T,
          # beside = F,
          beside=T,
          border = 'dark blue',
          density = 50,
          angle = 15 + 10*1:2,
          xlab = '학급별 성별', ylab = '영어',
          legend=rownames(t),
          col=heat.colors(nrow(t)),
          xlim=c(0,13),
          las=1,
          cex.names=0.8
        )
#boxplot ####

boxplot(data$Korean)

d = data %>% filter(kor > 90) %>%
  select('cls')
pie(table(d))

#geom_point####

smdt

smdt1 = smdt[1:5,]
smdt1
ggplot() +
  geom_point(data=smdt1,
             aes(x=stuno, y=Korean),
             color='blue', size = 5)

ggplot(data=smdt1) +
  geom_point(
             aes(x=stuno, y=Korean),
             color='blue', size = 5)

ggplot(data=smdt1) +
  geom_point(
    aes(stuno, Korean),
    color='blue', size = 5)


ggplot() +
  geom_point(data=smdt,
             aes(x=stuno, y=Korean, color='kor'),
             size = 5)

ggplot() +
  geom_point(data=smdt,
             aes(x=stuno, y=Korean, color=stuno),
             size = 5)
ggplot() +
  geom_point(data=smdt,
             aes(x=stuno, y=Korean, color=stuno),
             size = 3)

ggplot() +
  geom_point(data=smdt,
             aes(x=stuno, y=Korean, color=stuno, size=5))

library('dplyr')
d = data %>% filter(stuno >= 30000)

ggplot(d, aes(cls, kor)) +
  geom_point(aes(color=cls, size=kor), 
             alpha=0.3)

# geom_line() ####
head(mpg)
ggplot2::mpg
colnames(mpg)
d2 = mpg %>% group_by(manufacturer, displ) %>% 
  summarise(m1 = mean(cty), m2 = mean(hwy))
d2


ggplot(d2, aes(x=displ)) + 
  geom_line(aes(y=m1, color='cty'))

ggplot(d2, aes(x=displ)) + 
  geom_line(aes(y=m1, color='cty')) + 
  geom_line(aes(y=m2, color='hwy'), size=1) 

ggplot(d2, aes(x=displ)) + 
  geom_line(aes(y=m1, color='cty')) + 
  geom_line(aes(y=m2, color='hwy'), size=1) +
  scale_colour_manual("", breaks = c("cty", "hwy"),
                      values = c("red", "blue"))

g2 = ggplot(d2, aes(x=displ)) + 
  geom_line(aes(y=m1, color='cty')) + 
  geom_line(aes(y=m2, color='hwy'), size=1) +
  scale_colour_manual("", breaks = c("cty", "hwy"),
                      values = c("red", "blue")) +
  xlab("x축") +
  xlim(1, 8) +
  scale_y_continuous("y축", limits = c(5, 45))
g2
# ylab('y축') + ylim(5,45) == scale_y_continuous('y축', limits = c(5,45))

ggplot(d2, aes(x=displ)) + 
  geom_line(aes(y=m1, color='cty')) + 
  geom_line(aes(y=m2, color='hwy'), size=1) +
  scale_colour_manual("", breaks = c("cty", "hwy"),
                      values = c("red", "blue")) +
  xlab("x축") +
  xlim(1, 8) +
  scale_y_continuous("y축", limits = c(5, 45)) +
  labs(title = '타이틀', subtitle = '서브 타이틀') 

# geom_histogram ####
# x축은 한 개

ggplot(mpg, aes(displ)) +
  geom_histogram(aes(fill=class), 
                 binwidth = .3,     # 또는  bins = 5 (5개)
                 col='black',       # line color
                 size=.1) +         # line size
  labs(title = 'Title', subtitle = 'Sub Title')


ggplot(mpg, aes(displ)) +
  geom_histogram(aes(fill=class),
                 binwidth = .3,
                 col='black',
                 size=.1) +
  labs(title = 'Title', subtitle = 'Sub Title')

# geom_bar ####
# x축은 한 개

ggplot(mpg, aes(manufacturer)) +
  geom_bar(aes(fill=class), #fill ==> 기준이 되는 값(class별)
           width = 0.5) +
  theme(axis.text.x = element_text(angle=45,       # 글씨의 기울기
                                   vjust=0.6)) +   # 글씨의 하단 맞춤(띄우기)
  scale_fill_discrete(name = "class") +      # legend
  labs(title = 'Title', subtitle = 'Sub Title')

ggplot(mpg, aes(manufacturer)) +
  geom_bar(aes(fill=class),
           width = 0.5) +
  theme(axis.text.x = element_text(angle=45, vjust=0.6)) +
  scale_fill_discrete(name='Class') +
  labs(title = 'Bar Title', subtitle = 'Bar Subtitle')


# geom_density() ####

ggplot(mpg, aes(cty)) +
  geom_density(aes(fill=factor(cyl)), alpha=0.8) + #밀도는 연속형이 아니기 때문에 factor여야 함(수치가 아닌 밀도)
  labs(title="밀도그래프", subtitle = "실린더수에 따른 시내연비의 밀도그래프",
       caption="Source: ggplot2::mpg",
       x = "도시 연비",
       fill = "실린더수")

mpg$cyl


ggplot(data, aes(cls)) +
  geom_bar(aes(fill=grade)) +
  labs(title="학점 그래프", subtitle = '반별 학점',
       caption="Grade",
       x = '반',
       fill='학점')


# install.packages('gridExtra')
library('gridExtra')
g3 = ggplot(mpg, aes(manufacturer)) +
  geom_bar(aes(fill=class),
           width = 0.7) +
  theme(axis.text.x = element_text(angle=45,
                                   vjust=0.6)) +
  labs(title = 'Title', subtitle = 'Sub Title')

g3 

g4 = ggplot(mpg, aes(cty)) +
  geom_density(aes(fill=factor(cyl)), alpha=0.8) +
  labs(title="밀도그래프", subtitle = "실린더수에 따른 시내연비의 밀도그래프",
       caption="Source: ggplot2::mpg",
       x = "도시 연비",
       fill = "실린더수")

g4

x = ggplot(mpg, aes(cty)) 
x = x + geom_density(aes(fill=factor(cyl)), alpha=0.8) +
  labs(title="밀도그래프", subtitle = "실린더수에 따른 시내연비의 밀도그래프",
       caption="Source: ggplot2::mpg",
       x = "도시 연비",
       fill = "실린더수")
x

g2

grid.arrange(g4, g3, ncol=2)

grid.arrange(g4, g3, nrow=2)

grid.arrange(g2, g3, g4, nrow=2)

x = grid.arrange(g2, ncol=1)
x
y = grid.arrange(g3, g4, ncol=2)
grid.arrange(x,y)

#시각화 try1 ####
# mpg데이터에서 연도별 배기량에 따른 도시/고속도로
# 연비를 꺽은선으로 그리시오.
# (단, 2008년은 굵은 선으로 표현하시오)

mpg = mpg %>% group_by(year,displ) %>% 
  summarise(cty = mean(cty), hwy = mean(hwy))
head(mpg)

mpg_1999 = mpg[mpg$year == 1999, ]
mpg_2008 = mpg[mpg$year == 2008, ]

ggplot() + 
  geom_line(data = mpg_1999, aes(x=displ, y=cty, color='1999 cty')) + 
  geom_line(data = mpg_1999, aes(x=displ, y=hwy, color='1999 hwy')) +
  geom_line(data = mpg_2008, aes(x=displ, y=cty, color='2008 cty'), size=2) +
  geom_line(data = mpg_2008, aes(x=displ, y=hwy, color='2008 hwy'), size=2) +
  xlab("배기량(cc)") +
  ylab("연비(M/h)") +
  labs(shape="year", title = '도시/고속도로 연비', subtitle = '(굵은 선은 2008년)')+
  scale_color_discrete(name="year")
  
#시각화 try2 ####
# data(성적.csv) 데이터에서 국어 성적이 80점 이상인
# 학생들의 수를 성비가 보이도록 학급별로 막대그래프를 그리시오.
save(data, file="data/data.rda")
data


stukor = data[data$kor>=80,]

ggplot(stukor, aes(cls)) +
  geom_bar(aes(fill=gen),
           width=0.5) +
  scale_fill_discrete(name="성별") +
  labs(title='국어 우수 학생', subtitle='80점 이상') + 
  xlab("학급") + ylab('학생수')

#시각화 try3 ####
# 국어 성적이 95점 이상인 학생들의
# 점수별 밀도그래프를 그리시오.

stukorA = data[data$kor>=95,]
stukorA

ggplot(stukorA, aes(kor)) +
  geom_density(aes(fill=factor(cls)), alpha=0.4) +
  scale_fill_discrete(name="반") +
  labs(title='반별 국어 우수 학생', subtitle='국어 성적 A+') + 
  xlab("성적") + ylab('밀도')

#시각화 try4 ####
# midwest데이터에서 전체인구와
# 아시아계 인구의 관계를 알아보기 위한
# 그래프를 그리시오.
# (단, 전체인구는 50만명 이하,
#   아시아계인구는 1만명 이하만 표시되게)

ggplot(data=smdt1) +
  geom_point(
    aes(x=stuno, y=Korean),
    color='blue', size = 5)

colnames(midwest)

ggplot() +
  geom_point(data=smdt,
             aes(x=stuno, y=Korean),
             color='blue', size = 5)

save(midwest, file="data/midwest.rda")
library(dplyr)
asiatot = midwest %>% filter(poptotal <= 500000 && popasian <= 10000) %>% select(county, state,poptotal, popasian)
asiatot

library(ggplot2)

graph_1 = ggplot(asiatot) +
  geom_point(aes(x=poptotal, y=popasian), color="blue", alpha=0.3) +
    xlab("아시아 인구") +
    ylab("전체 인구") +
    labs(title = '아시아 인구 분포') 
a
graph_2 = ggplot(asiatot) +
  geom_point(aes(x=state, y=poptotal, color="전체 인구"),alpha=0.3) +
  geom_point(aes(x=state, y=popasian, color="아시아 인구"),alpha=0.3) +
  xlab("주(state)") +
  ylab("전체 인구") +
  scale_color_discrete(name="인구") +
  labs(title = '주별 아시아 인구 분포') 

graph_2
library(gridExtra)
grid.arrange(graph_1, graph_2, ncol=1)

ggplot(d, aes(cls, kor)) +
  geom_point(aes(color=cls, size=kor), 
             alpha=0.3)



# Choropleth Map ####


library(tibble)
library(ggiraphExtra)
library(ggplot2)
library(dplyr)

head(USArrests)
str(USArrests)
rownames(USArrests)

# install.packages('maps')
# install.packages('mapproj')
usmap = map_data('state')
head(usmap)
chodata = rownames_to_column(USArrests, var='state')
chodata$state = tolower(chodata$state)
head(chodata)

chodata

ggChoropleth(data=chodata,
             aes(fill=Murder, map_id=state),
             map = usmap,
             title = '..',
             reverse = F,
             interactive = T)

ggChoropleth(data = chodata,
             aes(fill=Assault, map_id = state),
             map = usmap,
             title='US Assault',
             reverse = F,
             interactive = T)

ggChoropleth(data = chodata,
              aes(fill=Murder, map_id = state),
              map = usmap,
              title='US ,Murder',
              reverse = F,
              interactive = T)

ggChoropleth(data = chodata,
              aes(fill=UrbanPop, map_id = state),
              map = usmap,
              title='US UrbanPop',
              reverse = F,
              interactive = T)
  
ggChoropleth(data = chodata,
              aes(fill=Rape, map_id = state),
              map = usmap,
              title='US Rape',
              reverse = F,
              interactive = T)



# ggplot() + geom_map() ####
library(ggiraph)
library(stringi)
library(ggplot2)
library(dplyr)

ggplot(chodata, aes(map_id = state)) +
  geom_map(aes(fill = Murder), map = usmap) +
  expand_limits(x = usmap$long, y = usmap$lat) +
  labs(title = "USA Murder", fill='살인') +
  scale_fill_gradient2('살인', low="blue")

# Tooltop ####
tooltips = paste0(
  sprintf("<p><strong>%s<strong></p>", as.character(chodata$state)),
  '<table>',
  '  <tr>',
  '    <td>인구(만)</td>',
  sprintf("<td>%.0f</td>", chodata$UrbanPop * 10),
  '  </tr>',
  '  <tr>',
  '    <td>살인</td>',
  sprintf('<td>%.0f</td>', chodata$Murder),
  '  </tr>',
  '  <tr>',
  '    <td>폭력</td>',
  sprintf('<td>%.0f</td>', chodata$Assault),
  '  </tr>',
  '</table>' )

onclick = sprintf("alert(\"%s\")", as.character(chodata$state))



ggplot(chodata, aes(data = Murder, map_id = state)) +
  geom_map_interactive(
    aes(fill = Murder,
        data_id = state,
        tooltip = stringi::stri_enc_toutf8(tooltips),
        onclick = onclick),
    map = usmap) +
  expand_limits(x = usmap$long, y = usmap$lat) +
  scale_fill_gradient2('value', low="red") +
  labs(title = "USA Murder") -> gg_map

gg_map

ggplot(chodata, aes(data = Assault, map_id = state)) +
  geom_map_interactive(
    aes(fill = Assault,
        data_id = state,
        tooltip = stringi::stri_enc_toutf8(tooltips),
        onclick = onclick),
    map = usmap) +
  expand_limits(x = usmap$long, y = usmap$lat) +
  scale_fill_gradient2('value', low="red") +
  labs(title = "USA Assault") -> gg_map_2

gg_map = ggiraph(code = print(gg_map))
gg_map
girafe(ggobj = gg_map)

grid.arrange(gg_map, gg_map_2)

gg_map

ggiraph(code = print(gg_map))
girafe(ggobj = gg_map)


# kormap ####
install.packages('devtools')

devtools::install_github("cardiomoon/kormaps2014")
rm(tbc)

tbc
library(ggiraph)
library(stringi)
library(ggplot2)
library(dplyr)
library(kormaps2014)

setLib = function() {
  library(ggiraph)
  library(stringi)
  library(ggplot2)
  library(dplyr)
  library(kormaps2014)
  library(ggiraphExtra)
  }
setLib()
kormap1
tbc
library(kormaps2014)
devtools::install_github("cardiomoon/kormaps2014")

install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

# window에서 필요 ####
# kdata = changeCode(korpop1)
# kmap = changeCode(kormap1)

kdata = korpop1
kdata = kdata %>% rename(pop =총인구_명)
kdata = kdata %>% rename(area =행정구역별_읍면동)
# kdata$area = stringi::stri_enc_toutf8(kdata$area)
# rm(kdata)

save(kdata, file="data/kdata.rda")

# kormap1$name = stringi::stri_enc_toutf8(kormap1$name)

# 지도 그리기 ####
kkdata = changeCode(kdata)
head(kmap)
head(kormap1)
ggChoropleth(data=kdata, 
             aes(fill = pop, 
                 map_id = code,
                 tooltip = area),
             map = kormap1,
             interactive = T)
head(kkdata$code)
colnames(kdata)
head(tbcc$code)


head(kkdata$area)
head(tbcc$name)

head(kkdata$pop)
head(tbcc$NewPts)

ggplot(kdata, aes(data = pop, map_id = code)) +
  geom_map( aes(fill = pop), map = kormap1) + 
  expand_limits(x = kormap1$long, y = kormap1$lat) +
  scale_fill_gradient2('인구', low='darkblue') +
  xlab('경도') + ylab('위도') + 
  labs(title="시도별 인구")


#plotly ####
install.packages('plotly')

head(data)
t = ggplot(data, aes(eng, kor)) +
  geom_point(aes(color=eng, size=kor), alpha=0.3)
ggplotly(t)

last_plot()

pp = ggplot(stukor, aes(cls)) +
  geom_bar(aes(fill=gen),
           width=0.5) +
  scale_fill_discrete(name="성별") +
  labs(title='국어 우수 학생', subtitle='80점 이상') + 
  xlab("학급") + ylab('학생수')
ggplotly(pp)

head(data)

qq = ggplot() + 
  geom_line(data = mpg_1999, aes(x=displ, y=cty, color='1999 cty')) + 
  geom_line(data = mpg_1999, aes(x=displ, y=hwy, color='1999 hwy')) +
  geom_line(data = mpg_2008, aes(x=displ, y=cty, color='2008 cty'), size=2) +
  geom_line(data = mpg_2008, aes(x=displ, y=hwy, color='2008 hwy'), size=2) +
  xlab("배기량(cc)") +
  ylab("연비(M/h)") +
  labs(shape="year", title = '도시/고속도로 연비', subtitle = '(굵은 선은 2008년)')+
  scale_color_discrete(name="year")

ggplotly(qq)

#dygraphs ##########

install.packages('dygraphs')
library(dygraphs)
library(xts)

economics
head(economics)

unemp = xts(economics$unemploy, order.by = economics$date)
dygraph(unemp)

dygraph(unemp) %>% dyRangeSelector()

savert = xts(economics$psavert, order.by = economics$date)
dygraph(savert)
unemp2 = xts(economics$unemploy / 1000, order.by=economics$date)
pu = cbind(savert, unemp2)
colnames(pu) = c('unemploy', 'savert')
dygraph(pu) %>% dyRangeSelector()


# 지도시각화 trythis1 ####
head(chodata)

ggChoropleth(data=chodata,
             aes(fill=c(Murder,Assault, UrbanPop, Rape), map_id=state),
             map = usmap,
             reverse = F,
             interactive = T)

#지도시각화 trythis2 ####
# 
# 미국 범죄율의 Rape부분을 단계 구분도로 작성하시오.
# (단, 툴팁은 그림과 같이 표현하고, 
#   클릭시 해당 state의 wikipedia 페이지를
#   보이도록 HTML로 저장하시오)
# http://en.wikipedia.org/wiki/wisconsin

usmap = map_data('state')
chodata = rownames_to_column(USArrests, var='state')
chodata$state = tolower(chodata$state)
head(chodata)

rptips = paste0(
  sprintf("<p><strong>%s<strong></p>", as.character(chodata$state)),
  '<table>',
  '  <tr>',
  sprintf('    <td>%s만</td>', paste0(round(chodata$Rape),'/',((chodata$UrbanPop)*10)))
)

onclick = sprintf('window.open("http://en.wikipedia.org/wiki/%s")',as.character(chodata$state))
onclick


# window.open("https://www.w3schools.com");
rp = ggplot(chodata, aes(data = Rape, map_id = state)) +
  geom_map_interactive(
    aes(fill = Rape,
        data_id = state,
        tooltip = stringi::stri_enc_toutf8(rptips),
        onclick = onclick),
    map = usmap) +
  expand_limits(x = usmap$long, y = usmap$lat) +
  scale_fill_gradient2('Rape', low="blue", high='red') +
  labs(title = "USA Rape")


ggiraph(code = print(rp))
  
# 지도시각화 trythis3 ####

# 시도별 결핵환자수(kormaps::tbc)를
# 단계 구분도로 작성하시오.(우리나라)
# (단, 환자수는 2006년부터 2015년 총합,
#   NA인 지역은 0으로 표시할 것)
rm(tbc)
tbc
tbc = changeCode(tbc)

head(tbc)

tbc$name
rm(tbc)
tbc

tbc$NewPts = ifelse(is.na(tbc$NewPts), '0', tbc$NewPts)
temptbc = tbc %>%select(code, name, year, NewPts) %>% filter(as.numeric(year) >=2006) %>%
  group_by(code, name) %>%
  summarise(NewPts = sum(as.numeric(NewPts)))

tbc %>% group_by(name) %>% summarise(name1 = mean(name))

ggChoropleth(data=temptbc, 
             aes(fill = NewPts, 
                 map_id = code, 
                 tooltip = name),
             title="시도별 결핵 환자수",
             map = kormap1,
             interactive = T) +
labs(fill="환자수")

library(stringi)
tooltip = stringi::stri_enc_toutf8(tooltips),
tbc$name
ggChoropleth(data=chodata,
             aes(fill=Murder, map_id=state),
             map = usmap,
             title = '..',
             reverse = F,
             interactive = T)

head(tbc)
rm(tbc)
tbc
tbc$NewPts = ifelse(is.na(tbc$NewPts), 0, tbc$NewPts)
str(tbc)

y = tbc$year
y
yy = as.character(y)
yy
yyy = as.numeric(yy)
yyy
temptbc = tbc %>%select(code, name, year, NewPts) %>% 
                  filter(as.numeric(as.character(year)) >=2006) %>%
                  group_by(code, name) %>%
                  summarise(pts = sum(NewPts))

temptbc = tbc %>%select(code, name, year, NewPts) %>% 
  filter(year %in% c(2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015)) %>%
  group_by(code, name) %>%
  summarise(pts = sum(NewPts))

temptbc

ggChoropleth(data=temptbc, 
             aes(fill = pts, 
                 map_id = code, 
                 tooltip = name),
             title="시도별 결핵 환자수",
             map = kormap1,
             interactive=T)


# sql ##########

# install.packages('sqldf')
library(sqldf)
sqldf("select * from data")
data2 = sqldf("select cls, avg(kor) koravg from data group by cls")
data2
# install.packages('RMySQL')
library(RMySQL)
# mysql ##########

drv = dbDriver("MySQL") #database를 연결해주는 bridge

#db와 연결
conn = dbConnect(drv, host='127.0.0.1', port=3307, dbname='melondb', user='dooo', password='1234')

#한글설정
# dbGetQuery(conn, "SHOW VARIABLES LIKE 'character_set_%';")
# options(encoding='UTF-8')
# dbSendQuery(conn, 'set character set utf8')   # set utf-8


dbListTables(conn)

# query문 하나만 실행하고 싶을 때
dbSendQuery(conn, 'set character set utf8')


# query문 여러개 실행하고 싶을 때 
rsdf = dbGetQuery(conn, "select * from MS_Song limit 5")
rsdf = changeCode(rsdf)

rsdf
dbGetQuery(conn, "update Song set title='선물1' where songno = '30514366'")

# Transaction
dbBegin(conn);
dbGetQuery(conn, "update Song set title='선물1' where songno = '30514366'");
dbRollback(conn) 
dbCommit(conn)


# close 필수 (#show processlist 확인하기)
dbDisconnect(conn)

#마지막에!! 한 번만 !!
# unload하면 expired돼서 다시 연결 못함 (Ctrl+Shift+F10하기 전까지는)
dbUnloadDriver(drv)
dbGetQuery(conn, "select * from MS_Song limit 5")


# sql 장르/랭킹 ###########

# drv = dbDriver("MySQL")
# conn = dbConnect(drv, host='127.0.0.1', port=3307, dbname='melondb', user='dooo', password='1234')
temptbl = dbGetQuery(conn, "select rank, genre from Song_Rank sr inner join MS_Song s on sr.song_no = s.song_no limit 99;")
temptbl

ggplot(temptbl, aes(genre, rank)) +
  geom_point(
             aes(color=genre, size=-rank),
             alpha=0.3)
ggplot() + geom_point(data=temptbl, aes(x=genre, y=rank))

# 시험2 ####

#(1) 학생 수를 성비가 보이도록 학급별로 막대그래프 ####
data
stuMath = data %>% filter(math >= 90) %>% select(stuno, cls, gen, math)
stuMath

ggplot(stuMath, aes(cls)) +
  geom_bar(aes(fill=gen),
           width=0.5) +
  scale_fill_discrete(name="성별") +
  labs(title='수학 우수 학생', subtitle='90 
       
       00점 이상') + 
  xlab("학급") + ylab('학생수')

#(2) 학급별 밀도 그래프 ####
data
stuMath = data %>% filter(math >= 90) %>% select(stuno, cls, gen, math)
stuMath

ggplot(stuMath, aes(math)) +
  geom_density(aes(fill=factor(cls)), alpha=0.4) +
  scale_fill_discrete(name="반") +
  labs(title='학급별 수학 우수 성적') + 
  xlab("성적") + ylab('밀도')

