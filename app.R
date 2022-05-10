
rm(list=ls())

source('global.R')
shinyApp(ui, server)
#runGitHub('iMESc_pred','DaniloCVieira', ref="main")
