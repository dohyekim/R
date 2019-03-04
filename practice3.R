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
save(mtx, file="data/meltop100_rmlast.rda") # rda로 저장하는 것은 파일을 쓰는 의미가 아님, 읽을 때 load하면 rad에 있는 변수를 불러옴)

#trythis2 ####
trycsv = read.csv('data/trycsv')
trycsv
save(trycsv, file="data/trycsv.rda")
rm(trycsv) # have to delete it first as it will automatically generated when loaded
load("data/trycsv.rda")
View(trycsv)

#trythis3 ####
tmp = read.fwf('data/temper.txt', header=F, stringsAsFactor=F, width=c(15,4,68,5,1))
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
colnames(middf)

??midwest
# 시험5 전체 아시아계 인구수와, asian 변수를 이용해 `전체 인구 대비 아시아계 인구 백분율` 파생변수(asianpct)를 추가하고, 히스토그램을 그리시오.####

summedasian = sum(middf$asian)
middf$asianpct = middf[,'asian'] / summedasian * 100

histdata = middf[,c('asianpct', 'state')]
hist(histdata$asianpct)

# 시험6 ####
asianperstate= aggregate(data=histdata, asianpct~state, mean)
asianperstate[order(-asianperstate$asianpct),]

# 시험7 아시아계 인구 백분율(asianpct)의 전체 평균을 구하고, 평균을 초과하면 "lg", 그 외는 "sm"을 부여하는 파생변수(asianrate)를 추가하는 코드를 작성하시오. ####

mean(middf$asianpct)
middf$asianrate = ifelse(middf$asianpct >= mean(middf$asianpct),"lg","sm")
head(middf$asianrate)

#시험8 "lg"와 "sm"에 해당하는 지역이 얼마나 되는지 빈도 막대그래프(qplot)을 그려보시오.####
library(ggplot2)
qplot(middf$asianrate)
