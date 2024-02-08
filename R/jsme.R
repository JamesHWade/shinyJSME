#' Create a JSME widget.
#'
#' JSME (Java Structure Editor for Molecular Editing) is a web app for
#' editing molecular structures.  This function creates a GUI widget that
#' can be included in an Rmarkdown document, which will contain the JSME
#' app.  The app will allow users to interactively create or modify a molecular
#' structure.  The widget will by default have a width and height of 650px,
#' but these can be adjusted.
#'
#' @param structure if character string, this is the initial structure
#'   to be shown in the editor.  If left empty or absent, the editor will
#'   start with a blank screen.  If numeric or logical or list or
#'   data.frame, these will be converted to a character matrix and
#'   passed to the editor as a SMILES.  See `?jsme::setMol` for more
#'   information on the formats that JSME can accept.
#' @param width,height integer or character string indicating the width,
#'   height of the widget.  These will be passed to `createWidget` and
#'   the units `px` are assumed (if not provided, the default is "650px").
#' @return If successful, the function returns a list of class
#'   "htmlwidget" containing the JSME widget, ready for inclusion in
#'   an Rmarkdown document or Shiny app.
#'   If an error occurs (e.g. because the structure is invalid),
#'   the return value is printed to the console and NULL is returned.
#' @export
jsme <- function(structure = "", width = "650px", height = "650px") {
  {
    # forward options using x
    x <- list(
      structure = structure
    )

    # create widget
    htmlwidgets::createWidget(
      name = "jsme",
      x = x,
      width = width,
      height = height,
      package = "jsme"
    )
  }
}

smiles <- function(session, element, inputEl) {
  session$sendCustomMessage(
    type = "smiles",
    message = list(el = element, inputEl = inputEl)
  )
}

molFile <- function(session, element, inputEl) {
  session$sendCustomMessage(
    type = "molFile",
    message = list(el = element, inputEl = inputEl)
  )
}

jmeFile <- function(session, element, inputEl) {
  session$sendCustomMessage(
    type = "jmeFile",
    message = list(el = element, inputEl = inputEl)
  )
}

useMOL <- function(session, element, molFile) {
  session$sendCustomMessage(
    type = "useMOL",
    message = list(el = element, molFile = molFile)
  )
}

useJME <- function(session, element, jmeFile) {
  session$sendCustomMessage(
    type = "useJME",
    message = list(el = element, jmeFile = jmeFile)
  )
}

resetEditor <- function(session, element) {
  session$sendCustomMessage(
    type = "resetEditor",
    message = list(el = element)
  )
}

#' Shiny bindings for jsme
#'
#' Output and render functions for using jsme within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId Output variable to read from.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a jsme
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name jsme-shiny
#'
#' @export
jsmeOutput <- function(outputId, width = "100px", height = "100px") {
  htmlwidgets::shinyWidgetOutput(outputId, "jsme", width, height, package = "jsme")
}

#' @rdname jsme-shiny
#' @export
renderJsme <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, jsmeOutput, env, quoted = TRUE)
}
