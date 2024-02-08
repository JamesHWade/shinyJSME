
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jsme

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of jsme is to provide an HTML widget to draw and interact with
molecular structures in shiny.

## Installation

You can install the development version of jsme like so:

``` r
require("pak")
pak::pkg_install("jameshwade/jsme")
```

Install from Posit Workbench using Posit Package Manger with:

``` r
install.packages("jsme")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(shiny)
library(jsme)


ui <- fluidPage(
  jsmeOutput("jsmeElement", "650px", "650px")
)

server <- function(input, output, session) {
  output$jsmeElement <- renderJsme(
    jsme()
  )
}

shinyApp(ui, server)
```

## Sample App

You can run a sample app with by running:

``` r
require("shiny", "bslib", "jsme")
shiny::runApp(appDir = system.file("shiny", package = "jsme"))
```
