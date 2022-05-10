
observeEvent(input$guide2_cicerone_next$highlighted,{
  req(input$guide2_cicerone_next$highlighted=="c002")
  runjs("Shiny.setInputValue('view_datalist', 'factors');")
  delay(800, guide2$init()$start(step=8))

})

observeEvent(input$guide2_cicerone_next$highlighted,{
  req(input$guide2_cicerone_next$highlighted=="c002" &
        input$guide2_cicerone_next$previous=="c002")
  delay(800, guide3$init()$start())

})
