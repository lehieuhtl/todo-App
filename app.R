install.packages('shiny')
install.packages('shinydashboard')
install.packages('shinyjs')
install.packages('clock')

library(shiny)
library(shinydashboard)
library(shinyjs)
library(clock)

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
    
    #Addition of clock
    box(
      width = 3,
      solidHeader = TRUE,
      title = "Clock",
      clockOutput("clock", width = "100%")
    )
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
    tasks_html = lapply(tasks(), function(task) {
      tags$p(
        style = "border-bottom: 1px solid #ddd; padding-bottom: 5px;",
        HTML(paste("<strong>", task, "</strong>")))
    })
    tagList(tasks_html)
  })

  
    #Updates the clock every second
  observe({
    shinyjs::runjs("
      setInterval(function() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();
        var timeString = (hours < 10 ? '0' : '') + hours + ':' + (minutes < 10 ? '0' : '') + minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
        document.getElementById('clock').innerText = timeString;
      }, 1000);
    ")
  })
}
  



shinyApp(ui, server)
runApp(Users/hieule/Desktop/MiscProjects/R.projects/todo)







