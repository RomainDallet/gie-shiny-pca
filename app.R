# Librairies ----
library(shiny)
library(FactoMineR)
library(factoextra)
library(explor)

# Import dataset ----
data_table <- t(as.matrix(read.table("inputdata.tsv", header=TRUE, check.names=FALSE, row.names=1, sep="\t")))

# Build PCA ----
pca_graph <- PCA(data_table, graph=FALSE)
explor_data <- explor(pca_graph)

# User interface ----
ui <- fluidPage(
	includeCSS("styles.css"),
	fluidRow(
#		plotOutput("pca")
		explor_data
	)
)

# Server logic ----
server <- function(input, output) {

#	output$pca <- renderUI({
#		explor(pca_graph)
#	})
#	fviz_pca_var(pca_graph, col.var = "cos2", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"))
}

# Run app ----
shinyApp(ui, server)
