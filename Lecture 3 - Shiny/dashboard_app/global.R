library(shiny) # Well, you know this one
library(shinydashboard) # Library to make the layout with sidebar, header
library(dplyr) # Data reshaping
library(ggplot2) # Plots
library(plotly) # Make a nicer Javascript plot out of ggplot

act_df <- read.csv("tourist_activity.csv")
rev_df <- read.csv("revenue_usd.csv")