load('data/data.rda')

library(ggiraph)
library(stringi)
library(ggplot2)
library(dplyr)
library(kormaps2014)
library(ggiraphExtra)

kdata = korpop1
kdata = kdata %>% rename(pop =총인구_명)
kdata = kdata %>% rename(area =행정구역별_읍면동)

library(plotly)
library(dygraphs)
library(xts)
library(gridExtra)
library(tibble)

usmap = map_data('state')


