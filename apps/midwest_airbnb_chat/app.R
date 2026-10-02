library(shiny)
library(bslib)
library(querychat)
library(DBI)
library(RSQLite)

# 1. Database Connection
con <- DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

# 2. Ellmer OpenAI Client
client <- ellmer::chat_openai(
  model  = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

# 3. Querychat Object
qc <- querychat::querychat(
  con, "listings",
  client             = client,
  tools              = c("filter", "query", "visualize"),
  greeting           = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description   = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

# 4. UI using the new R6 method qc$ui()
ui <- qc$ui(
  title = "Midwest Airbnb Chat",
  theme = bs_theme(bootswatch = "minty")
)

# 5. Server function using the new R6 method qc$server()
server <- function(input, output, session) {
  qc$server()
}

shinyApp(ui, server)