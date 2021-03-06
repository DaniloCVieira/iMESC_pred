
rm(list=ls())
version<-strong("Version: 2.1.0.1")
last_update<-"08-04-2022"
last_update<-format(Sys.Date(),"%d-%m-%Y")

list.of.packages <- c('shinydashboard','shinydashboardPlus','shinyjs','shiny',"e1071",'readxl','vegan',"party",'caret','viridisLite','aweSOM','sp','raster','Rcpp','rgdal','gstat','ggspatial','ggplot2','sf','class','shinyWidgets', 'randomForestExplainer','data.table',"ggpubr", "shinyBS","terra","purrr","NbClust", "colorRamps","DBI","shinyBS","wesanderson","colorspace","gplots","dendextend","kohonen","shinypanels","writexl","DT","gbRd", 'segRDA',"shinyjqui","mboost","partykit","Metrics", "shinybusy", "shinycssloaders","plot3D","imputeMissings","geodist","ggrepel",'pdp',"sortable","colourpicker",'oceanmap',"rgl",'cicerone',"rintrojs")




# create help data frame


if(!length(grep("connect/apps",getwd()))>0){
  #list of packages required


  #checking missing packages from list
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

  #install missing ones
  if(length(new.packages)) install.packages(new.packages, dependencies = TRUE)
}
library('rintrojs')
library('cicerone')
library('oceanmap')
library("colourpicker")
library('sortable')
library('pdp')
library("geodist")
library("plot3D")
library('imputeMissings')
library("shinycssloaders")

library(rgl)
library('shinybusy')
library("Metrics")
library("shinyjqui")
library("colorspace")
library("writexl")
library(wesanderson)
library(e1071)
library(DBI)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)
library(shiny)
library(readxl)
library(vegan)
library(caret)
library(viridisLite)
library(aweSOM)
library(sp)
library(raster)
library(rgdal)
library(gstat)
library(ggspatial)
library(ggplot2)
library(sf)
library(class)
library(shinyWidgets)
library(randomForestExplainer)
library(data.table)
library(purrr)
library(NbClust)
library("party")
library(shinyBS)
source('meta/funs_texts.R')
library(ggpubr)
library("colorRamps")
library(kohonen)
library("segRDA")
library("gplots")
library(dendextend)
library("ggrepel")


source("meta/funs_pre_treat.R")
source("meta/funs_sominter.R")
source("meta/funs_somplot.R")
source("meta/funs_mapplot.R")
source("meta/funs_rf_inter.R")
source("meta/BC.R")
source("meta/funs_interp.R")
source("meta/funs_3D.R")
source("meta/funs_3D_2.R")
#file.remove(paste0(getwd(), "/", 'bookmarks.rds'))
js<-'$(document).keyup(function(event) {
    if (event.keyCode == 13) {
        $("#data_confirm").click()'



convertMenuItem <- function(mi, tabName) {
  mi$children[[1]]$attribs['data-toggle'] = "tab"
  mi$children[[1]]$attribs['data-value'] = tabName
  if (length(mi$attribs$class) > 0 && mi$attribs$class == "treeview") {
    mi$attribs$class = NULL
  }
  mi
}

b64 <- base64enc::dataURI(file = "meta/logo.png", mime = "image/png")
split_icon <- base64enc::dataURI(file = "meta/split_icon.png", mime = "image/png")
smw_icon <- base64enc::dataURI(file = "meta/smw_icon.png", mime = "image/png")
pw_icon <- base64enc::dataURI(file = "meta/pwrda_icon.png", mime = "image/png")
na_icon <- base64enc::dataURI(file = "meta/na_icon.png", mime = "image/png")
tutor_icon <- base64enc::dataURI(file = "meta/tutor_icon.png", mime = "image/png")

steps<-read.csv("helps/help.csv",sep=";")
steps2<-read.csv("helps/help2.csv",sep=";")
steps3<-read.csv("helps/help3.csv",sep=";")
#Esquema <- base64enc::dataURI(file = "meta/Esquema.png", mime = "image/png")

guide1 <-Cicerone$
  new(id = "guide1", allow_close = T, animate=F)$
  step(
    el = steps$el[1],
    title = steps$title[1],
    description = steps$description[1],
    position=steps$position[1],
    is_id=steps$is_id[1]
  )$
  step(
    el = steps$el[2],
    title = steps$title[2],
    description = steps$description[2],
    position=steps$position[2],
    is_id=steps$is_id[2]
  )$
  step(
    el = steps$el[3],
    title = steps$title[3],
    description = steps$description[3],
    position=steps$position[3],
    is_id=steps$is_id[3]
  )$
  step(
    el = steps$el[4],
    title = steps$title[4],
    description = steps$description[4],
    position=steps$position[4],
    is_id=steps$is_id[4]
  )$
  step(
    el = steps$el[5],
    title = steps$title[5],
    description = steps$description[5],
    position=steps$position[5],
    is_id=steps$is_id[5]
  )$
  step(
    el = steps$el[6],
    title = steps$title[6],
    description = steps$description[6],
    position=steps$position[6],
    is_id=steps$is_id[6]
  )$
  step(
    el = steps$el[7],
    title = steps$title[7],
    description = steps$description[7],
    position=steps$position[7],
    is_id=steps$is_id[7]
  )




guide2 <- {Cicerone$
    new(id = "guide2", allow_close = T, animate=F)$
    step(
      el = steps2$el[1],
      title = steps2$title[1],
      description = steps2$description[1],
      position=steps2$position[1],
      is_id=steps2$is_id[1]
    )$
    step(
      el = steps2$el[2],
      title = steps2$title[2],
      description = steps2$description[2],
      position=steps2$position[2],
      is_id=steps2$is_id[2]
    )
}




guide3 <- {Cicerone$
    new(id = "guide3", allow_close = T, animate=F)$
    step(
      el = steps3$el[1],
      title = steps3$title[1],
      description = steps3$description[1],
      position=steps3$position[1],
      is_id=steps3$is_id[1]
    )$
    step(
      el = steps3$el[2],
      title = steps3$title[2],
      description = steps3$description[2],
      position=steps3$position[2],
      is_id=steps3$is_id[2]
    )$
    step(
      el = steps3$el[3],
      title = steps3$title[3],
      description = steps3$description[3],
      position=steps3$position[3],
      is_id=steps3$is_id[3]
    )$
    step(
      el = steps3$el[4],
      title = steps3$title[4],
      description = steps3$description[4],
      position=steps3$position[4],
      is_id=steps3$is_id[4]
    )$
    step(
      el = steps3$el[5],
      title = steps3$title[5],
      description = steps3$description[5],
      position=steps3$position[5],
      is_id=steps3$is_id[5]
    )

}


