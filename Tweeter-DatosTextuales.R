#TRABAJANDO CON TWITTER-----------------------------------------------

'''primero que nada hay que acceder a la APLI de twitter para tener acceso a 
toda la información de la plataforma, una vez ahí debemos entrar a la aplicación
de las apps que tenemos desarrolladas, debemos buscar los keys y credenciales
de las apps que trabajaremos.'''

setup_twitter_oauth("6gMch1lkCfn3W5PZho3X4jh8W",#api key
                    "eBosfeWmQVBLQ87WiVMaRXousYRdyOkyhLkvCUzw7ioz0EMCWY",#api secret key
                    "284827529-UENNMA2jVHCRBYwcddd6obAAZvaJ0hUVSapYYmwZ",#acces token
                    "sb1fgjDG9CSugsU5qsWJWkBOvP91FxJmcm7hKCyajrndT")#acces token secret

'''Uso el comando searchTwitter para buscar información dentro de twitter con 
la palabra clave que yo deseo buscar'''

a<- searchTwitter("@FicoGutierrez", n=500)
a[1:100]
C1<-searchTwitter('Claudia Lopez', since='2020-03-01', until='2022-03-02', n=200)
C2<-searchTwitter('@ClaudiaLopez', since='2020-03-01', until='2022-03-02', n=200)
C3<-userTimeline('@ClaudiaLopez', since='2020-03-01', n=200)
C3[1]
#searchTwitter('Claudia Lopez', resultType = "popular"/"recent")

petroski<-searchTwitter('Petro', n=500)

#creando un dataframe con la información obtenida. 

#quí extraigo los tw
fico<-twListToDF(a)
#AHORA TRABAJANDO CON RTWEET--------------------------------------------------
#parse es el comando usado para recibid un data frame o una lista de objetos.
create_token(app="Clase_big_data",
             consumer_key = "6gMch1lkCfn3W5PZho3X4jh8W",#api key
             consumer_secret = "eBosfeWmQVBLQ87WiVMaRXousYRdyOkyhLkvCUzw7ioz0EMCWY",#api secret key
             access_token ="284827529-UENNMA2jVHCRBYwcddd6obAAZvaJ0hUVSapYYmwZ",#acces token
             access_secret ="sb1fgjDG9CSugsU5qsWJWkBOvP91FxJmcm7hKCyajrndT")#acces token secret

C4 <- get_timeline(user = "@ClaudiaLopez", n = 200, parse = TRUE, check = FALSE)
C5 <- get_timeline(user = "@ClaudiaLopez", n = 200, parse = F, check = FALSE)

#Sentiment analysis-----------------------------------------
#Now let learn the sentiment analysis process.... 
#extract the text only
te<-Perfiles_Mkt$`Descripcion Vacante`
#Now lets try data mining algorithms -----------------------------------------------
#Now i will split the text in words to analyse each one of them separated
tokens<-tokens(te,what = "word",remove_punct = TRUE,remove_symbols =TRUE,remove_numbers =TRUE,remove_url =TRUE,remove_separators =TRUE,split_hyphens =TRUE)
#I will clean the words 
# Remove mentions, urls, emojis, numbers, punctuation, etc.
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
#Now i will make a second "cleaning" round, just to be sure.
# remove rt
x = gsub("rt", "", text)
# remove at
x = gsub("@\\w+", "", x)
# remove punctuation
x = gsub("[[:punct:]]", "", x)
# remove numbers (pilas con esta porque a veces los númers son útiles)
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
#NON CAPITAL LETTERS (Convertimos todo a minúsculas.)
discurso <- tolower(a)
#remove stopwords (quito las stopwords("spanish").)
discurso <- removeWords(discurso, words = stopwords("spanish"))
discurso <- removeWords(discurso, words = c("hp2pdfmnfa","@iandresrm","va","https://","@",":",
                                            "…","t.co/","👁","@christi11079874","📢","jajajajjaja",
                                            "“","n","cad…","@lafm","plat…",
                                            "…", "indra","dos","día","🇨🇴",
                                            "de","la","aos","el","y","las","nes",
                                            "ser"))
#Remove punctuation (Nos deshacemos de la puntuación) 
discurso <- removePunctuation(discurso)
#Remove numbers (removemos los números) 
discurso <- removeNumbers(discurso)
#confirmation
discurso[1:300]
#I will create a new vector (Conformo un vector de palabras)
discurso1 <- Corpus(VectorSource(discurso)) 
#create a matrix object (organizo el compendio de palabras en un objeto tipo matriz de datos)
letras<- TermDocumentMatrix(discurso1)
letrasmatrix <- as.matrix(letras) 
# hago un vector que va a sumar la repetición de palabras en la matriz y así
# consigo la frecuencia total de palabras que hay para cada término, despues le digo
# que las sume y las organice
vector <- rowSums(letrasmatrix) 
Vectorr<- sort(vector, decreasing = T)
#ahora bien, cabe revisar la frecuencia de palabras para así poder identificar 
# cuales de estas palabras son y cuales de estas palabras no me son útiles por eso 
# imprimo la matriz antes de que podamos sacar conclusiones del analisis
# #ver el vector
view(Vectorr)
#Inspeccionar la matriz ordenadamente
Vectorr[1:20]
# AHORA ES IMPORTANTISIMO: si veo que en el vector de palabras hay algun termino
# que esté molestando demasiado, la forma mas fácil de eliminarlo es regresar al 
# corpus y quitarlo arriba con el comando removeWords y repetir los pasos hasta 
# aquí, pero se debe tener en cuenta que es mejor retroceder y correr todos los
# comandos de limpeza nuevamente, desde el princpio, es decir, desde
# aquí discurso <- gsub("[[:cntrl:]]", " ", a) pero ahora incluyendo los terminos
# que se desea eliminar del comando removeWords
#transformo todo en un dataframe
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


#wordcloud2(data=dataletras, size=0.7,
#           color='random-dark', shape = 'triangle')

'''Veamos ahora cómo se asocian algunas palabras (terms) en Niebla con la 
función findAssocs. Como podemos introducir un vector, podemos obtener las 
asociaciones de varias palabras a la vez. He elegido 
"Petro", "petro","Uribe", "uribe"

Es importante recordar que con esto no estamos pidiendo la asociacion de estas
cuatro palabras entre si, sino las asociaciones para cada una de las cuatro, que
no necesariamente deben coincidir.

Esta también nos pide el límite inferior de correlación (corlimit)
para mostrarnos. Valores cercanos a 1 indican que las palabras aparecen casi
siempre asociadas una con otra, valores cercanos a 0 nos indican que nunca o
casi nunca lo hacen.

El valor que decidamos depende del tipo de documento y el tipo de asociaciones
que nos interesen. para nuestros fines, lo he fijado en .25.'''
findAssocs(letras, terms = c("Petro", "petro",
                             "Uribe", "uribe"), corlimit = .25)
#CLUSTERING DE PALABRAS------------------------------------------------------
'''ahora vamos a eliminar primero todos los terminos dispersos paraque no jodan,
como se trata de una correlación los valores que manejaremos serán de 0 a 1'''
nov_new <- removeSparseTerms(letras, sparse = .95)
#llevamos el objeto a matriz
nov_new <- nov_new %>% as.matrix()
#Matriz de distancia--------------------------------------------------------
'''Necesitamos crear una matriz de distancias para empezar agrupar, lo cual 
requiere que los valores en las celdas sean estandarizados de alguna manera.

Podríamos usar la función scale, pero realiza la estandarización usando la media
de cada columna como referencia, mientras que nosotros necesitamos como 
referencia la media de cada renglón.

Así que obtenemos una estandarización por renglones de manera manual.'''
nov_new <- nov_new / rowSums(nov_new)
#Hecho esto, nuestra matriz ha sido estandarizada.
'''Procedemos a obtener una matriz de distancia a partir de ella, con el método
de distancias euclidianas y la asignamos al objeto nov_dist.'''
nov_dist <- dist(nov_new, method = "euclidian")
'''Realizaremos nuestro agrupamiento jerárquico usando la función hclust, de la
base de R. Este es en realidad un procedimiento muy sencillo una vez que hemos
realizado la preparación.

Usaremos el método de Ward (ward.D), que es el método por defecto de la función
hclust y asignaremos sus resultados al objeto nov_hclust.'''
nov_hclust <-  hclust(nov_dist, method = "ward.D")
#Graficamos los resultados usando plot para generar un dendrograma.
plot(nov_hclust, main = "Dendrograma de Niebla - hclust", sub = "", xlab = "")
'''De este modo podemos observar los grupos de palabras que existen en Niebla. 
Por ejemplo, “augusto” y “eugenia” forman un grupo, “puede” y “ser”, forman otro
grupo (“puede ser” es una frase común en este libro).

Además, podemos ver qué palabras pertenecen a grupos lejanos entre sí, 
por ejemplo, “quiero” y “verdad”.

Podemos enfatizar los grupos de palabras trazando un rectángulo usando
rect.hclust y con especificando cuántos grupos (k) deseamos resaltar.

Crearemos el mismo gráfico pidiendo diez grupos.'''

plot(nov_hclust, main = "Dendrograma de Niebla - hclust", sub = "", xlab = "")
rect.hclust(nov_hclust, k = 10, border="blue")

#Puedo exportar cualquier elemento en forma de csv al computador, la formmula es:
'''le pido al computador que write.csv (escriba un csv), entonces tendremos:
write.csv(nombre del objeto que quiero pasar,
le pido que lo copie con la función paste) y nombro el directorio al que lo voy a pasar
despues el nombre del archivo, el tipo de separador que usaré, la codificación
que usaré (generalmente UTF-8 es la del español que tiene tildes y ñ) y finalizo
quitándole los nombres a las filas para que no moleste en caso de tenerlas...
asi pues el comando quedaría así:'''
#Write.csv(objetoA, paste(directorio, "nombre del nuevo archivo.csv, sep =";"), fileEncoding= "UTF-8", row.names=F)