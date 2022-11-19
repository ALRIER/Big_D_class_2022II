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
                                            "ser", "jajaja", "unas", "est", "pack", "todava", "jajaja", "pas", "sal", "ltima", "termin", "qued", "chocolate", "dicen", "mientras", "dijo", "mande", "mano", "leche", "fro", "jaja", "ultra", "estn", "haba"))


discurso <- removePunctuation(discurso)
discurso <- removeNumbers(discurso)
discurso[1:300]
discurso1 <- Corpus(VectorSource(discurso)) 
letras<- TermDocumentMatrix(discurso1)
letrasmatrix <- as.matrix(letras) 
vector <- rowSums(letrasmatrix) 
Vectorr<- sort(vector, decreasing = T)

view(Vectorr)

Vectorr[1:20]

dataletras <- data.frame(word= names(Vectorr),freq=Vectorr)
#findFreqTerms(letras, lowfreq=3) 
#vector <- sort(rowSums(matrix),decreasing=TRUE)
barplot(dataletras[1:10,]$freq, las = 2, names.arg = dataletras[1:10,]$word, 
        col = brewer.pal(n = 8, name = "Set3"), main ="Pabalras mas frecuentes",
        ylab = "Frecuencia de palabras") 


dataletras[1:30, ] %>%
   ggplot(aes(word, freq)) +
   geom_bar(stat = "identity", color = "black", fill = "#87CEFA") +
   geom_text(aes(hjust = 1.3, label = freq))+ 
   coord_flip() + 
   labs(title = "Diez palabras más frecuentes",  x = "Palabras", y = "Número de usos")


dataletras %>%
   mutate(perc = (frec/sum(frec))*100) %>%
   .[1:10, ] %>%
   ggplot(aes(palabra, perc)) +
   geom_bar(stat = "identity", color = "black", fill = "#87CEFA") +
   geom_text(aes(hjust = 1.3, label = round(perc, 2))) + 
   coord_flip() +
   labs(title = "Diez palabras más frecuentes en Niebla", x = "Palabras", y = "Porcentaje de uso")
#nube de palabras sin frecuencias mínimas
wordcloud(
   words = dataletras$word, freq = dataletras$freq,
   max.words = 80, 
   random.order = F, 
   colors=brewer.pal(name = "Dark2", n = 8)
)
#nube de palabras con frecuencias mónimas
wordcloud(words = dataletras$word, freq = dataletras$freq, min.freq = 2,
          max.words=30, random.order=FALSE, rot.per=0.35,  
          colors=brewer.pal(7, "Dark2"), scale=c(3.5,1.25))

sentimientos_beer <- get_nrc_sentiment(a, lang="spanish")

head(sentimientos_beer)

summary<-summary(sentimientos_beer)

wordcloud(words = sentimientos_beer, freq = sentimientos_beer, min.freq = 2,
          max.words=30, random.order=FALSE, rot.per=0.35,  
          colors=brewer.pal(7, "Dark2"), scale=c(3.5,1.25))

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
   horiz = F,
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