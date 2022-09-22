#GGPLOT---------------------
#now lets learn the ggplot command to visualize data and learn
#how to use it in a propper way. 

plot(gapminder$life_expectancy)

plot(gap$fertility)

hist(gap$year)
hist(gap$fertility)

boxplot(gap$population)
boxplot(gap$year)

plot(mtcars)
corPlot(cor(mtcars))
#Método 1
mtcars %>% 
   cor() %>% 
   corrplot(method = "circle",
            title = "method = 'circle'",
            tl.pos = "n", mar = c(2, 1, 3, 1))
#Método 2
mtcars %>% 
   cor() %>% 
   corrplot(method = "square", #método de gráfico
            title = "method = 'square'", #titulo impreso en pantalla
            tl.pos = "n",#posición del titulo
            mar = c(2, 1, 3, 1))#márgenes a usar
#Método 3
mtcars %>% 
   cor() %>% 
   corrplot(method = "color",
            title = "method = 'color'",
            tl.pos = "n", mar = c(2, 1, 3, 1)) 
#Método 4
mtcars %>% 
   cor() %>% 
   corrplot(method = "square",
            title = "method = 'square'")
#ggplot básico
library(ggplot2)
#el plot más básico. 
ggplot()
#???
ggplot(data = murders)
#???
murders %>% ggplot()
#guardemos el gráfico en un objeto y veamos su clase
p <- ggplot(data = murders)
class(p)
print(p)
p
#GEOMETRIA------------
#geom_X ---> X será la geometría a usar en el gráfico. 
#ejemplo---> geom_point()

#ESTÉTICA-------------
murders %>% 
   ggplot() +
   geom_point(aes(x = population, y = total))

#También podemos definir el objeto P que ya habíamos definido. 
p + geom_point(aes(population, total))

#Capas--------------
#ggplot(aes(X,Y, condición= variable))
p + geom_point(aes(population, total)) +
   geom_text(aes(population, total, label = abb))

#Más argumentos estéticos. 
#size, cambia el tamaño de las figuras, pero debe ir porfuera del primer
#argumento estético definido.
p + geom_point(aes(population, total), size = 3) +
   geom_text(aes(population, total, label = abb))
#mover el téxto para un u otro lado para hacerlo legible.
p + geom_point(aes(population, total), size = 3) +
   geom_text(aes(population, total, label = abb), nudge_x = 1.5)
# Mapeos estéticos globales versus locales------------
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
#ahora agreguemos capas y características. 
p + geom_point(size = 3) +
   geom_text(nudge_x = 1.5)
#Vamos a definir nuevas características locales...
#simplemente declaramos nuevos parámetros. 
p + geom_point(size = 3) +
   geom_text(aes(x = 10, y = 800, label = "Hello there!"))

#Escalas------------
# Primero, las escalas que queremos están en escala logarítmica. 
# Este no es el valor predeterminado, por lo que este cambio debe añadirse 
# a través de una capa de escalas. 
# 
# La función scale_x_continuous nos permite controlar el 
# comportamiento de las escalas. La usamos así:
p + geom_point(size = 3) +
   geom_text(nudge_x = 0.05) +
   scale_x_continuous(trans = "log10") +
   scale_y_continuous(trans = "log10")
# Debido a que ahora estamos en la escala logarítmica, 
# el ajuste a la posición debe hacerse más pequeño en el plano gráfico.
# 
# Esta transformación particular es tan común que ggplot2 
# ofrece dos funciones especializadas scale_x_log10 y scale_y_log10, 
# que podemos usar para reescribir el código de esta manera:
p + geom_point(size = 3) +
   geom_text(nudge_x = 0.05) +
   scale_x_log10() +
   scale_y_log10()
#Etiquetas y títulos---------
p + geom_point(size = 3) +
   geom_text(nudge_x = 0.05) +
   scale_x_log10() +
   scale_y_log10() +
   xlab("población en millones") +
   ylab("Número total de muertes") +
   ggtitle("Muertes en US para el 2010")
#Categorías como colores----------------
p + geom_point(size = 3, color = "blue") +
   geom_text(nudge_x = 0.05) +
   scale_x_log10() +
   scale_y_log10() +
   xlab("población en millones") +
   ylab("Número total de muertes") +
   ggtitle("Muertes en US para el 2010")
#pero también podemos cambiar los colores según variables. 
p + geom_point(aes(col=region), size = 3) +
   geom_text(nudge_x = 0.05) +
   scale_x_log10() +
   scale_y_log10() +
   xlab("población en millones") +
   ylab("Número total de muertes") +
   ggtitle("Muertes en US para el 2010")