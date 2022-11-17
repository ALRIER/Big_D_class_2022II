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

setup_twitter_oauth("6gMch1lkCfn3W5PZho3X4jh8W",#api key
                    "eBosfeWmQVBLQ87WiVMaRXousYRdyOkyhLkvCUzw7ioz0EMCWY",#api secret key
                    "284827529-UENNMA2jVHCRBYwcddd6obAAZvaJ0hUVSapYYmwZ",#acces token
                    "sb1fgjDG9CSugsU5qsWJWkBOvP91FxJmcm7hKCyajrndT")#acces token secret

a<- searchTwitter("cerveza", n=500)
a[1:100]
cerveza<-twListToDF(a)

create_token(app="Clase_big_data",
             consumer_key = "6gMch1lkCfn3W5PZho3X4jh8W",#api key
             consumer_secret = "eBosfeWmQVBLQ87WiVMaRXousYRdyOkyhLkvCUzw7ioz0EMCWY",#api secret key
             access_token ="284827529-UENNMA2jVHCRBYwcddd6obAAZvaJ0hUVSapYYmwZ",#acces token
             access_secret ="sb1fgjDG9CSugsU5qsWJWkBOvP91FxJmcm7hKCyajrndT")#acces token secret

te<-Perfiles_Mkt$`Descripcion Vacante`
