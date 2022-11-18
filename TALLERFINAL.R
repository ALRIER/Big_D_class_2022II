pkg <- function(pkg){
   new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
   if (length(new.pkg)) 
      install.packages(new.pkg, dependencies = TRUE)
   sapply(pkg, require, character.only = TRUE)
}

packages <- c("tidyverse","raster","sf","ggspatial","cluster","factoextra",
              "NbClust","tidyr","forecast","semTools","corrplot",
              "corrr","haven","psych","dplyr","lavaan","readr","cvms","tm",
              "NLP","SnowballC","RColorBrewer","wordcloud","wordcloud2",
              "RefManageR","bibliometrix","GGally","quanteda","ggplot2",
              "ggpubr","Factoshiny","syuzhet","RColorBrewer","tokenizers",
              "stringr","sentimentr","stringi","stopwords","twitteR",
              "mscstexta4r","plyr","psych","corrr","latticeExtra",
              "semPlot","lavaan","readr","lme4","sjPlot","gvlma","Rcmdr",
              "tidymodels","caret","lmtest","gapminder","png","rtweet","knitr")

pkg(packages)

setup_twitter_oauth("6gMch1lkCfn3W5PZho3X4jh8W",
                    "eBosfeWmQVBLQ87WiVMaRXousYRdyOkyhLkvCUzw7ioz0EMCWY",
                    "284827529-UENNMA2jVHCRBYwcddd6obAAZvaJ0hUVSapYYmwZ",
                    "sb1fgjDG9CSugsU5qsWJWkBOvP91FxJmcm7hKCyajrndT")

a<- searchTwitter("cerveza", n=300)
a[1:300]
cerveza<-twListToDF(a)
b<- cerveza %>% filter(isRetweet=="FALSE")
te<-b$text

tokens<-tokens(te,what = "word",remove_punct = TRUE,remove_symbols =TRUE,remove_numbers =TRUE,remove_url =TRUE,remove_separators =TRUE,split_hyphens =TRUE)
text <- gsub("@\\w+", "", tokens)
text <- gsub("https?://.+", "", text)
text <- gsub("\\d+\\w*\\d*", "", text)
text <- gsub("#\\w+", "", text)
text <- gsub("[^\x01-\x7F]", "", text)
text <- gsub("[[:punct:]]", " ", text)

text <- gsub("\n", " ", text)
text <- gsub("^\\s+", "", text)
text <- gsub("\\s+$", "", text)
text <- gsub("[ |\t]+", " ", text)

x = gsub("rt", "", text)

x = gsub("@\\w+", "", x)

x = gsub("[[:punct:]]", "", x)

x = gsub("[[:digit:]]", "", x)

x = gsub("http\\w+", "", x)

x = gsub("[ |\t]{2,}", "", x)

x = gsub("^ ", "", x)

x = gsub(" $", "", x)

a<-gsub("[^\x01-\x7F]", "", x)

sentimientos_beer <- get_nrc_sentiment(a, lang="spanish")

head(sentimientos_beer)

summary<-summary(sentimientos_beer)

barplot(
   colSums(prop.table(sentimientos_beer[, 1:8])),
   space = 0.2,
   horiz = F,
   las = 1,
   cex.names = 0.7,
   col = brewer.pal(n = 8, name = "Set3"),
   main = "8 diferentes emociones",
   sub = "Emociones",
   xlab="emociones", ylab = NULL)

barplot(
   colSums(prop.table(sentimientos_beer[, 9:10])),
   space = 0.2,
   horiz = T,
   las = 1,
   cex.names = 0.7,
   col = brewer.pal(n = 3, name = "Set3"),
   main = "Sentimiento positivo y negativo",
   sub = "Sentimientos",
   xlab="emociones", ylab = NULL)

palabras_tristeza <- a[sentimientos_df$sadness> 0]
palabras_tristeza_orden <- sort(table(unlist(palabras_tristeza)), decreasing = TRUE)
head(palabras_tristeza_orden, n = 13)

sentimientos_valencia <- (sentimientos_df$negative *-1) + sentimientos_df$positive
simple_plot(sentimientos_valencia)