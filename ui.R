ui <- function(request){

  dashboardPage(

    skin = "blue",
    dashboardHeader(
      title = span(img(
        src = b64,
        height = '38',
        width = '38',style ="margin-bottom: 7px;",
      ), "iMESc",style = "color: white; margin-left: -10px; font-size: 22px; font-family: 'Alata', sans-serif;margin-bottom: 2px;"),
      titleWidth = 150
    ),

    dashboardSidebar(
      extendShinyjs(
        text = "
shinyjs.collapse = function(boxid) {
$('#' + boxid).closest('.box').find('[data-widget=collapse]').click();
}",
functions = 'collapse'
      ),
useShinyjs(),
use_cicerone(),
introjsUI(),
width = 150,

tags$head(tags$style(
  HTML("
pre { white-space: pre-wrap; word-break: keep-all; }
@import url('https://fonts.googleapis.com/css2?family=Alata&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bevan&display=swap');
@import url(https://use.fontawesome.com/releases/v6.0.0/css/all.css);

  .tabbable > .nav > li[class=active]    > a {border-bottom: 3px solid SeaGreen;background: white;}



  .tabbable > .nav > li[class=hover]    > a {border-bottom: 3px solid SeaGreen;background: white;}

#Select1{border: 1px solid #dd4b39;}


 #transform_button .selectize-control.single .selectize-input:after{
          content: none;}

.shiny-notification{

  top: 50%;
  left: 50%;
  bottom: 5%;
  right: 5%;
  border: 2px solid SeaGreen;
  color: black;
  font-size: 15px;
  background-color: white;
  text-align: center;
  opacity: 1;

}
  .shiny-split-layout>div {overflow: visible;}
      h3{font-weight: bold;}
      label{ color: #0D47A1; font-size: 12 px;}
      .box { margin-left: -5px; margin-right: -10px;  margin-bottom: 10px; margin-top: -3px; }
      .box-body { margin-left: -5px; margin-right: -10px; margin-bottom: 10px;margin-top: 15px;  }
       /* blue */

      .skin-blue .main-header .logo {background-color: #05668D;;}
       /* green */
      .skin-blue .main-header .navbar {background-color: #05668D;}
      .skin-blue .main-sidebar {background-color: #F5F7FA;}

  .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                              color: #05668D;
                              }
 .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: SeaGreen;
 }
     .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                          background-color: SeaGreen;
                          color: rgb(0,144,197);font-weight: bold;
     }
.popify {z-index: 1071 }
    .skin-blue .main-sidebar {
                                background-color: #05668D;
                                }

.newclass{
background: red
}
  "

  )
)),

sidebarMenu(   id = "tabs",
  div(

    id = "sidebar-main",
    div(
      style = "background-color:  #05668D; font-size: 13px",
      class = "sidebar-menu",
      menuItem(
        div(icon("fas fa-home"), HTML('&nbsp;'), "Introduction", style = "margin-left: -8px; color: white; font-size: 14px; margin-top: -2px;margin-bottom: -2px;"),
        tabName = "menu_intro"
      ),
      menuItem(
        div(icon("fas fa-database"), HTML('&nbsp;'), "Data Bank", style = "margin-left: -8px; color: white; font-size: 14px; margin-top: -2px;margin-bottom: -2px;white-space: normal;", id="MENU_databank",
            class='.databank_page'),
        tabName = "menu_upload"
      ),
      menuItem(
        div(icon("fas fa-binoculars"), HTML('&nbsp;'), "Pre-processing",p(" & descriptive tools", style = "margin-left: 5px"), style = "margin-left: -8px; color: white; font-size: 14px; margin-top: -2px;margin-bottom: -2px;white-space: normal;"),
        tabName = "menu_explore"
      ),
      menuItem(
        div(
          icon("fas fa-braille"),
          HTML('&nbsp;'),
          "Self-Organizing",
          p("Maps", style = "margin-left: 30px"),
          style = "margin-left: -8px; color: white; font-size: 14px; margin-top: -2px;margin-bottom: -2px;"
        ),
        tabName = "menu_som"
      ),
      menuItem(
        div(
          icon("fas fa-network-wired"),
          HTML('&nbsp;'),
          "Hierarchical",
          p("Clustering", style = "margin-left: 30px"),
          style = "margin-left: -8px; color: white; font-size: 14px; margin-top: -2px;margin-bottom: -2px;"
        ),
        tabName = "menu_hc"
      ),
      menuItem(
        div(
          icon("fas fa-tree"),
          icon("fas fa-tree", style = "margin-left: -8px;"),icon("fas fa-tree", style = "margin-left: -8px;"),
          HTML('&nbsp;'),
          "Random Forest"
          ,
          style = "margin-left: -8px; color: white; font-size: 14px; margin-top: -2px;margin-bottom: -2px;"
        ),
        tabName = "menu_rf"
      ),


      menuItem(
        div(icon("fas fa-map"), HTML('&nbsp;'), "Spatial tools", style = "margin-left: -8px; color: white; font-size: 14px; margin-top: -2px;margin-bottom: -2px;"),
        tabName = "menu_maps"
      ),

      menuItem(
        div(
          icon("fas fa-pencil-ruler"),
          HTML('&nbsp;'),
          "Diversity tools",
          style = "margin-left: -8px; color: white; font-size: 14px; margin-top: -2px;margin-bottom: -2px;"
        ),
        tabName = "menu_div"
      ),
      div(
        tags$style(HTML(
          ".footer {
        margin-left: 5px;
        font-size: 12px;
             position: absolute;
             bottom: 0;
             width: 100%;
             height: 40px; /* Set the fixed height of the footer here */

           }")),
        div(class="footer",
            em("Last update:"),last_update,
            #p(em("by: Danilo C Vieira")),
            style="background: transparent; color: white"),

      )
    )


  )
)
    ),
dashboardBody(

  fluidRow(

    div(
      tags$style(".pretty.p-default input:checked~.state label:after {background-color: SeaGreen !important;}"),
      tags$head(tags$style(
        HTML(
          "

.choosechannel .btn {
border-radius: 0px 0px 0px 0px;
background: white;
}


#newtip .tooltip {
    position: relative;
}

@keyframes glowing {
                 0% { background-color: SeaGreen; box-shadow: 0 0 5px SeaGreen;color: white }
                 50% { background-color: white; box-shadow: 0 0 30px SeaGreen;color: SeaGreen }
                 100% { background-color: SeaGreen; box-shadow: 0 0 5px SeaGreen; }
               }

@keyframes glowing2 {
                 0% { background-color: #0093fcff; box-shadow: 0 0 5px #0093fcff;color: white }
                 50% { background-color: white; box-shadow: 0 0 30px #0093fcff;color: #0093fcff }
                 100% { background-color: #0093fcff; box-shadow: 0 0 5px #0093fcff; }
               }

@keyframes glowing3 {
                 0% { background-color: transparent; box-shadow: 0 0 5px #0093fcff; }
                 50% { background-color: white; box-shadow: 0 0 30px #0093fcff;color: #0093fcff }
                 100% { background-color: transparent; box-shadow: 0 0 5px #0093fcff; }
               }


 div[datatitle]:hover:after{
content: attr(datatitle);
padding: 2px 4px;
color: white;
position: absolute;
max-width: 100px;
top: 80%;
display: block;
z-index: 9999;
background: black;
font-size: 12px;
border-radius: 3px 3px 3px 3px;
 }
#mtry_grid{
margin: 0px;
padding: 0px;
}

#getpool {
margin: 0px;
padding: 0px;
}
#getpool2 {
margin: 0px;
padding: 0px;
}
#getDP {
margin: 0px;
padding: 0px;
}
#user_bp {
margin: 0px;
padding: 0px;
}

.finesom_btn .btn{
border-radius: 0px 0px 0px 0px;
border: 0px solid white;
white-space: nowrap;
margin: 0px;
display:inline-block;
color: #0D47A1
}


 .map_control_style .radio {
border-radius: 0px 0px 0px 0px;
border: 0px solid white;
white-space: nowrap;
margin: 0px;
padding: 0;
}
.map_control_style .form-control {
border-radius: 0px 0px 0px 0px;
border: 1px solid #E8E8E8;

white-space: nowrap;
margin: 0px;
display:inline-block;
line-height: 0px;
max-height: 20px;
padding: 0;
padding-left: 3px;
background: white;
}

.map_control_style .btn {
border-radius: 0px 0px 0px 0px;
border: 1px solid #E8E8E8;

background: white;
white-space: nowrap;
margin: 0px;
display:inline-block;
cursor: pointer;
max-height: 20px;
padding: 0;
padding-left: 3px;
}
.map_control_style .checkbox{
border-radius: 0px 0px 0px 0px;
border: 0px solid white;
margin: 0px;
padding: 0;
}



.map_control_style .shiny-input-container .selectize-input {
border-radius: 0px 0px 0px 0px;
white-space: nowrap;
margin: 0px;
display:inline-block;
max-height: 20px;
padding: 0;
padding-left: 1px;
}

.map_control_style .shiny-input-container{
  border-radius: 0px 0px 0px 0px;
  border: 0px solid white;
white-space: nowrap;
margin: 0px;
display:inline-block;
padding: 0;


}

.well2{
 min-height: 20px;
    padding-top:1px;
    padding-bottom:1px;
    margin-bottom: 1px;
    background-color: #f5f5f5;
    border: 1px solid #e3e3e3;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgb(0 0 0 / 5%);
    box-shadow: inset 0 1px 1px rgb(0 0 0 / 5%)
}
.ident-picker {
    padding-top:1px;
    padding-bottom:1px;
    margin-bottom: 1px;
    margin-top: 1px;
    background-color: #f5f5f5;
    border: 1px solid #e3e3e3;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgb(0 0 0 / 5%);
    box-shadow: inset 0 1px 1px rgb(0 0 0 / 5%)
            }
 #map_side02 .modal-dialog { width: fit-content !important; }
          .btn:hover{
  background-color: SeaGreen;
   color: black
          }

#fac_convert .modal-dialog { width: fit-content !important; }
#upload_mod2.modal-dialog { width: fit-content !important; }
#upload_mod2.modal-dialog { width: fit-content !important; }
#upload_mod3. modal-dialog {
 width: fit-content !important;
z-index: 1
}


div#driver-highlighted-element-stage {
  outline: 5000px solid rgba(0, 0, 0, .75)
}

.modal-content {

z-index: 999
}



div#driver-highlighted-element-stage.driver-stage-no-animation{

    border: 3px solid Gold;

}
.modal-backdrop.in{
   opacity: 0.1;
}
.modal.in .modal-dialog  {
 border: 2px solid SeaGreen;
box-shadow: 0 0 50px SeaGreen
}
.modal-content{
 border: 0px solid transparent;
}
div#driver-highlighted-element-stage {

    outline: 5000px solid rgba(0, 0, 0, .75);
}


  #teste_style .btn-group {color: red}

  #shp{height: 100px;font-size: 20px}


.btn:focus{
  background-color: SeaGreen;
   color: white
          }


.btn-shp_button{
  border-radius: 0px;
  text-align: left;
background-color: transparent;
border: 0px solid transparent;
margin: 0px
}



.btn-button_active2{
  border-radius: 0px;
  text-align: left;
padding-left: 20px
}
.btn-button_active2:focus{
  background-color: white;
   color: SeaGreen
}
.btn-button_active2.active {
  background-color: white;
  color: SeaGreen;
  border: 2px solid SeaGreen;
         }



.btn-button_active:focus{
  background-color: SeaGreen;
   color: white
}
.btn-button_active.active {
  background-color: white;
  color: SeaGreen;
         }

#chain {  height: 200px;    overflow: auto;   border-radius: 0px;color: red}

.btn-button_active3{
  border-radius: 0px;
  text-align: left;
padding-left: 1px;
white-space: normal;
margin: -1px
}
.btn-button_active3:focus{
  background-color: white;
   color: SeaGreen
}
.btn-button_active3.active {
  background-color: white;
  color: SeaGreen;
         }

.btn-att {
text-shadow: -1px -1px 0px white, -1px -1px 0px white;
padding: 6px;
width: 150px
}

.btn-att:hover{
font-weight: bold;
   color: SeaGreen;

text-shadow: none;
width: 150px
          }

.btn-att:focus{
font-weight: bold;
   color: SeaGreen;


text-shadow: none;
width: 150px
}




          .myClass {
        font-size: 15px;
        line-height: 50px;
        text-align: left;
        font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;
        padding: 0 15px;
        overflow: hidden;
        color: white;
    }



    "
        )
      )),
tags$script("$(document).on('click', '.name-opt a', function (evt) {
  evt.preventDefault(); Shiny.setInputValue('name',this.dataset.name);
});"
),
tags$script(
  HTML(
    '
      $(document).ready(function() {
        $("header").find("nav").append(\'<span class="myClass"> An Interactive Machine Learning App for Environmental Science </span>\');
      });



     '
  )
),
tags$script("$(document).on('shiny:connected', function(event) {
var myWidth = $(window).width();
Shiny.onInputChange('shiny_width',myWidth)

});"),

tags$script("$(document).on('shiny:connected', function(event) {
var myHeight = $(window).height();
Shiny.onInputChange('shiny_height',myHeight)

});"),

fluidPage(
  useShinyjs(),
  add_busy_spinner(spin = "hollow-dots",height="20px", color="yellow",width="20px", margins = c(20, 100)),
  div(
    style = "margin-left: -15px; margin-right:-15px;",
    column(12,uiOutput("menutitle")),
    tabsetPanel(
      type = "hidden",
      tabPanel("intro",
               tabItems(
                 tabItem(
                   tabName = "menu_intro",
                   tabsetPanel(
                     tabPanel(value="intro1",
                              strong("Welcome"),
                              textintro(),

                              column(12,
                                     column(12,
                                            #h4(strong("Take a tour",style="color: #05668D"))
                                            #bsButton(inputId = "tour_databank",label = span(img(src=tutor_icon,height='40',width='40'),"Start a tour"),style="button_active3")
                                            ))
                             ),
                     tabPanel(strong("Authors"),value="intro2", textauthors()),
                     tabPanel(strong("Workflow"),value="intro3",
                              column(12,br())
                     ),
                     tabPanel(
                       strong("Running offline"),value="intro4",
                       column(12,
                              column(12, br(), textoffline()))),
                     tabPanel(
                       strong("Version"),value="intro5",
                       column(12, style="margin-top 25px",
                              h4(style="margin-top 25px",span("iMESc", style="font-family: 'Alata', sans-serif;")),
                              p(version),
                              p(strong("Last update:"),last_update)
                              ,
                              p(em("developed by Danilo C Vieira in  R, version 4.0.5; RStudio, version 1.4, and Shiny package, version 1.6.0."))

                       )),
                     tabPanel(
                       strong("Refereces"),value="intro5",
                       column(12,
                              column(12, br(), textrefs()))),
                     tabPanel(
                       strong("Packages"),value="intro5",
                       column(12,
                              verbatimTextOutput({"package_refs"}))
                     )
                   )),
                 # training panel
                 tabItem(tabName = "menu_upload",
                         uiOutput("menu_bank_out")),
                 tabItem(tabName = "menu_explore",
                         uiOutput("menu_upload_out")),
                 tabItem(tabName = "menu_som",
                         column(12,uiOutput('som_datalist'))),
                 tabItem(tabName = "menu_hc",
                         uiOutput('clustering_panel')),
                 tabItem(
                   tabName = "menu_rf",
                   div(uiOutput("choices_rf")),
                   div(
                     tabsetPanel(id = "rf_tab",
                                 tabPanel(strong("1. Training"),value="rf_tab1",
                                          uiOutput("controlrf"))

                     )
                   )),
                 tabItem(tabName = "menu_dt",
                         uiOutput("dt_panel")
                 ),
                 tabItem(  tabName = "menu_maps",
                           column(12,uiOutput("map_panel"))

                 ),
                 tabItem(tabName = "menu_div",
                         column(12,
                                uiOutput("divtabs"))
                 )
               )
      )
    )
  )
)
    )
  )
)
  )
}
