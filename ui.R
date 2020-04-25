

# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Canadian Census Explorer"),
  
  tabsetPanel(
    tabPanel(
      "All vectors",
      tags$p("All census variables."),
      dataTableOutput("c_dt_all")
    ),
    tabPanel(
      "Search vectors",
      tags$p("Search census variables by keyword."),
      sidebarLayout(
        sidebarPanel(
          width = 2,
          textInput("c_search_keyword", label = "Keyword", placeholder = "search term"),
          selectInput("c_search_year",
                      "Dataset",
                      c(
                        "2016 Canada Census" = "CA16", 
                        "2016 Canada Census xtab" = "CA16xSD", 
                        "2011 Canada Census" = "CA11", 
                        "2011 Canada Census xtab" = "CA11xSD", 
                        "2006 Canada Census" = "CA06",
                        "2006 Canada Census xtab" = "CA06xSD", 
                        "2001 Canada Census" = "CA01",
                        "2001 Canada Census xtab" = "CA01xSD"
                      ),
                      multiple = FALSE),
          actionButton("c_search", "Search")
        ),
        mainPanel(width = 10,
                  dataTableOutput("c_dt"))
      )
    ),
    tabPanel(
      "Search data",
      tags$p("Search census data by variable."),
      sidebarLayout(
        sidebarPanel(
          width = 2,
          textInput("c_search_vector", label = "Variable", placeholder = "search variable"),
          selectInput(
            "c_search_data_year",
            "Dataset",
            c(
              "2016 Canada Census" = "CA16", 
              "2016 Canada Census xtab" = "CA16xSD", 
              "2011 Canada Census" = "CA11", 
              "2011 Canada Census xtab" = "CA11xSD", 
              "2006 Canada Census" = "CA06",
              "2006 Canada Census xtab" = "CA06xSD", 
              "2001 Canada Census" = "CA01",
              "2001 Canada Census xtab" = "CA01xSD"
            ),
            multiple = FALSE
          ),
          selectInput(
            "c_search_data_level",
            "Level",
            c(
              "CMA" = "CMA",
              "CD" = "CD",
              "CSD" = "CSD",
              "CT" = "CT",
              "DA" = "DA"
            ),
            multiple = FALSE
          ),
          actionButton("c_search_data", "Search")
        ),
        mainPanel(
          width = 10,
          tags$h4("Variable description"),
          tableOutput("c_search_vector_desc"),
          tags$h4("Census data for variable"),
          dataTableOutput("c_dt_data")
        )
      )
    )
  )
))
