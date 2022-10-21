pkg <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("tidyverse","raster","sf","ggspatial","cluster","factoextra",
              "NbClust","tidyr","forecast","semPlot","semTools","corrplot",
              "corrr","haven","psych","dplyr","lavaan","readr","cvms","tm",
              "NLP","SnowballC","RColorBrewer","wordcloud","wordcloud2",
              "RefManageR","bibliometrix","GGally","quanteda","ggplot2",
              "ggpubr","Factoshiny","syuzhet","tm","RColorBrewer","tokenizers",
              "stringr","sentimentr","stringi","stopwords","twitteR",
              "mscstexta4r","plyr","corrplot","psych","corrr","latticeExtra",
              "semPlot","lavaan","readr","lme4","sjPlot","gvlma","Rcmdr",
              "tidymodels","caret","lmtest", "rtweet")

pkg(packages)
# Clase 20 de octubre 


#stringr--------------------

library(stringr)

#Limpiza de textos: esto quita espacios

str_trim(" Hola, esto es una prueba ")

#Agregar 0s

str_pad("793", width= 5, side= "left", pad="0")

#Buscar algo en un vector.

Amigos= c("Pedro", "Manuel", "Juan", "Camilo")

Amigoss= c("Pedroo", "Manuell", "Juann", "Camiloo")

AAmigos=as.data.frame(Amigos, Amigoss)

S=AAmigos$Amigos

str_detect(S, "Ca")  #deecta un valor dentro de un vector (contro F sofisticado)

#remplazar un valor

amigos=str_replace(Amigos, "Pedro", "Pedrito")

#mayusculas

str_to_upper(Amigos)

#minusculas

str_to_lower(Amigos)

#conteo de elementos

str_length(Amigos)

#str_c -> concatenar elementos.

aMigos=str_c(amigos, collapse = ", ")

#Extrae un subcaracter desde la posición 7 a la 13

str_sub(string=aMigos, start = 7, end = 13)

#Identificación de patrones

#regexr.com -> Identificación de patrones completos de texto

str_extract(string = amigos, pattern = "[aeiou]")

str_extract(string = amigos, pattern = "(Pedrito)")

#al menos 1 vocal en las palabras identificadas. 

str_subset(string = amigos, pattern = "[aeiou]")

#contar número de vocales de algun patron elegido en un vector

str_count(string = amigos, pattern = "[aeiou]")

#Detecta el patrón elegido en un dataframe. 

str_detect(string = amigos, pattern = "[aeiou]")

#Para asignar el nombre de una varable como
#columna a un mismo dataframe y poder trabajar sobre él.

autoasignado=variable %>%
   rownames_to_column(var = "nombre de la variable")

#ejemplo

mtcarss=mtcars %>% rownames_to_column(var="Model")

#asignar un id al nombre de columna para trabajarlos como id

mtcarsid=mtcars %>% rowid_to_column(var="Model")

#ejemplo

mtcarss %>% filter(str_detect(string = Model, pattern= "(erc)")) #Remplazar por lo que se quiera definir. 

str_replace(string = amigos, pattern = "[aeiou]",
            
            replacement = "primera_vocal")

#separar elementos de un vector. 

new=str_split(string = amigos, pattern = ",")


#call my Api Key
create_token(app="ClasII",
             consumer_key = "DP7F7o2r8bS5hophlgGdi9Kqd",#api key
             consumer_secret = "OQcWOdJG2JqAa8370w5Zu0UseQHu3QM7ChJ9xUTNTXmbAMzGWc",#api secret key
             access_token ="284827529-LORYnWAHxeYBUpm3PqnQ3EqD5JCa46jfVaSFnv0F",#acces token
             access_secret ="TOoNhDxMcSnxlYBguc7xyIK4bAABnSwoSbiFuFRoERnps")#acces token secret

#Now i will make any call from the tweeter API
Petro <- get_timeline(user = "@petrogustavo", n = 500, parse = TRUE, check = FALSE)
#i will extract the text form the dataframe 
texto<-Petro$text
texto[1:10]
#Now i will split the text in words to analyse each one of them separated
tokens<-tokens(texto,what = "word",remove_punct = TRUE,remove_symbols =TRUE,remove_numbers =TRUE,remove_url =TRUE,remove_separators =TRUE,split_hyphens =TRUE)
#I will celan the words 
# Remove mentions, urls, emojis, numbers, punctuations, etc.
text <- gsub("@\\w+", "", tokens)
text <- gsub("https?://.+", "", text)
text <- gsub("\\d+\\w*\\d*", "", text)
text <- gsub("#\\w+", "", text)
text <- gsub("[^\x01-\x7F]", "", text)
text <- gsub("[[:punct:]]", " ", text)
# Remove spaces and newlines
text <- gsub("\n", " ", text)
text <- gsub("^\\s+", "", text)
text <- gsub("\\s+$", "", text)
text <- gsub("[ |\t]+", " ", text)
# Put the data to a new column
data_fix["fix_text"] <- text
head(data_fix$fix_text, 10)
#Now i will make a second "cleaning" round, just to be sure.
# remove rt
x = gsub("rt", "", text)
# remove at
x = gsub("@\\w+", "", x)
# remove punctuation
x = gsub("[[:punct:]]", "", x)
# remove numbers
x = gsub("[[:digit:]]", "", x)
# remove links http
x = gsub("http\\w+", "", x)
# remove tabs
x = gsub("[ |\t]{2,}", "", x)
# remove blank spaces at the beginning
x = gsub("^ ", "", x)
# remove blank spaces at the end
x = gsub(" $", "", x)
#more unusual characters 
a<-gsub("[^\x01-\x7F]", "", x)
#now i will get the sentiments
sentimientos_df <- get_nrc_sentiment(a, lang="spanish")
#now i will print the "head()" to see if everything is ok. 
head(sentimientos_df)
#now i will make my summary to see the results. 
summary<-summary(sentimientos_df)
#graphic emotions
barplot(
  colSums(prop.table(sentimientos_df[, 1:8])),
  space = 0.2,
  horiz = F,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "8 diferentes emociones",
  sub = "Emociones",
  xlab="emociones", ylab = NULL)
#graphic sentiments
barplot(
  colSums(prop.table(sentimientos_df[, 9:10])),
  space = 0.2,
  horiz = T,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 2, name = "Set3"),
  main = "Sentimiento positivo y negativo",
  sub = "Sentimientos",
  xlab="emociones", ylab = NULL)
#counting words 
#i will set all the words in frecuency order, from 0 to the maximum.
#you can repeat this process with each emotion you want: fear, disgust,
#anger, trust, negative, positive, etc. 
palabras_tristeza <- a[sentimientos_df$sadness> 0]
palabras_tristeza_orden <- sort(table(unlist(palabras_tristeza)), decreasing = TRUE)
head(palabras_tristeza_orden, n = 13)
#Now, in a graphic i will draw the way in chich the dialog has changed between 
#positive sentiments and negative ones
sentimientos_valencia <- (sentimientos_df$negative *-1) + sentimientos_df$positive
simple_plot(sentimientos_valencia)





--------------------



