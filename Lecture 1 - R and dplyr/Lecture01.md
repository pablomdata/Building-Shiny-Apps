# Quick Intro

## About me:

- PhD Applied Mathematics, Université Pierre et Marie Curie, Paris, France.

- 3+ years experience as Adjunct Professor in Mexico.

- 6+ years experience in mathematical modelling (in one way or another).

- Freelance Data Science Consultant.

- Building Shiny apps for happy clients since 2015.

## This course

- Minimal coherent stack to help you **get things done**.

- NOT a course in web development.

- No previous knowledge assumed.

- **Topics:** 
    - Data manipulation.
    - Shiny.
    - Gathering data.
    - Maps and Graphics. 
    

## Web development

Most web applications consist of three layers that interact with each other.

1. **Front-end**: what the user sees and interacts with (HTML, CSS, Javascript/jQuery).

2. **Middleware**: communicates with the front and back-end
      - Process HTTP requests.
      - Connect to the server.
      - Interact with APIs.
      - Manage cookies, authentication, sessions.

3. **Back-end**: Data storage, process and analysis.


## Why Shiny?

- Get off the ground quickly, using R only.
- Analysts can easily communicate their results.
- Good for applications with more algorithms than users.
- Compatible with other excellent graphics libraries.
- Used in production!

# R and dplyr

## What is R?
- Created by NZ Researchers Ross Ihaka and Robert Gentleman in 1991.

- Derived from the S language, developed in the 1950's in Bell Labs. 

- Free (both as in "free beer" and "free person") statistical package.


## What is R good for?

- Extensive package library for math and statistics.

- Decent graphic libraries.

- Quick way to build prototypes, and in many cases, production ready applications.

- Good alternative to LaTeX.

- You can also make slides :)

## What is R not so good for?

- Computations that require intensive data crunching.

- Packages don't play well with each other.

- The documentation can be unreadable, in general little attention to good software development practices, which can become annoying.




## What is dplyr?
- "A fast, consistent tool for working with data frame like objects, both in memory and out of memory".

- Created by Hadley Wickham (Rice University/RStudio).

- Part of a suite of very useful packages for data manipulation in R (we'll cover ggplot2 as well).



# R in a nutshell
## Basic Syntax
- The assignment operator is <- 
```{r, echo = TRUE}
x <- 1
print(x)
```

You can use "=", but "<-" is preferred by the R community (shortcut: Alt + - in RStudio) 

## Types
```{r, echo = TRUE}
# Vectors and types
x <- c(0.5,0.6) #numeric
x <- c(T,F) #logical
x <- c("a","b","c") #character
x <- c(1+0i,2+4i) #complex

```


```{r, echo = TRUE}
# Compressed notation for vectors with consecutive integers:

x <- 9:29
print(x)
```

## Coercion
```{r, echo = TRUE}
# Coercion to types
x <- 0:6
class(x)

as.logical(x)
as.character(x)
```

## Not always possible!
```{r,echo = T}
x <- c("a","b","c")
as.numeric(x)
```

## Special values in R
- **NA** is used for existing, but useless values.
- **NaN** is used for undefined values, like 0/0.
- **NULL** means unexistant value. 
- There's also **Inf** and **-Inf**.

## Example
```{r, echo=TRUE}

v <- c(1, 2, 3, NA, 5)
sum(v)


v <- c(1, 2, 3, NaN, 5)
sum(v)


v <- c(1, 2, 3, NULL, 5)
sum(v)

```

## Test for values

```{r, echo = TRUE}
is.na(5)
is.na(NaN)
is.nan(NA)

```

## Factors 

```{r, echo = TRUE}
x <- factor(c("yes","no", "yes", "no", "no"))
x
```

Factors are special ways of representing data internally, and they are treated specially by modelling functions.

## Data Frames
```{r, echo = TRUE}

df <- data.frame( Weather = c("Cold","Mild","Cold","Ok")
               , Cities = c("Prague", "Brno", "Ostrava", "Zlin")
               )
df

```

##Loading and inspecting 
```{r, echo=TRUE}
news<-read.csv(".././data/OnlineNewsPopularity/OnlineNewsPopularity.csv")

small <- news[2:5]
head(small) # Too many columns

```

----
```{r,echo=T}
tail(small, n = 3)
summary(small)
```

----
```{r, echo=T}

table(news$data_channel_is_lifestyle)
table(news$data_channel_is_lifestyle, news$data_channel_is_bus)

# Try table(news$data_channel_is_lifestyle, 
# news$data_channel_is_entertainment, news$data_channel_is_bus) !
```


## Histograms
```{r, echo=T}

hist(small$n_tokens_title)

```

## Boxplots

```{r, echo=T}
boxplot(small$n_tokens_title)
```



# dplyr
## A grammar for data manipulation
dplyr provides a function for each basic action with data: 

- filter() (and slice())
- arrange()
- select() (and rename())
- distinct()
- mutate() (and transmute())
- summarise()
- sample_n() (and sample_frac())

which can do many things together with the "%>%" (read "and then")


## Loading dplyr
```{r, echo = TRUE}
library(dplyr)
```


## Example: filter()
```{r, echo = TRUE}
# Filter the articles from a specific day
oldest <- filter(small, timedelta == 731 )
head(oldest, n = 2)

```

## Example: filter() (cont.)
or, using the operator %>%:

```{r, echo = TRUE}
small %>% filter(timedelta==731) %>% head(n=2)
```

In pure R (without dplyr), we can do

```{r, echo = TRUE}
oldest <- small[small$timedelta==731,]
head(oldest, n = 2 )
```

## Example: slice()

slice() filters rows by position, for instance:
```{r, echo = TRUE}

slice(small, 16:20)

```

## Example: arrange()

arrange() orders columns and helps to break ties.

```{r, echo = TRUE}

small %>%
  arrange(timedelta, n_tokens_title, n_tokens_content) %>% 
  head(n=3)

```


## Example: arrange() (cont.)
We can use desc() to arrange a column in descending order.

```{r, echo = TRUE}
small %>% 
  arrange(desc(timedelta), n_tokens_title, n_tokens_content) %>% 
  head(n=3)
```


## Example: select()

We can use select to, well, select specific columns:

```{r, echo = TRUE}

small %>% select(timedelta,n_tokens_content) %>% head(n=2)

```


```{r, echo = TRUE}
small %>% select(-c(n_tokens_title,n_tokens_content)) %>% head(n=2)

```

## Example: select() (cont.)
We can use select() also to rename columns
```{r, echo = TRUE}
small %>% select(words_in_title = n_tokens_title) %>% head(n=3)
```

## Example: rename()
This is useful to rename a column without dropping the other variables

```{r, echo=TRUE}

small %>% rename(words_in_title = n_tokens_title) %>% head(n=3)
```

## Example: distinct()

This function allows us to find unique values in a table
```{r, echo=TRUE}
small %>% distinct(timedelta) %>% head(n=3)

```

```{r, echo=TRUE}
small %>% distinct(timedelta,n_tokens_title) %>% nrow

```

## Example: mutate()
Sometimes we need to add new columns that are function of existing columns, for instance:

```{r, echo=TRUE}
small %>% 
  mutate(title_to_content = n_tokens_title/n_tokens_content
         ,total_unique = n_tokens_content * n_unique_tokens ) %>% 
  head(n=3)

```

## Example: mutate() (cont.)
We can recycle newly created variables!

```{r, echo=TRUE}
small %>% 
  mutate(title_to_content = n_tokens_title/n_tokens_content
         ,percentage = round(100*title_to_content,2) ) %>% 
  head(n=3)

```


## Example: transmute()
Like mutate(), but keeps only the newly created variables


```{r, echo=TRUE}
small %>% 
  transmute(title_to_content = n_tokens_title/n_tokens_content
         ,total_unique = n_tokens_content * n_unique_tokens ) %>% 
  head(n=3)

```


## Sampling: sample_n() and sample_frac()
These two functions allow us to sample randomly a fixed number of rows or a fraction. Use replace = TRUE for a sample with replacement, and you can add weights for the sampling if needed. More info in ?sample_n

## Grouping functions

All the functions above become really useful when we can apply them to groups.


```{r, echo=TRUE}
gps <- news %>% 
  sample_frac(.1)%>%
  group_by(data_channel_is_lifestyle
          ,data_channel_is_world)%>%
  summarise(count=n()
            ,avg_imgs = mean(num_imgs, na.rm = TRUE)
            , avg_videos =mean(num_videos, na.rm = TRUE)) 

```

## Plotting the final results

```{r, echo=TRUE}
barplot(gps$avg_imgs
        , names.arg = c("Other", "Lifestyle", "World")
        , main = "Average number of images")
```


## Another useful plot 

```{r, echo = TRUE}
plot(news$timedelta,news$shares
     , type='l', main = "Number of shares across time"
     , xlab = "Days since acquisition", ylab = "Number of shares")

```

## Hands-on

Try it yourselves! Let's test some hypothesis:

- What are the 5 most shared articles?
- Which channel (among the six described) has the largest average number of shares? does it change across time?
- Which day has the most shares, on average?


## What are the 5 most shared articles?

```{r, echo=TRUE}
news %>% arrange(desc(shares)) %>% select(url,shares) %>% head(n=5)
```




## Which channel has the largest number of shares?

```{r, echo=TRUE}
ex2a <- news %>% 
  group_by(data_channel_is_lifestyle
  , data_channel_is_entertainment
  , data_channel_is_bus
  , data_channel_is_socmed
  , data_channel_is_tech
  , data_channel_is_world)%>% 
  summarise(avg_shares = mean(shares))
  
```
## ... and the plot:

```{r, echo=TRUE}
barplot(ex2a$avg_shares,
        names.arg =c("Other","LS","Ent","Bus","SM","Tech","World"))


```

## Does it change with time?

```{r, echo=TRUE}
ex2b <- news %>% filter(data_channel_is_world ==1) 

plot(ex2b$timedelta,ex2b$shares
     , type='l', main = "Number of shares across time- World"
     , xlab = "Days since acquisition", ylab = "Number of shares")

```

## Which day has the most shares, on average?

```{r, echo=TRUE}
ex3 <- news %>% 
  group_by(weekday_is_monday
  , weekday_is_tuesday
  , weekday_is_wednesday
  , weekday_is_thursday
  , weekday_is_friday
  , weekday_is_saturday
  , weekday_is_sunday)%>% 
  summarise(avg_shares = mean(shares))
```

## and the plot:
```{r,echo = TRUE}
  
barplot(ex3$avg_shares,
        names.arg =c("Mon", "Tue",'Wed', "Thu", "Fri", "Sat", "Sun"))


```

