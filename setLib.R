
library(ggiraph)
library(stringi)
library(ggplot2)
library(dplyr)
library(kormaps2014) #changeCode
library(ggiraphExtra)
# 
# kdata = korpop1
# kdata = kdata %>% rename(pop =총인구_명)
# kdata = kdata %>% rename(area =행정구역별_읍면동)

library(plotly)
library(dygraphs)
library(xts)
library(gridExtra)
library(tibble)
library(stringi)
# usmap = map_data('state')

library(sqldf)
library(RMySQL)
# 
options(encoding = 'utf-8')
data = read.csv("data/성적.csv")
data = dplyr::rename(data, stuno=학번, cls=반, gen=성별, kor=국어, eng=영어, math=수학, sci=과학, art=예체)

# text mining ####
library(tm)
library(KoNLP)

# Word Cloud ####
library(RccolorBrewer)
library(wordcloud)

# 연관성
library(arules); library(igraph); library(combinat)
library(arulesViz); library(visNetwork)

#Naver ####
library(rvest); library(httr); library(stringr); library(dplyr)
