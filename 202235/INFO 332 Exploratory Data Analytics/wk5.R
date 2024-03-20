data(mtcars)

plot(mtcars$wt, mtcars$mpg, xlab = "weight", ylab='mpg')
plot(mtcars$wt, mtcars$mpg)

barplot(table(mtcars$cyl), xlab='cylinders', ylab='count')

hist(mtcars$wt, xlab = "weight", main = "Histogram of car weights")

hist(mtcars$wt, breaks = 2, xlab="weight", main = "Histogram of car weights")

boxplot(mtcars$mpg ~ mtcars$cyl, xlab = "Cylinders", ylab = 'mpg')

pairs(mtcars)
pairs(mtcars[c("cyl", 'am', 'hp', 'mpg', 'wt')])

# 3.2
library(ggplot2)

ggplot(data = mtcars, aes(x = wt, y = mpg))+geom_point()
ggplot(data = mtcars, aes(x = wt, y = mpg))+geom_line()
ggplot(data = mtcars, aes(x = wt, y = mpg))+
  geom_point(size = 2, col = 'blue', alpha = 0.6)
ggplot(data = mtcars, aes(x = wt, y = mpg, col = factor(cyl), shape = factor(am)))+
  geom_point(size = 2, alpha = 0.6)

ggplot(data = mtcars, aes(x = wt, y = mpg, col = factor(cyl)))+ 
  geom_point(size = 2, alpha = 0.6)+ 
  facet_wrap(~am)

ggplot(data = mtcars, aes(x = wt, y = mpg))+
  geom_point(size=2, alpha=0.6)+
  facet_grid((am~cyl))

# 3.3
ggplot(data = mtcars, aes(x=wt, y=mpg, col=factor(cyl)))+
  geom_point(size=2, alpha=0.6)+
  stat_smooth( method='lm')

ggplot(data = mtcars, aes(x = wt, y=mpg, col=factor(cyl)))+
  geom_point(size = 2, alpha=0.6)+
  stat_smooth(aes(group=1), se=FALSE, lwd=0.5, col='gray')

# 3.4
ggplot(data=mtcars, aes(x=factor(cyl)))+
  geom_bar()

# 3.5
ggplot(data=mtcars, aes(x=wt))+
  geom_histogram(bins=10)

# 3.6
ggplot(mtcars, aes(x=factor(cyl), y=mpg))+
  geom_boxplot()

# 3.7
ggplot(mtcars, aes(x=factor(cyl), fill=factor(am)))+
  geom_bar(position='fill')

ggplot(mtcars, aes(x = factor(cyl), fill=factor(am)))+
  geom_bar(position='dodge')

ggplot(mtcars, aes(x = factor(cyl), fill=factor(am)))+
  geom_bar(position='stack')

# 3.8 line plots
library(readr)
library(dplyr)
library(tidyr)
nyc_wide <- read_csv("c:/DataScience/INFO 332/nyc_weather_wide.csv")
nyc_long <- nyc_wide %>%
  gather(day, Temperature, day1:day31, na.rm=TRUE) %>%
  mutate(day=extract_numeric(day))
nyc_long$month = factor(nyc_long$month, levels=c('Jan','Feb','Mar','Apr', 'May', 'Jun',
                                                 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
ggplot(nyc_long, aes(day, Temperature))+
  geom_line()+
  facet_wrap(~month)+
  labs(x = "Day of month", y="Temperature (F)", 
       title="August was the hottest month in NYC in 2016",
       subtitle="2016 daily average temperatures in central park",
       caption = "Source: National Weather Service")+
  theme_bw()
