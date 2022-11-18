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

discurso <- tolower(a)

discurso <- removeWords(discurso, words = stopwords("spanish"))

discurso <- removeWords(discurso, words = c("hp2pdfmnfa","@iandresrm","va","https://","@",":",
                                            "…","t.co/","👁","@christi11079874","📢","jajajajjaja",
                                            "“","n","cad…","@lafm","plat…",
                                            "…", "indra","dos","día","🇨🇴",
                                            "de","la","aos","el","y","las","nes",
                                            "ser"))

discurso <- removePunctuation(discurso)

discurso <- removeNumbers(discurso)

discurso1 <- Corpus(VectorSource(discurso)) 

letras<- TermDocumentMatrix(discurso1)
letrasmatrix <- as.matrix(letras) 

vector <- rowSums(letrasmatrix) 
Vectorr<- sort(vector, decreasing = T)

view(Vectorr)
Vectorr[1:20]

dataletras <- data.frame(word= names(Vectorr),freq=Vectorr)  

barplot(dataletras[1:10,]$freq, las = 2, names.arg = dataletras[1:10,]$word, 
        col = brewer.pal(n = 8, name = "Set3"), main ="Pabalras mas frecuentes",
        ylab = "Frecuencia de palabras") 

dataletras[1:30, ] %>%
   ggplot(aes(word, freq)) +
   geom_bar(stat = "identity", color = "black", fill = "#87CEFA") +
   geom_text(aes(hjust = 1.3, label = freq))+ 
   coord_flip() + 
   labs(title = "Diez palabras más frecuentes",  x = "Palabras", y = "Número de usos")