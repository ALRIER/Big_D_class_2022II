#Báses de trabajo con dyplyer-------------------------------------
#cargaré los datos de la libreria

#rectifico que hayan quedado bien cargados
data("gapminder")
head(gapminder)

head(archivo)
view(archivoo)
# filtrar datos por pais sin %>%  == >= 
# hay unos comandos que son muy importantes en R == significan igual
# >= este simbolo se usa cuando se quieran usar operadores logicos de mayoria o igualdad
# <= menor o igual
# != significa diferente de en R
# este solo funciona en tipyverse: a%in%b significa cuando a está compuesto dentro de b
# fico%in%b
h=filter(fico, fico$screenName=='joselosuarez')
f<-filter(gapminder, country == 'Mexico')
#extraer todos los registros de todos los registros de sony para el año2018
filtro1<-filter(gapminder, country == '')
# filtrar datos por pais
# para hacer %>% en RStudio (cntrl + shift + M)
f<- gapminder %>%
   filter(country == 'Mexico')

continentes<-gapmider %>% 
   filter(continent == 'Asia')
# filtrar datos por año
año<- gapminder %>% 
   filter(year == '1952')
# filtrar paises con esperanza de vida mayor o igual a 40 y el año en 2002
gapminder %>% 
   filter(lifeExp <=40,
          year == 2002)
# hacer resumenes de datos---------------------------------------------

# cantidad de paises en Asia para el año 2007 
paises<-gapminder %>% 
   filter(continent == 'Asia',
          year == 2007) %>%
   summarise(conteo = n())

# maxima esparanza de vida
q<-gapminder %>% 
   summarise(max(lifeExp))
# agrupando esperanza de vida promedio por año
promedio<-gapminder %>% 
   group_by(year) %>% 
   summarise(mean(lifeExp))

#dyplyer más a profundidad----------------------------------------------------
archivo %>%
   group_by(YEAR) %>%
   summarize(mean(UNIVERSAL))

z<-gapminder %>%
   group_by(continent, year) %>%
   summarize(sum(lifeExp))

z1<- gapminder%>%
   group_by(year) %>%
   filter(continent == 'Asia') %>%
   mutate(asiaxaño = m(pop))

#función mutate
z1<- archivo %>%
   group_by(YEAR) %>%
   filter(UNIVERSAL == 10) %>%
   mutate(Pelis = mean(UNIVERSAL))


# el objeto está comprendido en. 
employee_new_data %>%
   filter(employee_name %in% c("Amanda")) 

#El objeto NO esta comprendido en. 
employee_new_data %>%
   filter(!employee_name %in% c("Amanda"))

#un filtro de todos los años que tengan 0, despues haga un mutate en una
#columna nueva y guardelos seguncontengan o no el comando que yo le indique. 
ceros<-archivo_tible %>%
   mutate(
      contiene_0 = grepl('0', YEAR)) %>%
   select_('YEAR', 'contiene_0')


#comando across ---------------------------------------------------
'''nos ayuda a aplicar un mismo comando sobre diferentes lineas de codigo o sobre una variable especifica'''

'''si quiero sacar el minimo, maximo y media de la esperanza de vida, del producto
percapital del pais y de la vairbale llmada gdp, pordia hacerlo asi:'''

gapminder %>%
   group_by(year) %>%
   summarise(
      
      # Esperanza de vida
      lifeExp_min = min(lifeExp),
      lifeExp_max = max(lifeExp),
      lifeExp_mean = mean(lifeExp),
      
      # Poblacion
      pop_min = min(pop),
      pop_max = max(pop),
      pop_mean = mean(pop),
      
      # GDP
      gpd_min = min(gdpPercap),
      gpd_max = max(gdpPercap),
      gpd_mean = mean(gdpPercap)
      
   )

'''o podria hacerlo mucho mas facil, asi:'''

gapminder %>%
   group_by(year) %>%
   summarise(
      across(
         c(lifeExp,pop, gdpPercap), 
         list(min, max, mean)
      )
   )

forbes <- read.csv("C:/Users/andrs/OneDrive/Escritorio/FG2000_2021.csv", sep=";")
#forbes es una lista de rakings, nombres (empresas), paises, ventas, ganancias, activos, y valor.
# podría sacar todo lo de un país. 
filtro1= forbes %>%
   filter(pais == "United Kingdom")

Estadisticos1= forbes %>% 
   filter(pais == "United Kingdom") %>%
   summarize(median = median(ventas), minimum = min(ventas), 
             maximum = max(ventas))

Ventasaltas1= forbes %>% 
   filter(pais == "United Kingdom") %>%
   filter(ventas >=100)


