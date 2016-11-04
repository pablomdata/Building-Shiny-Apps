# How to deploy your Shiny app to shinyapps.io

- Install the library `rsconnect`.
- Open an account in www.shinyaps.io
- Log into your account, click on your avatar (upper right corner) and choose Tokens.
- Click on "Add Token", and then on "Show",
- On the window that pops up, click on "Show secret", and copy the R code to the clipboard. It should look like this:

```
rsconnect::setAccountInfo(name="<ACCOUNT>", token="<TOKEN>", secret="<SECRET>")
```
- Set your working directory as the directory of your app
  - On the lower right window in RStudio, go for the tab "Files", 
  then browse to the directory of your app and click on "More". Select "Set as working directory".
  
- You are almost done. Just run `rsconnect::deployApp()` from the R console.

