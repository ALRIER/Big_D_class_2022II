Comencemos cargando los paquetes dplyr y ggplot2,
así como los datos murders y heights.
library(tidyverse)
library(ggplot2)
library(dslabs)
data(heights)
data(murders)
data(gapminder)
data(na_example)

1. Carguen el set de datos co2 que viene incluido en la base de R. Recuerden para cargar un set de datos
que viene prediseñado dentro de un paquete o en la base de R la orden es--> data(nombre del database). Listo

2. Examine el set de datos... qué orden es más adecuada y por qué,
justifiquen su respuesta al final de esta pregunta?
A. head(co2)
B. View(co2) X 
C. print(co2)
D. str(co2)

El orden más adecuado para examinar el set de datos es el comando "view", 
porque este nos permite observar todos los datos que contiene el set, 
facilitando así un conocimiento más específico en comparación de las otras 
opciones que nos dan apenas un fragmento del set.  

3. Qué comando me ayuda a conocer un reporte de mi dataframe... tipo de variables,
tamaño del dataframe, tipo de columnas, entre otros y por qué,
justifiquen su respuesta al final de esta pregunta?

A. str(co2) X
B. class(co2)
C. length(co2)
D. squeeze(co2) 

El comando "str" da un reporte del dateframe. En este caso reporta que 
la variable "co2" está usando variables númericas y tiene una longitud de 468 datos. 

4. Si rank(x) le da el rango de las entradas de x de menor a mayor, rank(-x)
le da los rangos de mayor a menor. Usen la función mutate para añadir una columna
rank que contiene el rango de la tasa de asesinatos de mayor a menor.
Asegúrense de redefinir murders para poder seguir usando esta variable.

FALTA
ascendente = sort(murders)

5. Con dplyr, podemos usar select para mostrar solo ciertas columnas.
Por ejemplo, con este código solo mostraríamos los estados y los tamaños de población:
   
   murders %>%
   select(state, population)%>%
   head()

Utilicen select para mostrar los nombres de los estados y las abreviaturas en murders.
No redefinan murders, solo muestren los resultados y guarden estas columnas en una variable
llamada abreviaturas.

abreviaturas = murders %>% 
   select(state,abb) %>% 
   head()

6. En el ejercicio 2 crearon una variable llamada rank en la que asignaron el rango de muestres
organizadas de mayor a menor, extráigan esta variable del dataset total y agréguenla a la variable
abreviaturas.

Qué pasó?
   A. Todo perfecto, ya está hecho.
B. No se puede, los dataframes son de tamaños diferentes.
C. Los dataframes son de diferente tamaño, pero pudimos lograrlo.
D. A y B son correctas.

7. Como ya lo hemos visto, usando la función mutate de
dplyr puedo agregar columnas nuevas a un dataframe (df).

A continuación crearé una variable nueva
llamada poblacion_en_millones en la que alteraré los valores de
population para hacerlos comprensibles multiplicandolor por 10 a la 6
o lo que es lo mismo por 1,000,000:
   
   murders <- murders%>%
   mutate(poblacion_en_millones = population/ 10^6)

Ahora ustedes: Usen la función mutate para añadir una columna de asesinatos llamada
"rate" con la tasa de asesinatos por 100,000 como en el código
del ejemplo anterior. Asegúrense de redefinir murders como se
hizo en el código del ejemplo anterior (murders <- [su código])
para que podamos seguir usando esta variable.

murders <- murders%>%
   mutate(rate = total/ 10^6)

8. La función filter de dplyr se utiliza para elegir filas
específicas del data frame para guardar.
A diferencia de select que es para columnas, filter es para filas.
Por ejemplo, puede mostrar solo la fila de Nueva York así:
   
   murders %>%
   filter(state == "New York")
Puede usar otros vectores lógicos para filtrar filas.

Utilice filter para mostrar los cinco estados con las tasas de asesinatos más altas.
Después de añadir la tasa y el rango de asesinatos creen una variable nueva llamada, "filtro1".
Recuerden que pueden filtrar basándose en la columna rank.

a= murders %>% 
   filter(state == "California")
b= murders %>% 
   filter(state == "Texas")
c= murders %>% 
   filter(state == "Florida")
d= murders %>% 
   filter(state == "New York")
e= murders %>% 
   filter(state == "Pennsylvania")

filtro1= murders%>%
      filter(state %in% c("New York", "Texas", "Florida", "Pennsylvania", "California"))
   
9. Podemos eliminar filas usando el operador !=. 
Por ejemplo, para eliminar Florida, haríamos esto:
   
   no_florida <- 
   filter(state != "Florida")

Cree un nuevo data frame con el nombre no_south que elimina
los estados del sur.(La región del Sur, que abarca desde Virginia al norte
                     y hasta Florida al sur, se encuentran también los estados de Alabama,
                     Arkansas, Carolina del Norte, Carolina del Sur, Georgia, Kentucky,
                     Louisiana, Mississippi, Tennessee y Virginia Occidental.)
¿Cuántos estados hay en esta categoría?
   Puede usar la función nrow para esto.

10. También podemos usar %in% para filtrar con dplyr. 
Por lo tanto, pueden ver los datos de Nueva York y Texas de esta manera:
   
   murders%>%
   filter(state %in% c("New York", "Texas"))
Cree un nuevo data frame llamado murders_nw sólo con los estados del norte
(Connecticut, Illinois, Indiana, Iowa, Maine, Massachusetts, Míchigan,
   Minnesota, Nuevo Hampshire, Nueva Jersey, Nueva York, Ohio, Pensilvania,
   Rhode Island, Vermont y Wisconsin) .
¿Cuántos estados hay en esta categoría?, 

murders_nw= data.frame(murders%>%
                          filter(state %in% c("Connecticut", "Illinois", "Indiana", "Iowa", "Maine", "Massachusetts", "Míchigan",
                                              "Minnesota", "Nuevo Hampshire", "Nueva Jersey", "Nueva York", "Ohio", "Pensilvania",
                                              "Rhode Island", "Vermont", "Wisconsin"))) 
filtro2= murders_nw
filtro2 %>% count(state)

guarden el filtro  en una nueva variable llamada "filtro2"

11. Una vez creada la variable, vamos a organizar la columna total en orden 
descendente usando el comando arrange y en base a ella crearemos una nueva
columna llamada muertes_prom que nos dé como resultado la media del total, 
no olviden redefinir la variable filtro2 para que el resultado quede guardado ahí.

muertes_prom= filtro2 %>% arrange(desc(total))
muertes_prom2= muertes_prom %>% summarize(average = mean(total)
                           
12. Con ggplot2, los gráficos se pueden guardar como objetos. 
Por ejemplo, podemos asociar un set de datos con un objeto de gráfico así:
   p <- ggplot(data = murders)
que es lo mismo que (usando tuberías):
   p <- murders %>% ggplot()

¿Cuál es la clase del objeto p? (como gúia pueden referirse al punto 3)

str(p)
El objeto P es una lista

dev.off()
ggplot()

13. Recuerde que para imprimir un objeto puede usar el comando print
o simplemente escribir el objeto. 
Imprimamos el objeto p definido en el ejercicio 8 y describe lo que ves.

A.No pasa nada.
B.Una gráfico de pizarra en blanco (como hojas de papel calcante). X
C.Un diagrama de dispersión.
D.Un histograma.


14. Ahora vamos a añadir una capa y las mapeos estéticos correspondientes. 
Por favor, toma el set de datos heights y guardenlo como una variable tipo dataframe, 
lo mismo deberán hacer con gapminder, recuerden el comando útil es as.dataframe().
Pueden guardarlos con el mismo nombre.  

as.data.frame(heights)
as.data.frame(gapminder)

15. Usando la función:
   
   gapminder %>%
   group_by(year)%>%
   dplyr::summarise(across(c(life_expectancy),
                           list(min, max, mean)))

Yo hago un agrupado de datos por años, después realizaré un summario de datos, 
pero usando el comando across pasaré por todas estas columnas y a cada una le 
aplicaré el comando que le corresponde al orden respectivo de la lista que prosigue...
así a life_expectancy le alicaré un mínimo, un máximo y la media.

Para aclarar debido a que across es una orden de dplyr contenida dentro de otra orden 
del mismo paquete, en este caso dentro de summarise, si la escribo normalmente me dará un error
por esta razón, antes de correr el código deberé explicarle a R que quiero que la orden que 
va a continuación vendrá del paquete dplyr y la proseguiré con cuatro puntos :: que en lenguaje
aljebráico es lo mismo que "=". Así le diré al computador dplyr::(verbo1(verbo2)) explicando que 
se trata de una  cadena de verbos anidados uno dentro de otro. 

Por favor, tomen como ejemplo este código y saquen 2 variables nuevas, una para 
gapminder y otra para heights.

gapminder %>%
   group_by(region)%>%
   dplyr::summarise(across(c(fertility),
                           list(min, max, mean)))

gapminder %>%
   group_by(year)%>%
   dplyr::summarise(across(c(fertility),
                           list(min, max, mean)))

heights %>%
   group_by(sex)%>%
   dplyr::summarise(across(c(height),
                           list(min, max, mean)))

16. Usando el pipe(tuberías) %>%, crea 2 un objetos p1 y p2 nuevos pero esta vez asociados con los filtros 
creados en el punto anteriór (para este punto tomen como referencia el punto
                              8).


17. Para crear el diagrama de dispersión, agregamos una capa con geom_point. 
Los mapeos estéticos requieren que definamos las variables del eje-x 
y del eje-y, respectivamente. Entonces el código se ve así:
   
   murders %>% ggplot(aes(x = , y = )) +
   geom_point()

PERO!!! tenemos que definir las dos variables x e y. 
Llena el espacio con los nombres correctos de las variables. 
(o sea, remplacemos los nombres con unos pertenecientes a 
   variables que gusten y que vengan de los filtros creados en el 
   punto 11) --> recuerden que deberán crear 2 gráfias diferentes, una para 
gapminder y otra para heights.

18. Bien, hemos generado dos objetos gráficos diferentes, uno para gapminder y otro para heights. Nuestra
labor ahora deberá ser la de buscar un cambio para la geometría de los gráficos. 

Recordemos que el cambio de la geometría dependerá totalmente del tipo de valor con el que estemos
trabajando, así variables continuas individuales responderán histogramas o boxplots, pero un cruce de 
variables responderá a un grafico de disperción como el geom_poin, pero también puede responder bien
a otro tipo de geometíras. 

Por favor experimenta con las posibilidades, al escribir geom; R automáticamente te dará una lista de
posibilidades de geometrías posibles. 

19. Ahora vamos a agregar una capa que filtre nuestras varibles. 
teniendo en cuenta que en el punto 8 delimité p, ahora, usaré 
este argumento para trabajar sobre esta base. 

p +
   geom_point(aes(population, state, colour= state))

Así, he usado el argumento geométrico de puntos definiendo
como argumentos estéticos la variable población y
estado, pero además, he dado un filtro de color para la variable estado. 

Ahora ustedes, traten de crear agunos filtros en base a las variables que 
definieron para sus variables p1 y p2 usando los diferentes argumentos 
estéticos (alpha, colour, fill, group, shape, size, stroke)
