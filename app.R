# Librairies ----
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(FactoMineR)
library(factoextra)
library(explor)

# Import dataset ----
data_table <- t(as.matrix(read.table("inputdata.tsv", header=TRUE, check.names=FALSE, row.names=1, sep="\t")))

# TODO : Dynamically import samples metadata file
samples_metadata_name<-"samples_metadata.csv"
samples_metadata_file<-gx_get(samples_metadata_name, identifier_type='name')
samples_metadata <- as.matrix(read.csv(samples_metadata_file, header=TRUE, check.names=FALSE, row.names=1, sep="\t"))
samples_metadata <- subset(samples_metadata, rownames(samples_metadata) %in% rownames(data_table))

final_table<-data.frame(merge(data_table,samples_metadata, by="row.names"), row.names=1)


# Build PCA ----
pca_graph <- PCA(final_table, quali.sup=(ncol(final_table)-ncol(samples_metadata)+1):ncol(final_table), graph=FALSE, scale.unit=TRUE)
explor_data <- explor(pca_graph)


# User interface ----
ui <- dashboardPage(
	dashboardHeader(title="Shiny PCA"),
	dashboardSidebar(
		collapsed = TRUE
	),
	dashboardBody(
		includeCSS("styles.css"),
		fluidRow(
			explor_data
		)
	)
)

# Server logic ----
server <- function(input, output) {}

# Run app ----
shinyApp(ui, server)
