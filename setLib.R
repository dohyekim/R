
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

load("data/data.rda")
data

# text mining ####
library(tm)
library(KoNLP)

# Word Cloud ####
library(RColorBrewer)
library(wordcloud)

# 연관성
library(arules); library(igraph); library(combinat)
library(arulesViz); library(visNetwork)

#Naver ####
library(rvest); library(httr); library(stringr); library(dplyr)

# 통계
library(psych)
