:)
:)

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

#Cómo abrir un archivo desde el equipo?
#Escribo el comando read_csv('dentro la ruta de mi archivo')
archivo <- read_csv('/home/alrier/Documentos/movies datasets/WideReleasesCount.csv')
cars<-read_csv('/home/alrier/Documentos/Big_data/USA_cars_datasets.csv')
data("gapminder")
archivo <- WideReleasesCount

#VECTORES----------------------------------------
a <- c(2,4,1,8)
b <- c(2,2,2,2)

#Puedo poseer diferentes tipos de vectores
vector_double <-c(1, 2.5, 4.5, 25)
# Con el sufijo L, conseguimos un integer en lugar de un double
vector_integer <-c(1L, 6L, 10L)
# Usamos TRUE y FALSE (o T y F) para crear vectores lógicos
vector_logical <-c(TRUE, FALSE, T, F)  
vector_character <-c("Hola", "Mundo!", "4343434", "ssfkjdfdkjflkshfklj")

#Length nos ayuda a conocer la longitud de cualquier vector. 
length(vector_logical)
length(vector_double)
length(archivo)

#Operaciones Vectorizadas-------------------------------------------------------------
c<-a+b
c<-a/b
#reciclaje de elementos en los vectores. 

'''supongamos que tenemos dos vectores a y b'''
a<-c(1,2)
b<-c(1,2,3,4)
'''pero deseamos crear una operaicón con estos dos vectores sumandolos'''
d<-a+b
'''veremos que el resultado de ellos es la suma de las dos primeras partes del vector
y R recicla la otra parte del vector para no perder datos'''

a=c(1,4,6,8)
b=c(9,8)
c=c("blanco","gris","rojo","negro")
d=c("purpura","cafe","verde","azul")
e=c(1,9,5)
f=c(8,6,3,8,9,5)
g=cbind(a,b)
h=rbind(c,d)
i=cbind(f,e)

View(i)

mat=matrix(1:20,ncol = 4)
paises=matrix(1:12,nrow = 3,byrow=TRUE, dimnames = list(c("francia","belgica","españa")))
cosa=matrix(4:27,
            nrow = 4,
            dimnames =list(c("libro","radio","olla","123")))


#Matrices--------------------------------------------------------------------
#Para crear matrices utilizaremos la función matrix() , la sintaxis es la siguiente
str(matrix)
function (data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL)
  '''A continuación mostramos la descripción de los argumentos:
data = es el vector que contiene los elementos que formaran parte de la matriz.
nrow = es el número de filas.
ncol = es el número de columnas.
byrow = es un valor lógico. Si es TRUE el vector que pasamos será ordenado por filas.
dimnames = nombres asignado a filas y columnas.'''
#Seguidamente se muestra un ejemplo de creación de una matriz:
matriz <- matrix(1:12, nrow = 4)
matriz
#ejemplo de una matriz usando los argumentos previamente aprendidos. 
automoviles <- matrix(
  1:12,
  nrow = 4, #numero de filas
  byrow = TRUE, #ordenado por filas.
  dimnames = list( #nombre de las filas y las columnas
    c("Blanco", "Rojo", "Negro", "Gris"),
    c("Toyota", "Audi", "Nissan")
  )
)

automoviles <- matrix(
  1:12,
  nrow = 4, 
  byrow = TRUE,
  dimnames = list(
    c("Blanco", "Rojo", "Negro", "Gris"),
    c("Toyota", "Audi", "Nissan")
  )
)

#cbind(), rbind() agregar filas y columnas organizandolas de forma manual. 

v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)
m1 <- cbind(v1, v2)
m1

nombres <- c("Pedro","Maria","Juan")
apellidos <- c("Gonzales", "Gomez", "vuelolindo")
nomrbres_y_apellidos <- rbind(nombres,apellidos)
nomrbres_y_apellidos2 <- cbind(nombres,apellidos)

v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)
m1 <- rbind(v1, v2)
m1

#Listas-------------------------------------------------------------------
lista <- list(1:3, "Ruben", pi, list(c(-1, -2), -5))
lista

#nombrar listas 
'''se puede nombrar las listas como se desee una vez se han creado'''
data_list <- list(c("enero","Febrero","Marzo"), #aquí creo las listas
                  matrix(c(1,2,3,4,-1,9), nrow = 2),#asigno categirias a lo que hay dentro
                  list("Rojo",12.3))


#con el comando names yo puedo nombrar los objetos dentro de una lista
#el comando es names(introduzco el nombre del objeto a nombrar)
names(data_list) <- c("listaA", "listaB", "listaC") #aquí nombro las listas
data_list #aquí imprimo el contenido de las listas

listab.1 <-data_list$listaB #aquí extraigo la lista B en un objeto 
#nuevo que se llamará listab.1

archivo.1 <- archivo$`SONY PICTURES`
archivo2 <- archivo$`PARAMOUNT PICTURES`

tabla<-cbind(archivo.1,archivo2)

print(data_list[3]) #así accedo a las listas e imprimo su contenido. 

data_list[4] <- "New element" #agrego un nuevo elemento a la lista (al final)
print(data_list[4]) 

data_list[4] <- NULL #remover el elemento 
print(data_list[4]) #se elimina el último elemento agregado.

#modifico el 3er elemento de la lista
print(data_list[3])

#Ahora como mezclar listas. 
num_list <- list(1,2,3,4,5) #creo una lista 1
day_list <- list("Mon","Tue","Wed", "Thurs", "Fri") #creo la lista 2
merge_list <- c(num_list, day_list) #las mezclo
merge_list #llamo al producto

'''las listas se mezclan quedando una lista más grande con todo el código y todo
el contenido de las que antes eran dos listas separadas. '''

#data.frame()-------------------------------------------------------------
#IMPORTANTE
nombre <- c("Juan", "Ruben", "Daniel", 0) 
apellido <- c("Sanchez", "Garcia", "Sancho", "Alfara") 
fecha_nacimiento <- c("1976-06-14", "1974-05-07", "1958-12-25", "1983-09-19")
sexo <- c("HOMBRE", "MUJER", "HOMBRE", "HOMBRE")
nro_hijos <- c(1, 2, 3, 4) 

censo <- data.frame(nombre, apellido, fecha_nacimiento, sexo, nro_hijos) 
#ojo al error... arguments imply differing number of rows: 3,4. 



'''se debe tener en cuenta que el dataframe está conformoado por un número 
de vectores, los cuales para poder realizar operaciones aritméticas de adeción
mezcla u otra operación deben poseer un número igual de datos'''

int_vec <- c(1,2,3) #creo 3 vectores un con enteros, otro con caracteres 
char_vec <- c("a", "bsvjkzlkvdnl<zkjvdnl", "zdvzxvzxbc")# y uno con boleanos. 
bool_vec <- c(TRUE, TRUE, FALSE)

data_frame <- data.frame(int_vec, char_vec,bool_vec)#crearé mi dataframe

#Nuevamente
employee_data <- data.frame(
  employee_id = c (1:5), #defino un elemento compueso por un conteo de 1 a 5
  employee_name = c("Jaime","Henrry","julia","Jimmy","Oliver"), #5 nombres
  sal = c(642.3,535.2,681.0,739.0,925.26), #5 "salarios" hipoteticos
  join_date = as.Date(c("2013-02-04", "2017-06-21", "2012-11-14", "2018-05-19","2016-03-25"))
)

#que tipo de variables componen mi Dataframe?
str(employee_data)

#extraigo información del Fataframe 
a<- employee_data$sal
b<-employee_data$employee_name
#aplico lo aprendido y mezclo la información para crear una nueva tabla con las
#variables a y b que extraje previamente de mi dataframe. 
mix <- cbind(a, b)
#ahora creo una variabe nueva
c<- c(1,2,3,4,5)
#la introduzco en mi nueva tabla
mix2 <- cbind(mix, c)
mix2
#la convierto en dataframe
pan <- as.data.frame(mix2)
mix2df#cuál fue la diferencia?

#ahora, de un dataframe, yo puedo extraer varios elementos a la vez
output <- data.frame(employee_data$employee_name, employee_data$employee_id)
print(output)
#O extraer 2 rows completas
output <- employee_data[1:2,0]#debería ser este el comando?
#error, puesto que extrae la columna 0
output <- employee_data[1:2,]
output <- employee_data[1:5,]
output <- employee_data[,2]
print(output)

#ahora, extraigo 1 y 2 row con la columa 3 y 4.
result <- employee_data[c(1,2),c(3,4)]
result

#agregando columnas
employee_data$deptartamento <- c("tecología","Finanzas","Operaciones",
                                 "recursos humanos","Administración")
out <- employee_data
print(out)


#creo un nuevo dataframe
employee_new_data <- data.frame(
  employee_id = c (1:5),
  employee_name = c("Amanda", "Mauricio", "Andres", "Pedro", "Manuel"),
  sal = c(523.0,721.3,622.8,721.3,622.8),
  deptartamento = c("tecología","Finanzas","Operaciones",
                    "recursos humanos","Administración"),
  join_date = as.Date(c("2015-06-22","2016-04-30","2011-03-17","2016-04-30",
                        "2011-03-17")), stringsAsFactors = FALSE)

print(employee_new_data)

#uniendo ámbos dataframe
employee_out_data <- rbind(employee_data,employee_new_data)
employee_out_data 

