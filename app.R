library(shiny)
library(FactoMineR)
library(explor)
#library(d3heatmap)

height <- "800"

data_table <- t(as.matrix(read.table("inputdata.tsv", header=TRUE, check.names=FALSE, row.names=1, sep="\t")))
explor_data <- explor(PCA(data_table, graph=FALSE))

# hobbies : data with 8403 rows (ind.) and 23 columns (hobbies).
#data(hobbies)
#res.mca <- MCA(hobbies,quali.sup=19:22,quanti.sup=23, graph = FALSE)
#explor_mca <- explor(MCA(hobbies,quali.sup=19:22,quanti.sup=23, graph = FALSE))

#data(decathlon)
#res.pca <- PCA(decathlon[,1:12], quanti.sup = 11:12, graph = FALSE)
#explor_pca <- explor(res.pca)


# User interface ----
ui <- fluidPage(
	includeCSS("styles.css"),
	fluidRow(
		style = paste('margin:0px; height:', height, 'px', sep=''),
		explor_data
	)

#	d3heatmap(nba_players, scale = "column", dendrogram = "row", k_row = 3) #How to pass k_row in param for dynamic visualization
)

# Server logic ----
server <- function(input, output) {
}

# Run app ----
shinyApp(ui, server)
