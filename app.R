install.packages('shiny')
install.packages('shinydashboard')
install.packages('shinyjs')
install.packages('clock')
install.packages('htmlwidgets')


library(shiny)
library(shinydashboard)
library(shinyjs)
library(clock)
library(htmlwidgets)

#Creating a simple to-doList
ui = dashboardPage(
  dashboardHeader(title = "To-do List Simple"),
  dashboardSidebar(),
  dashboardBody(
    #Add task Input
    textInput("task", "Task:"),
    actionButton("add", "Add Task"),
    
    #Display todo list Output
    h3("What am i doing?"),
    uiOutput("todolist"),
    # Addition of clock

  ),
  # Include the external JavaScript file
  includeScript("clock.html")
)

#Server logic
server = function(input, output, session) {
  tasks = reactiveVal(character(0))
  
  observeEvent(input$add, {
    new_task = isolate(input$task)
    if (new_task != "") {
      tasks(c(tasks(), new_task))
      updateTextInput(session, "task", value = "")
    }
  })
  #Display the list
  output$todolist = renderUI({
    tasks_html = lapply(tasks(), function(task) {
      tags$p(
        style = "border-bottom: 1px solid #ddd; padding-bottom: 5px;",
        HTML(paste("<strong>", task, "</strong>")))
    })
    tagList(tasks_html)
  })

}
  



shinyApp(ui, server)
runApp(Users/hieule/Desktop/MiscProjects/R.projects/todo)







