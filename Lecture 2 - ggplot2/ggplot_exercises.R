# ggplot2 library
library(ggplot2)

## Exercise 1
diamonds %>%
ggplot(aes(factor(cut), price, fill=cut)) + 
  geom_boxplot() + 
  ggtitle("Diamond Price according Cut") + 
  xlab("Type of Cut") + 
  ylab("Diamond Price U$") + 
  coord_cartesian(ylim=c(0,7500))
ggsave('./img/ex1.png')



## Exercise 2
diamonds %>%
ggplot(aes(factor(color), (price/carat), fill=color)) +
  geom_violin() + 
  ggtitle("Diamond Price per Carat according Color") + 
  xlab("Color") + ylab("Diamond Price per Carat U$")
ggsave('./img/ex2.png')

## Exercise 3
ggplot(data=diamonds,aes(x=price, group=cut, fill=cut)) + 
  geom_density(adjust=1.5)
ggsave('./img/ex3.png')

## Exercise 4
ggplot(data=diamonds,aes(x=price, group=cut, fill=cut)) + 
  geom_density(adjust=1.5 , alpha=0.2)
ggsave('./img/ex4.png')

## Exercise 5
ggplot(data=diamonds,aes(x=price, group=cut, fill=cut)) + 
  geom_density(adjust=1.5, position="fill")
ggsave('./img/ex5.png')
