# remove variables from memory ####
rm(b)

# factor #####
factor(1)
factor(3, levels=1:5, labels=LETTERS[1:5])


v1 = c(5,3,1)
v1
class(v1) #numeric
v1[1] + v1[3]
summary(v1)
v1[4] = 4
v1
v1[6] = "6"
v1
class(v1)
v1[ c(1,3,5)] = 0
v1
v1[-3]
v1[-(1:3)]
v1[c(1:2, 4)]
names(v1)
names(v1) = c('국어', '영어', '수학', '과학','사회','제2외국어')
names(v1)[1] ='aaa'
v1
names(v1) = LETTERS[1:5]
names(v1) = LETTERS[1:length(v1)]
v1
names(v1) = letters[1:length(v1)]
v1
v1['d']
names(v1) = NULL
v1
length(v1)

#matrix ####
m1 = matrix(c('A1','A2','A3','A4','A5','A6'), nrow=3, ncol=2, byrow=T)
m1
m1 = matrix(c('A','F','G','D','C','B'), nrow=3, ncol=2, byrow=F)
m1

length(LETTERS)
# m2=matrix(LETTERS, ncol=5) --> the number of alphabet:26
m2 = matrix(c(LETTERS,1,2,3,4), nrow=6, byrow=F)
m2

nrow(m2)
ncol(m2)
dim(m2)

colnames(m2) = c('1분단','2분단','3분단','4분단','5분단')
m2
rownames(m2) = c(1:6)
m2
rownames(m2) = c(1:nrow(m2))
m2
length(m2)

m2[ , c(1,3)] #2차원
m2[, '5분단'] #1차원 --> 가로로 나옴
m2

m3 = matrix(1:30, nrow=30/5, byrow=T)
m3
data1 = 1:30
rowcnt = 6
m3 = matrix(data1, ncol=length(data1)/rowcnt, byrow=T)
m3

colnames(m3) = LETTERS[1:ncol(m3)]
rownames(m3) = letters[1:nrow(m3)]
m3
m2
cbind(m2, m3)
rbind(m2, m3)

# trythis ####
factor(1, levels=1:4, labels=c('A','B','O','AB'))

bloodtype=function(number){
  bf = factor(number, levels=1:4, labels=c('A','B','O','AB'))
  return (as.vector(bf))
}
bloodtype(1)

# 1차원 vector와 신규 입력값을 전달 받아 vector에 값을 추가하는 append 함수를 작성하시오.
vec = function(v, new) {
  v[length(v)+1] = new
  return(v)
}
v2 = 1:5
v2=vec(v2, 8)
v2

#숫자로 된 10x20 matrix를 정의하고, 열 이름을 알파벳 대문자순으로, 행 이름을 소문자로 변경하시오.

m4 = matrix(1:200, nrow=10)
m4
colnames(m4)=LETTERS[1:ncol(m4)]
rownames(m4)=letters[1:nrow(m4)]

colnames(m4)[10] = paste(colnames(m4)[10], 10, sep='')
colnames(m4)[20] = paste(colnames(m4)[20], 20, sep='')
# paste0(colnames(m4)[10],10)

# 함수로 만들었을 때 
fnmatrix= function (mtrx,col, val){
 colnames(mtrx)[col] = paste(colnames(mtrx)[col], val, sep='')
 return(mtrx)
}
m4 = fnmatrix(m4,10,10)
m4 = fnmatrix(m4,20,20)
m4
df10 = as.data.frame(m4)
df10
