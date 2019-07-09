library(shiny)

shinyServer(function(input, output, session) {
  # Search census vectors by keyword
  censusSearchDataset <- reactive({
    paste0('CA', substr(paste0(input$c_search_data_year), 3, 4))
  })
  
  observeEvent(input$c_search, {
    vectorsSearch <-
      search_census_vectors(
        input$c_search_keyword,
        paste0('CA', substr(paste0(
          input$c_search_year
        ), 3, 4)),
        type = "Total",
        use_cache = TRUE
      ) # %>%
    if (nrow(vectorsSearch) > 0) {
      vectorsSearch <- vectorsSearch %>%
        child_census_vectors(leaves_only = FALSE)
    }
    # https://github.com/mountainMath/cancensus/pull/95
    # child_census_vectors(leaves_only = FALSE)
    
    output$c_dt = DT::renderDataTable(datatable(
      vectorsSearch,
      #%>%
      # select_(.dots = selectionMetricsDF$Metric),
      extensions = 'Buttons',
      options = dtOptions
        ))
    })
  
  allVectors <- reactive({
    list_census_vectors(censusSearchDataset(), use_cache = TRUE)
  })
  
  observe({
    output$c_dt_all = DT::renderDataTable(datatable(
      allVectors(),
      extensions = 'Buttons',
      options = dtOptions
      )
    )
  })
  
  # Search census data by vector
  observeEvent(input$c_search_data, {
    vectorsSearch <-
      search_census_vectors(
        input$c_search_vector,
        censusSearchDataset(),
        type = "Total",
        use_cache = TRUE
      )  %>%
      child_census_vectors(leaves_only = FALSE)
    
    censusDataSearch <-
      get_census(
        censusSearchDataset(),
        level = input$c_search_data_level,
        regions = list(PR = "59"),
        vectors = input$c_search_vector,
        use_cache = TRUE,
        labels = "short",
        geo_format = NA
      )
    
    output$c_search_vector_desc <-
      renderTable(allVectors() %>% filter(vector == input$c_search_vector))
    output$c_dt_data = DT::renderDataTable(
      datatable(
        censusDataSearch %>%
          filter(Type == input$c_search_data_level),
        #%>%
        # select_(.dots = selectionMetricsDF$Metric),
        filter = 'bottom',
        extensions = 'Buttons',
        options = dtOptions
          )
        )
    })
  
  })
