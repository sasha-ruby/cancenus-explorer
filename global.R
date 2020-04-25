library(here)
library(shiny)
library(tidyverse)
library(htmlwidgets)
library(DT)
library(cancensus)

source(here::here("config.R"))

# get only BC regions
getRegions <- function() {
  regions <- list_census_regions("CA16", use_cache = TRUE)
  return(as_census_region_list(regions %>% filter(PR_UID == "59")))
}
regions <- getRegions()

dtOptions <- list(
  pageLength = 25,
  autoWidth = TRUE,
  dom = 'Blfrtip',
  buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
  lengthChange = TRUE,
  lengthMenu = c(25, 100, 1000, 5000, 10000),
  initComplete = JS(
    "
            function(settings, json) {
            $(this.api().table().header()).css({
            'background-color': 'rgba(0, 51, 102, 0.80)',
            'border-bottom': '5px solid #fcba19',
            'color': '#fff'
            });
            }"
  )
)
