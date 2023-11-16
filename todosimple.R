install.packages('shiny')
install.packages('shinydashboard')
library(shiny)
library(shinydashboard)

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
    uiOutput("todolist")
  )
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
    HTML(paste(tasks(), collapse = "<br/>"))
  })
}

shinyApp(ui, server)
runApp(Users/hieule/Desktop/MiscProjects/R.projects/todo)







