
# data.frame ####

# 2차원 Vector & 각 column별 다른 class!!
# data.frame(컬럼명=데이터, 컬럼명=데이터, ...)
df1 = data.frame(column1=11:15, column2=LETTERS[1:5])
df1
class(df1)
str(df1)

data
df2 = data[1:10, 1:6]
df2
class(data)
df3 = data[1:10, c(1:3, 7,8)]
df3
cbind(df2, df3)
df4 = data[10:19, 1:6]
df4
rbind(df4, df2)


#list ####
lst1 = list(a=1:3, b=4:6)
lst1
lst1$a
str(lst1)

lst2 = list(a=1:3, b=c(4,'5','6',7,8))
lst2
str(lst2)
names(lst2)

lst3=list(1:3, LETTERS[1:3], c(2.5, 4.5, 3.7))
lst3
str(lst3)
names(lst3)

lst3
unlist(lst3)

lst1
unlist(lst1)

# class ####
s = "123"
s
i=as.numeric(s)
i
as.character(i)

m4
str(m4)
# int [1:10, 1:20] 1 2 3 4 5 6 7 8 9 10 ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:10] "a" "b" "c" "d" ...
# ..$ : chr [1:20] "A" "B" "C" "D" ...
class(m4)
m4df = as.data.frame(m4)
str(m4df)
#'data.frame':	10 obs. of  20 variables:
# $ A  : int  1 2 3 4 5 6 7 8 9 10
# $ B  : int  11 12 13 14 15 16 17 18 19 20
# $ C  : int  21 22 23 24 25 26 27 28 29 30
# ...
class(m4df)
data$수학
length(data$수학)
tbl =table(data$수학)
tbl
# 25점은 5명
length(tbl)
dft = as.data.frame(tbl)
dft

1:5
as.factor(1:5)
