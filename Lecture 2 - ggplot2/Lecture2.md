---
title: "ggplot2"
author: "Pablo Maldonado"
date: "October 20, 2016"
output: ioslides_presentation
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
```

# Hands-on with ggplot

## Recap:

We did some plots last time, but they where a bit ugly (aesthetically and synthactically).

Let's do something else this time.
```{r, echo=TRUE}
library(ggplot2)
library(dplyr)


```

----
```{r, echo=TRUE}
head(diamonds)
```

## Grammar of graphics

A **grammar of graphics** is a structured way to create graphs. We can think of a plot in terms of layers, where each layer has:

- **Data**: No need to explain this one.
- **Aesthetics**: Map variables on the data set to graphic primitives, like size, color, x, y. 
- **Geometry**: Visual display and custom parameters.



# Grammar of graphics in ggplot2




## Diving deeper

Two basic constructs:

  - **plot**: coord, scale, facet and layers
  - **layer**: data mapping, stat, geom, position

Plot is the canvas on which we paint, the layer is the things we paint there.


## Continuous vs continuous


```{r, echo=TRUE}

diamonds %>% 
  ggplot(aes(x=carat,y=price))+
  geom_point()

```


## Discrete vs Continuous

```{r, echo=TRUE}
diamonds %>%
  ggplot(aes(x=cut,y=price))+
  geom_point()
```



## Introducing `position`

```{r, echo=TRUE}
p <- 
diamonds %>%
  ggplot(aes(x=cut,y=price))+
  geom_point(position = "jitter")
```

---- 
```{r, echo=TRUE}
p
```



## We can change the `geom`, too!


```{r, echo=TRUE}
p <- 
diamonds %>% 
  ggplot(aes(x=cut,
      y=price))+
  geom_boxplot(position = "dodge")
```

---- 
```{r, echo=TRUE}
p
```

## Combining layers

```{r, echo=TRUE}
p <- 
diamonds %>%
  ggplot(aes(x=cut,y=price))+
  geom_point(position = "jitter")+
  geom_boxplot(position = "dodge", 
               fill = "blue",
               color="red", 
               alpha=0.3)


```

---- 
```{r, echo=TRUE}
p
```

## Adding some color

```{r, echo=TRUE}
p <- 
diamonds %>%
  ggplot(aes(x=carat,
             y=price,
             color=color))+
  scale_color_hue()+
  geom_point()

```

---- 
```{r, echo=TRUE}
p
```

## Separate facets per cut

```{r, echo=TRUE}
p <- 
diamonds %>%
  ggplot(aes(x=carat,
             y=price,
             color=color))+
  scale_color_hue()+
  geom_point()+
  facet_wrap(~cut)
```

---- 
```{r, echo=TRUE}
p
```



## Add a fitted curve


```{r, echo=TRUE}
p <- 
diamonds %>%
  ggplot(aes(x=carat,
             y=price,
             color=color))+
  scale_color_hue()+
  geom_point()+
  geom_smooth(aes(x=carat,y=price),
              stat="smooth", 
              method="loess")+
  facet_wrap(~cut)
  
  
```

---- 
```{r, echo=TRUE}
p
```



## Exercise time!