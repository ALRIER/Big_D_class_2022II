#Báses de trabajo con dyplyer-------------------------------------
#cargaré los datos de la libreria

#rectifico que hayan quedado bien cargados
install.packages(gapminder)
library(gapminder)
data("gapminder")
head(gapminder)
# filtrar datos por pais sin %>%  == >= 
filtroQ =filter(fico, fico$screenName == "actasaz")
filtroQ =filter(fico,
                fico$screenName == "condicion")

filtroN = fico %>% 
   filter(screenName =="actasaz")%>% 
   filter(retweetCount > 342)


f<-filter(gapminder, country == 'Mexico')
#extraer todos los registros de todos los registros de sony para el año2018
filtro1<-filter(gapminder, country == '')
# filtrar datos por pais
# para hacer %>% en RStudio (cntrl + shift + M)
f= gapminder %>%
   filter(country == 'Mexico')

continentes=gapmider %>% 
   filter(continent == 'Asia')
# filtrar datos por año
año= gapminder %>% 
   filter(year == '1952')

continente=gapminder %>% 
   filter(continent== "Europe") %>% 
   filter(year >= "2000")

# filtrar paises con esperanza de vida mayor o igual a 40 y el año en 2002
gapminder %>% 
   filter(lifeExp <=40,
          year == 2002)
# hacer resumenes de datos---------------------------------------------

# cantidad de paises en Asia para el año 2007 
paises=gapminder %>% 
   filter(continent == 'Asia',
          year == 2007) %>%
   summarise(conteo = n())

# maxima esparanza de vida
q=gapminder %>% 
   summarise(max(lifeExp))
# agrupando esperanza de vida promedio por año
promedio<-gapminder %>% 
   group_by(year) %>% 
   summarise(mean(lifeExp))
#Sumarios de datos. 
library(dplyr)
library(dslabs)
library(NHANES)
data(NHANES)
data(heights)
data(murders)

sj = heights %>%
   filter(sex == "Female") %>%
   summarize(average = mean(height), standard_deviation = sd(height))
#Resúmenes múltiples. 
sumarios=heights %>% 
   filter(sex == "Female") %>%
   summarize(median = median(height), minimum = min(height), 
             maximum = max(height))
#cuartiles----------
gap %>% view()

gap %>% 
   filter(continent == 'Europe') %>%
   summarize(cuartiles = quantile(gap$life_expectancy, c(0, 0.5, 1)))

#agrupado de datos y sumario de datos
heights %>%
   group_by(sex) %>%
   summarize(average = mean(height), standard_deviation = sd(height))

#vamos a organizar la ifnromación según algun dato en especifico
#ascendente
gap2=gap %>%
   arrange(sort(life_expectancy))
#descendente
gap2=gap %>%
   arrange(desc(life_expectancy))
#aleatorio
gap2=gap %>%
   arrange(sort(life_expectancy))

#podeos ordenar datos por más de 1 categoría. 
murders %>%
   arrange(region, total) %>%
   head()

murders %>%
   arrange(region, desc(total)) %>%
   head()

murders %>%
   arrange(region, sort(total)) %>%
   head()
#dyplyer más a profundidad----------------------------------------------------
nuevo=gap %>%
   group_by(year) %>%
   filter(country=='Canada')

gapminder %>%
   group_by(continent, year) %>%
   summarize(sum(life_expectancy))

z1<- gapminder%>%
   group_by(year) %>%
   filter(continent == 'Asia') %>%
   mutate(asiaxaño = mean(life_expectancy))

#función mutate
z1<- archivo %>%
   group_by(YEAR) %>%
   filter(UNIVERSAL == 10) %>%
   mutate(Pelis = mean(UNIVERSAL))


# el objeto está comprendido en. 
t=gap %>%
   filter(country%in% "Aruba") 

#El objeto NO esta comprendido en. 
t=gap %>%
   filter(!country%in% "Aruba")

#un filtro de todos los años que tengan 0, despues haga un mutate en una
#columna nueva y guardelos seguncontengan o no el comando que yo le indique. 
ceros<-archivo_tible %>%
   mutate(
      contiene_0 = grepl('0', YEAR)) %>%
   select_('YEAR', 'contiene_0')


#comando across ---------------------------------------------------

gapminder %>%
   summarise(
      lifeExp_min = min(life_expectancy),
      lifeExp_max = max(life_expectancy),
      lifeExp_mean = mean(life_expectancy),
      pop_min = min(population),
      pop_max = max(population),
      pop_mean = mean(population),
      gpd_min = min(gdp),
      gpd_max = max(gdp),
      gpd_mean = mean(gdp)
   )

'''o podria hacerlo mucho mas facil, asi:'''
gap %>%
   group_by(year)%>%
   summarise(across(c(life_expectancy,population, gdp),
                    list(min, max, mean)))

gap %>% summarise(across(starts_with ("Canada")))
                            




