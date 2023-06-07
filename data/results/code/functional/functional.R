########################################################################################################
##################################### work environment preparation #####################################
########################################################################################################
##############################################################################################################

##### Installing CRAN packages
# install.packages(c("data.table","dplyr","tidyr","ggplot2","pals","wordcloud2"))
# install.packages(c("igraph","RColorBrewer","classInt"))
##### Installing the Bioconductor packages
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install(c("TreeAndLeaf","RedeR", "GOSemSim"))

### loading the libraries
library(data.table); library(dplyr); library(tidyr); library(ggplot2); library(pals);
library(GO.db); library(TreeAndLeaf); library(RedeR); library(igraph); library(GOSemSim); 
library(RColorBrewer); library(classInt); library(wordcloud2); library(purrr); library(ggpubr);
library(pheatmap); library(openxlsx)

##########################################################################################################
########################################### DEFINING VARIABLES ###########################################
##########################################################################################################
path="~/meta_taraocean/data/results/input/functional/"
runs <- c("ERR594324","ERR598972","ERR599023","ERR599025","ERR594385","ERR599021","ERR599164","ERR598970",
          "ERR599088","ERR599150","ERR594392","ERR594291","ERR598990","ERR599018","ERR599110","ERR594382",
          "ERR594414","ERR598960","ERR599034","ERR594320","ERR598979","ERR599146","ERR594359","ERR594361",
          "ERR599017","ERR599056","ERR599103","ERR594294","ERR594348","ERR594415","ERR598947","ERR599131",
          "ERR594302","ERR599129","ERR599171","ERR599174","ERR594318","ERR594297","ERR594391","ERR599040",
          "ERR599148","ERR594321","ERR594298","ERR594355","ERR599000","ERR599154","ERR594333","ERR599010",
          "ERR599126","ERR594310","ERR594286","ERR594354","ERR599046","ERR599101","ERR594336","ERR594303",
          "ERR599124","ERR599159","ERR594289","ERR599006","ERR599022","ERR594340","ERR594332","ERR594411",
          "ERR599042","ERR599079","ERR599071","ERR599085","ERR599093","ERR599120","ERR598961","ERR599086",
          "ERR599077","ERR598957","ERR599072","ERR598954")
names_runs <- c("T064 - 594324","T064 - 598972","T064 - 599023","T064 - 599025","T064 - 594385","T064 - 599021",
                "T064 - 599164","T064 - 598970","T064 - 599088","T064 - 599150","T064 - 594392","T065 - 594291",
                "T065 - 598990","T065 - 599018","T065 - 599110","T065 - 594382","T065 - 594414","T065 - 598960",
                "T065 - 599034","T065 - 594320","T065 - 598979","T065 - 599146","T065 - 594359","T065 - 594361",
                "T068 - 599017","T068 - 599056","T068 - 599103","T068 - 594294","T068 - 594348","T068 - 594415",
                "T068 - 598947","T068 - 599131","T068 - 594302","T068 - 599129","T068 - 599171","T068 - 599174",
                "T068 - 594318","T068 - 594297","T068 - 594391","T076 - 599040","T076 - 599148","T076 - 594321",
                "T076 - 594298","T076 - 594355","T076 - 599000","T076 - 599154","T076 - 594333","T076 - 599010",
                "T076 - 599126","T076 - 594310","T076 - 594286","T076 - 594354","T078 - 599046","T078 - 599101",
                "T078 - 594336","T078 - 594303","T078 - 599124","T078 - 599159","T078 - 594289","T078 - 599006",
                "T078 - 599022","T078 - 594340","T078 - 594332","T078 - 594411","T098 - 599042","T098 - 599079",
                "T098 - 599071","T098 - 599085","T098 - 599093","T098 - 599120","T111 - 598961","T111 - 599086",
                "T111 - 599077","T112 - 598957","T112 - 599072","T112 - 598954")
depths <- c("SRF","DCM","MES")
stations <- c("064","065","068","076","078","098","111","112")
stations_tt <- c("064","064","064","064","064","064","064","064","064","064","064","065","065","065",
                 "065","065","065","065","065","065","065","065","065","065","068","068","068","068",
                 "068","068","068","068","068","068","068","068","068","068","068","076","076","076",
                 "076","076","076","076","076","076","076","076","076","076","078","078","078","078",
                 "078","078","078","078","078","078","078","078","098","098","098","098","098","098",
                 "111","111","111","112","112","112")
depths_tt <- c("DCM","DCM","DCM","DCM","DCM","MES","MES","SRF","SRF","SRF","SRF","DCM","DCM","DCM",
               "DCM","DCM","DCM","MES","MES","SRF","SRF","SRF","SRF","SRF","DCM","DCM","DCM","DCM",
               "DCM","DCM","MES","MES","MES","SRF","SRF","SRF","SRF","SRF","SRF","DCM","DCM","DCM",
               "DCM","DCM","MES","MES","MES","SRF","SRF","SRF","SRF","SRF","DCM","DCM","DCM","DCM",
               "MES","MES","MES","SRF","SRF","SRF","SRF","SRF","DCM","DCM","MES","MES","SRF","SRF",
               "DCM","MES","SRF","DCM","MES","SRF")

##########################################################################################################
############################################ DATA PREPARATION ############################################
##########################################################################################################

##### Retrieving samples
for (run in runs) {
  file_name <- paste0(path,"counted_",run,".txt")
  vari_name <- paste0("counted_",run)
  assign(vari_name, fread(file_name, sep = "\t", header = FALSE, stringsAsFactors = FALSE))
  rm(file_name, vari_name, run)
}

##### Renaming columns
for (run in runs) {
  data_name <- get(paste0("counted_",run))
  names(data_name)[1:2] <- c("Annotation", "n")
  assign(paste0("counted_",run), data_name)
  rm(data_name, run)
} 

##### Ordering dataframes
for (run in runs) {
  data_name <- get(paste0("counted_",run))
  vari_name <- paste0("counted_",run)
  assign(vari_name, data_name[order(data_name$n, decreasing = TRUE), ])
  rm(data_name, vari_name, run)
}

##### Retrieving the most frequent 501 (including the undefined)
for (run in runs) {
  data_name <- get(paste0("counted_",run))
  vari_name <- paste0("counted_",run)
  assign(vari_name, data_name[1:501,])
  rm(data_name, vari_name, run)
}

##### Removing the undefined
for (run in runs) {
  data_name <- get(paste0("counted_",run))
  vari_name <- paste0("counted_",run)
  assign(vari_name, subset(data_name, Annotation != "Unknown"))   #for unclassified data
  # assign(vari_name, subset(data_name, !is.na(data_name[,1])))             #for N.A. data
  rm(data_name, vari_name, run)
}

##### Concatenating dataframes by layer and station simultaneously
df_SRF.064 <-list(counted_ERR598970,counted_ERR599088,counted_ERR599150,counted_ERR594392)
df_SRF.065 <-list(counted_ERR594320,counted_ERR598979,counted_ERR599146,counted_ERR594359,counted_ERR594361)
df_SRF.068 <-list(counted_ERR599129,counted_ERR599171,counted_ERR599174,counted_ERR594318,counted_ERR594297,counted_ERR594391)
df_SRF.076 <-list(counted_ERR599010,counted_ERR599126,counted_ERR594310,counted_ERR594286,counted_ERR594354)
df_SRF.078 <-list(counted_ERR599006,counted_ERR599022,counted_ERR594340,counted_ERR594332,counted_ERR594411)
df_SRF.098 <-list(counted_ERR599093,counted_ERR599120)
df_SRF.111 <-list(counted_ERR599077)
df_SRF.112 <-list(counted_ERR598954)

df_DCM.064 <-list(counted_ERR594324,counted_ERR598972,counted_ERR599023,counted_ERR599025,counted_ERR594385)
df_DCM.065 <-list(counted_ERR594291,counted_ERR598990,counted_ERR599018,counted_ERR599110,counted_ERR594382,counted_ERR594414)
df_DCM.068 <-list(counted_ERR599017,counted_ERR599056,counted_ERR599103,counted_ERR594294,counted_ERR594348,counted_ERR594415)
df_DCM.076 <-list(counted_ERR599040,counted_ERR599148,counted_ERR594321,counted_ERR594298,counted_ERR594355)
df_DCM.078 <-list(counted_ERR599046,counted_ERR599101,counted_ERR594336,counted_ERR594303)
df_DCM.098 <-list(counted_ERR599042,counted_ERR599079)
df_DCM.111 <-list(counted_ERR598961)
df_DCM.112 <-list(counted_ERR598957)

df_MES.064 <-list(counted_ERR599021,counted_ERR599164)
df_MES.065 <-list(counted_ERR598960,counted_ERR599034)
df_MES.068 <-list(counted_ERR598947,counted_ERR599131,counted_ERR594302)
df_MES.076 <-list(counted_ERR599000,counted_ERR599154,counted_ERR594333)
df_MES.078 <-list(counted_ERR599124,counted_ERR599159,counted_ERR594289)
df_MES.098 <-list(counted_ERR599071,counted_ERR599085)
df_MES.111 <-list(counted_ERR599086)
df_MES.112 <-list(counted_ERR599072)

###### Creating dataframes from concatenated lists 
for(depth in depths){
  for(station in stations){
    data_name <- get(paste0("df_",depth,".",station))
    vari_name <- paste0("datafinal_",depth,".",station)
    assign(vari_name, bind_rows(data_name))
  }
}

##### Adding columns by like terms
for(depth in depths){
  for(station in stations){
    data_name <- get(paste0("datafinal_",depth,".",station))
    vari_name <- paste0("datafinal_",depth,".",station)
    assign(vari_name, aggregate(n ~ Annotation, data_name, sum))
  }
}

##### Ordering dataframes
for(depth in depths){
  for(station in stations){
    data_name <- get(paste0("datafinal_",depth,".",station))
    vari_name <- paste0("datafinal_",depth,".",station)
    assign(vari_name, data_name[order(data_name$n, decreasing = TRUE),])
  }
}

##### Adding columns to dataframes
datafinal_SRF.064$depth<-1;datafinal_SRF.065$depth<-1;datafinal_SRF.068$depth<-1;datafinal_SRF.076$depth<-1
datafinal_SRF.078$depth<-1;datafinal_SRF.098$depth<-1;datafinal_SRF.111$depth<-1;datafinal_SRF.112$depth<-1
datafinal_DCM.064$depth<-2;datafinal_DCM.065$depth<-2;datafinal_DCM.068$depth<-2;datafinal_DCM.076$depth<-2
datafinal_DCM.078$depth<-2;datafinal_DCM.098$depth<-2;datafinal_DCM.111$depth<-2;datafinal_DCM.112$depth<-2
datafinal_MES.064$depth<-3;datafinal_MES.065$depth<-3;datafinal_MES.068$depth<-3;datafinal_MES.076$depth<-3
datafinal_MES.078$depth<-3;datafinal_MES.098$depth<-3;datafinal_MES.111$depth<-3;datafinal_MES.112$depth<-3

datafinal_SRF.064$station<-064;datafinal_SRF.065$station<-065;datafinal_SRF.068$station<-068;datafinal_SRF.076$station<-076
datafinal_SRF.078$station<-078;datafinal_SRF.098$station<-098;datafinal_SRF.111$station<-111;datafinal_SRF.112$station<-112
datafinal_DCM.064$station<-064;datafinal_DCM.065$station<-065;datafinal_DCM.068$station<-068;datafinal_DCM.076$station<-076
datafinal_DCM.078$station<-078;datafinal_DCM.098$station<-098;datafinal_DCM.111$station<-111;datafinal_DCM.112$station<-112
datafinal_MES.064$station<-064;datafinal_MES.065$station<-065;datafinal_MES.068$station<-068;datafinal_MES.076$station<-076
datafinal_MES.078$station<-078;datafinal_MES.098$station<-098;datafinal_MES.111$station<-111;datafinal_MES.112$station<-112

# ##### Grouping dataframes by season and layer simultaneously
# datafinal_final <- rbind(datafinal_SRF.064,datafinal_SRF.065,datafinal_SRF.068,datafinal_SRF.076,
#                         datafinal_SRF.078,datafinal_SRF.098,datafinal_SRF.111,datafinal_SRF.112,
#                         datafinal_DCM.064,datafinal_DCM.065,datafinal_DCM.068,datafinal_DCM.076,
#                         datafinal_DCM.078,datafinal_DCM.098,datafinal_DCM.111,datafinal_DCM.112,
#                         datafinal_MES.064,datafinal_MES.065,datafinal_MES.068,datafinal_MES.076,
#                         datafinal_MES.078,datafinal_MES.098,datafinal_MES.111,datafinal_MES.112)

##### Exporting dataframes
for(depth in depths){
  for(station in stations){
    data_name <- get(paste0("datafinal_",depth,".",station))
    vari_name <- paste0("datafinal_",depth,".",station,".csv")
    write.table(data_name, file = paste0("~/meta_taraocean/data/results/output/functional/goterms/",vari_name), sep = "\t", na = "", quote = FALSE, row.names = FALSE)
  }
}

######################################################################################################################
####################################### Configuration of dataframes for the plots (RedeR) ############################
######################################################################################################################

##### Retrieving samples
for (depth in depths) {
  for(station in stations){
    file_name <- paste0("~/meta_taraocean/data/results/output/functional/goterms/datafinal_",depth,".",station,".csv")
    vari_name <- paste0("data_",depth,".",station)
    assign(vari_name, fread(file_name, sep = "\t", header = TRUE, stringsAsFactors = FALSE))
  }
  rm(file_name, vari_name, depth, station)
}

##### Retrieving GO terms from samples
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("data_",depth,".",station))
    vari_name <- paste0("gos_",depth,".",station)
    assign(vari_name, data_name$Annotation)
  }
  rm(data_name, vari_name, depth, station)
}

##### Retrieving ontologies and descriptions by terms
getGODescription <- function(GOs){
  BP <- names(as.list(GO.db::GOBPCHILDREN))
  CC <- names(as.list(GO.db::GOCCCHILDREN))
  MF <- names(as.list(GO.db::GOMFCHILDREN))
  result <- vapply(GOs, function(x){
    if(x %in% BP){
      return("BP")
    }else if(x %in% CC){
      return("CC")
    }else if(x %in% MF){
      return("MF")
    }else{
      return(NA_character_)
    }
  }, character(1))
  return(result)
}

##### Adding ontology column
for (depth in depths) {
  for(station in stations){
    data_name1 <- get(paste0("data_",depth,".",station))
    data_name2 <- get(paste0("gos_",depth,".",station))
    data_name1$ontology <- getGODescription(data_name2)
    assign(paste0("data_",depth,".",station), data_name1)
  }
  rm(data_name1, data_name2, depth, station)
}


##### Omitting NAs
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("data_",depth,".",station))
    na.omit(data_name)
    assign(paste0("data_",depth,".",station), data_name)
  }
  rm(data_name, depth, station)
}


##### Restricting the dataframe to the 'BP' ontology
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("data_",depth,".",station))
    data_name <- data_name[data_name$ontology=="BP", ]
    assign(paste0("data_",depth,".",station), data_name)
  }
  rm(data_name, depth, station)
}

##### Putting terms in a list
xx <- as.list(GOTERM)

##### Retrieving description column
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("data_",depth,".",station))
    data_name$desc <- sapply(data_name$Annotation, function(i){
      flagError <- FALSE
      tryCatch({
        res <- xx[[i]]@Term
      }, error = function(e) {
        flagError <<- TRUE
      })
      if(flagError){
        return("Unknown")
      }
      else{
        return(res)
      }
    })
    assign(paste0("data_",depth,".",station), data_name)
  }
  rm(data_name, depth, station)
}

##### Defining cutoff
cutoff <- 0 
# value between 0 and 0.99 to remove tails from the plot, if there are no tails that hinder the visualization, you can leave it at 0

##### Defining terms by samples
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("data_",depth,".",station))
    vari_name <- paste0("terms_",depth,".",station)
    assign(vari_name, data_name$Annotation)
  }
  rm(data_name, vari_name, depth, station)
}

##### Defining 'BP' ontology
semData <- godata(ont = "BP")

##### Sim Terms
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("terms_",depth,".",station))
    vari_name <- paste0("mSim_",depth,".",station)
    assign(vari_name, mgoSim(data_name, data_name, semData = semData, measure = "Wang", combine = NULL))
  }
  rm(data_name, vari_name, depth, station)
}

##### Retrieving attributes
for (depth in depths) {
  for(station in stations){
    data_name1 <- get(paste0("mSim_",depth,".",station))
    data_name2 <- get(paste0("terms_",depth,".",station))
    data_name3 <- get(paste0("data_",depth,".",station))
    vari_name1 <- paste0("RS_",depth,".",station)
    vari_name2 <- paste0("GOs_",depth,".",station)
    if(cutoff > 0){
      vari_name1 <- rowSums(data_name1) - 1
      vari_name2 <- names(sort(vari_name1)[-1:-cutoff])
      data_name1 <- data_name1[rownames(data_name1) %in% vari_name2, colnames(data_name1) %in% vari_name2]
      data_name2 <- data_name2[data_name2 %in% vari_name2]
      data_name3 <- data_name3[data_name3$ID %in% vari_name2,]
    }
  }
  rm(data_name1, data_name2, data_name3, vari_name1, vari_name2, depth, station)
}

##### Defining grouping method
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("mSim_",depth,".",station))
    vari_name <- paste0("hc_",depth,".",station)
    assign(vari_name, hclust(dist(data_name), "average"))
  }
  rm(data_name, vari_name, depth, station)
}

##### Drawing the tree
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("hc_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, treeAndLeaf(data_name))
  }
  rm(data_name, vari_name, depth, station)
}

##### Mapping the tree
for (depth in depths) {
  for(station in stations){
    data_name1 <- get(paste0("tal_",depth,".",station))
    data_name2 <- get(paste0("data_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, att.mapv(g = data_name1, dat = data_name2, refcol = 1))
  }
  rm(data_name1, data_name2, vari_name, depth, station)
}

##### Defining colors
pal <- brewer.pal(9, "Reds")

##### Setting attribute: nodes
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("tal_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, att.setv(g = data_name, from = "desc", to = "nodeAlias"))
  }
  rm(data_name, vari_name, depth, station)
}

##### Setting attribute: node color
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("tal_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, att.setv(g = data_name, from = "n", to = "nodeColor", 
                               cols = pal, nquant = 5))
  }
  rm(data_name, vari_name, depth, station)
}


##### Setting attribute: node size
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("tal_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, att.setv(g = data_name, from = "n", to = "nodeSize",
                               xlim = c(10, 50, 5), nquant = 5))
  }
  rm(data_name, vari_name, depth, station)
}

##### Setting attribute: node caption font
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("tal_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, att.addv(data_name, "nodeFontSize", value = 15, index = V(data_name)$isLeaf))
  }
  rm(data_name, vari_name, depth, station)
}

##### Setting attribute: width of margins
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("tal_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, att.adde(data_name,  "edgeWidth", value = 3))
  }
  rm(data_name, vari_name, depth, station)
}

##### Defining attribute: margins color
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("tal_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, att.adde(data_name, "edgeColor", value = "gray80"))
  }
  rm(data_name, vari_name, depth, station)
}

##### Setting attribute: edge color
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("tal_",depth,".",station))
    vari_name <- paste0("tal_",depth,".",station)
    assign(vari_name, att.addv(data_name, "nodeLineColor", value = "gray80"))
  }
  rm(data_name, vari_name, depth, station)
}


##### Interface
# rdp <- RedPort()
# calld(rdp)
# resetd(rdp)
# addGraph(obj = rdp, g = tal)
# # relax(rdp, p1 = 25, p2 = 200, p3 = 5, p5 = 5, ps = TRUE)
# relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)

rdp <- RedPort()
calld(rdp)
resetd(rdp)

addGraph(obj = rdp, g = tal_SRF.064)
addGraph(obj = rdp, g = tal_SRF.065)
addGraph(obj = rdp, g = tal_SRF.068)
addGraph(obj = rdp, g = tal_SRF.076)
addGraph(obj = rdp, g = tal_SRF.078)
addGraph(obj = rdp, g = tal_SRF.098)
addGraph(obj = rdp, g = tal_SRF.111)
addGraph(obj = rdp, g = tal_SRF.112)

addGraph(obj = rdp, g = tal_DCM.064)
addGraph(obj = rdp, g = tal_DCM.065)
addGraph(obj = rdp, g = tal_DCM.068)
addGraph(obj = rdp, g = tal_DCM.076)
addGraph(obj = rdp, g = tal_DCM.078)
addGraph(obj = rdp, g = tal_DCM.098)
addGraph(obj = rdp, g = tal_DCM.111)
addGraph(obj = rdp, g = tal_DCM.112)

addGraph(obj = rdp, g = tal_MES.064)
addGraph(obj = rdp, g = tal_MES.065)
addGraph(obj = rdp, g = tal_MES.068)
addGraph(obj = rdp, g = tal_MES.076)
addGraph(obj = rdp, g = tal_MES.078)
addGraph(obj = rdp, g = tal_MES.098)
addGraph(obj = rdp, g = tal_MES.111)
addGraph(obj = rdp, g = tal_MES.112)

# relax(rdp, p1 = 25, p2 = 200, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)



##############################################################################################################
################################ Configuracao dos dataframes para os plots (por camadas) #####################
##############################################################################################################



##### Concatenando dataframes por camada
data.tree_SRF <- rbind(data_SRF.064,data_SRF.065,data_SRF.068,data_SRF.076,data_SRF.078,data_SRF.098,data_SRF.111,data_SRF.112)
data.tree_DCM <- rbind(data_DCM.064,data_DCM.065,data_DCM.068,data_DCM.076,data_DCM.078,data_DCM.098,data_DCM.111,data_DCM.112)
data.tree_MES <- rbind(data_MES.064,data_MES.065,data_MES.068,data_MES.076,data_MES.078,data_MES.098,data_MES.111,data_MES.112)

##### Somando colunas por termos iguais
for(depth in depths){
  data_name <- get(paste0("data.tree_",depth))
  vari_name <- paste0("data.tree_",depth)
  assign(vari_name, aggregate(n ~ Annotation, data_name, sum))
  rm(data_name, vari_name, depth)
}

##### Ordenando dataframes
for(depth in depths){
  data_name <- get(paste0("data.tree_",depth))
  vari_name <- paste0("data.tree_",depth)
  assign(vari_name, data_name[order(data_name$n, decreasing = TRUE),])
  rm(data_name, vari_name, depth)
}

##### Resgatando termos GO das amostras
for (depth in depths) {
  data_name <- get(paste0("data.tree_",depth))
  vari_name <- paste0("gos.tree_",depth)
  assign(vari_name, data_name$Annotation)
  rm(data_name, vari_name, depth)
}

##### Resgatando ontologias e descricoes pelos termos
getGODescription <- function(GOs){
  BP <- names(as.list(GO.db::GOBPCHILDREN))
  CC <- names(as.list(GO.db::GOCCCHILDREN))
  MF <- names(as.list(GO.db::GOMFCHILDREN))
  result <- vapply(GOs, function(x){
    if(x %in% BP){
      return("BP")
    }else if(x %in% CC){
      return("CC")
    }else if(x %in% MF){
      return("MF")
    }else{
      return(NA_character_)
    }
  }, character(1))
  return(result)
}

##### Adicionando coluna de ontologia
for (depth in depths) {
  data_name1 <- get(paste0("data.tree_",depth))
  data_name2 <- get(paste0("gos.tree_",depth))
  data_name1$ontology <- getGODescription(data_name2)
  assign(paste0("data.tree_",depth), data_name1)
  rm(data_name1, data_name2, depth)
}


##### Omitindo NAs
for (depth in depths) {
  data_name <- get(paste0("data.tree_",depth))
  na.omit(data_name)
  assign(paste0("data_",depth), data_name)
  rm(data_name, depth)
}


##### Restringindo o dataframe aa ontologia 'BP'
for (depth in depths) {
  for(station in stations){
    data_name <- get(paste0("data_",depth,".",station))
    data_name <- data_name[data_name$ontology=="BP", ]
    assign(paste0("data_",depth,".",station), data_name)
  }
  rm(data_name, depth, station)
}

##### Colocando os termos em uma lista
xx <- as.list(GOTERM)

##### Resgatando coluna de descricao
for (depth in depths) {
  data_name <- get(paste0("data.tree_",depth))
  data_name$desc <- sapply(data_name$Annotation, function(i){
    flagError <- FALSE
    tryCatch({
      res <- xx[[i]]@Term
    }, error = function(e) {
      flagError <<- TRUE
    })
    if(flagError){
      return("Unknown")
    }
    else{
      return(res)
    }
  })
  assign(paste0("data.tree_",depth), data_name)
  rm(data_name, depth)
}

##### Definindo cutoff
cutoff <- 0 
# valor entre 0 e 0.99 para remover caudas do plot, se nao tem
# caudas que atrapalham a visualizacao, pode deixar em 0

##### Definindo os termos pelas amostras
for (depth in depths) {
  data_name <- get(paste0("data_",depth))
  vari_name <- paste0("terms_",depth)
  assign(vari_name, data_name$Annotation)
  rm(data_name, vari_name, depth)
}

##### Definindo ontologia 'BP'
semData <- godata(ont = "BP")

##### Sim Terms
for (depth in depths) {
  data_name <- get(paste0("terms_",depth))
  vari_name <- paste0("mSim_",depth)
  assign(vari_name, mgoSim(data_name, data_name, semData = semData, measure = "Wang", combine = NULL))
  rm(data_name, vari_name, depth)
}

##### Resgatando atributos 
for (depth in depths) {
  data_name1 <- get(paste0("mSim_",depth))
  data_name2 <- get(paste0("terms_",depth))
  data_name3 <- get(paste0("data_",depth))
  vari_name1 <- paste0("RS_",depth)
  vari_name2 <- paste0("GOs_",depth)
  if(cutoff > 0){
    vari_name1 <- rowSums(data_name1) - 1
    vari_name2 <- names(sort(vari_name1)[-1:-cutoff])
    data_name1 <- data_name1[rownames(data_name1) %in% vari_name2, colnames(data_name1) %in% vari_name2]
    data_name2 <- data_name2[data_name2 %in% vari_name2]
    data_name3 <- data_name3[data_name3$ID %in% vari_name2,]
  }
  rm(data_name1, data_name2, data_name3, vari_name1, vari_name2, depth)
}

##### Definindo metodo de agrupamento
for (depth in depths) {
  data_name <- get(paste0("mSim_",depth))
  vari_name <- paste0("hc_",depth)
  assign(vari_name, hclust(dist(data_name), "average"))
  rm(data_name, vari_name, depth)
}

##### Desenhando a arvore
for (depth in depths) {
  data_name <- get(paste0("hc_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, treeAndLeaf(data_name))
  rm(data_name, vari_name, depth)
}

# Mapeando a arvore
for (depth in depths) {
  data_name1 <- get(paste0("tal_",depth))
  data_name2 <- get(paste0("data.tree_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, att.mapv(g = data_name1, dat = data_name2, refcol = 1))
  rm(data_name1, data_name2, vari_name, depth)
}

##### Definindo cores
pal <- brewer.pal(9, "Reds")

##### Definindo atributo: nos
for (depth in depths) {
  data_name <- get(paste0("tal_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, att.setv(g = data_name, from = "desc", to = "nodeAlias"))
  rm(data_name, vari_name, depth)
}

##### Definindo atributo: cor do no
for (depth in depths) {
  data_name <- get(paste0("tal_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, att.setv(g = data_name, from = "n", to = "nodeColor", 
                             cols = pal, nquant = 5))
  rm(data_name, vari_name, depth)
}


##### Definindo atributo: tamanho do no
for (depth in depths) {
  data_name <- get(paste0("tal_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, att.setv(g = data_name, from = "n", to = "nodeSize",
                             xlim = c(10, 50, 5), nquant = 5))
  rm(data_name, vari_name, depth)
}

##### Definindo atributo: fonte da legenda do no
for (depth in depths) {
  data_name <- get(paste0("tal_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, att.addv(data_name, "nodeFontSize", value = 15, index = V(data_name)$isLeaf))
  rm(data_name, vari_name, depth)
}

##### Definindo atributo: largura das margens
for (depth in depths) {
  data_name <- get(paste0("tal_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, att.adde(data_name,  "edgeWidth", value = 3))
  rm(data_name, vari_name, depth)
}

##### Definindo atributo: cor das margens
for (depth in depths) {
  data_name <- get(paste0("tal_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, att.adde(data_name, "edgeColor", value = "gray80"))
  rm(data_name, vari_name, depth)
}

##### Definindo atributo: cor das arestas
for (depth in depths) {
  data_name <- get(paste0("tal_",depth))
  vari_name <- paste0("tal_",depth)
  assign(vari_name, att.addv(data_name, "nodeLineColor", value = "gray80"))
  rm(data_name, vari_name, depth)
}

##### Adicionando legendas
for (depth in depths) {
  data_name <- get(paste0("tal_",depth))
  # vari_name <- paste0("tal_",depth)
  addLegend.color(obj = rdp, data_name, title = "Terms Frequency",
                  position = "bottomright")
  addLegend.size(obj = rdp, data_name, title = "Terms Frequency")
  rm(data_name, depth)
}


####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################

##### Interface
rdp <- RedPort()
calld(rdp)
resetd(rdp)


# relax(rdp, p1 = 25, p2 = 200, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)
###
###
addGraph(obj = rdp, g = tal_SRF)
addGraph(obj = rdp, g = tal_DCM)
addGraph(obj = rdp, g = tal_MES)

addGraph(obj = rdp, g = tal_SRF.064)
addGraph(obj = rdp, g = tal_SRF.065)
addGraph(obj = rdp, g = tal_SRF.068)
addGraph(obj = rdp, g = tal_SRF.076)
addGraph(obj = rdp, g = tal_SRF.078)
addGraph(obj = rdp, g = tal_SRF.098)
addGraph(obj = rdp, g = tal_SRF.111)
addGraph(obj = rdp, g = tal_SRF.112)

addGraph(obj = rdp, g = tal_DCM.064)
addGraph(obj = rdp, g = tal_DCM.065)
addGraph(obj = rdp, g = tal_DCM.068)
addGraph(obj = rdp, g = tal_DCM.076)
addGraph(obj = rdp, g = tal_DCM.078)
addGraph(obj = rdp, g = tal_DCM.098)
addGraph(obj = rdp, g = tal_DCM.111)
addGraph(obj = rdp, g = tal_DCM.112)

addGraph(obj = rdp, g = tal_MES.064)
addGraph(obj = rdp, g = tal_MES.065)
addGraph(obj = rdp, g = tal_MES.068)
addGraph(obj = rdp, g = tal_MES.076)
addGraph(obj = rdp, g = tal_MES.078)
addGraph(obj = rdp, g = tal_MES.098)
addGraph(obj = rdp, g = tal_MES.111)
addGraph(obj = rdp, g = tal_MES.112)

# relax(rdp, p1 = 25, p2 = 200, p3 = 5, p5 = 5, ps = TRUE)
relax(rdp, p1 = 25, p3 = 5, p5 = 5, ps = TRUE)


######################################################################################################
############################################### Word cloud ###########################################
######################################################################################################

stg.col <- c("#424242", "#76ff03", "#004d40", "#795548", "#80deea", "#311b92", "#00e676", "#66bb6a", "#0d47a1", "#7986cb", 
             "#5c6bc0", "#78909c", "#455a64", "#bf360c", "#558b2f", "#4a148c", "#9e9d24", "#6a1b9a", "#26a69a", "#757575", 
             "#ea80fc", "#ffab00", "#ad1457", "#f57f17", "#80d8ff", "#ffb74d", "#006064", "#3e2723", "#8c9eff", "#ab47bc", 
             "#64b5f6", "#18ffff", "#9575cd", "#880e4f", "#6200ea", "#1b5e20", "#1a237e", "#1de9b6", "#b71c1c", "#1565c0", 
             "#827717", "#f06292", "#673ab7", "#00b0ff", "#ef5350", "#ff80ab", "#ff5722", "#ff5252", "#e57373", "#fdd835")


##### Concatenating dataframes by layer
data_SRF <- rbind(data_SRF.064,data_SRF.065,data_SRF.068,data_SRF.076,data_SRF.078,data_SRF.098,data_SRF.111,data_SRF.112)
data_DCM <- rbind(data_DCM.064,data_DCM.065,data_DCM.068,data_DCM.076,data_DCM.078,data_DCM.098,data_DCM.111,data_DCM.112)
data_MES <- rbind(data_MES.064,data_MES.065,data_MES.068,data_MES.076,data_MES.078,data_MES.098,data_MES.111,data_MES.112)

data_terms <- cbind(data_SRF, data_DCM, data_MES)

##### Exporting dataframes
for(depth in depths){
  for(station in stations){
    data_name <- get(paste0("data_",depth))
    vari_name <- paste0("terms_",depth,".csv")
    write.table(data_name, file = paste0("~/meta_taraocean/data/results/output/functional/terms/",vari_name), sep = "\t", na = "", quote = FALSE, row.names = FALSE)
  }
}

for(depth in depths){
  for(station in stations){
    data_name <- get(paste0(depth,"_exclusive_distribution_TERMS"))
    vari_name <- paste0("exc_terms_",depth,".csv")
    write.table(data_name, file = paste0("~/meta_taraocean/data/results/output/functional/terms/",vari_name), sep = "\t", na = "", quote = FALSE, row.names = FALSE)
  }
}


##### Adding columns by like terms
for(depth in depths){
  data_name <- get(paste0("data_",depth))
  vari_name <- paste0("data_",depth)
  # data_name <- aggregate(x = data_name, by = list(Annotation), FUN = "sum")
  assign(vari_name, aggregate(n ~ desc, data_name, sum))
  rm(data_name, vari_name, depth)
}

##### Ordering dataframes
for(depth in depths){
  data_name <- get(paste0("data_",depth))
  vari_name <- paste0("data_",depth)
  assign(vari_name, data_name[order(data_name$n, decreasing = TRUE),])
  rm(data_name, vari_name, depth)
}

##### Creating dataframes from each layer to the clouds
for(depth in depths){
  data_name <- get(paste0("data_",depth))
  vari_name <- paste0("cloud_",depth)
  assign(vari_name, data_name[1:50,])
}

##### Plotting clouds from layers
plot.cloud_SRF <- wordcloud2(data=cloud_SRF, size=0.25, minRotation = -pi/1, 
                             fontFamily = 'Segoe UI', fontWeight = 'normal',
                             maxRotation = -pi/1, rotateRatio = 0, color="random-dark", 
                             backgroundColor="white", shape="circle",  ellipticity = 0.5)

plot.cloud_DCM <- wordcloud2(data=cloud_DCM, size=0.25, minRotation = -pi/1, 
                             fontFamily = 'Segoe UI', fontWeight = 'normal',
                             maxRotation = -pi/1, rotateRatio = 0, color="random-dark", 
                             backgroundColor="white", shape="circle",  ellipticity = 0.5)

plot.cloud_MES <- wordcloud2(data=cloud_MES, size=0.25, minRotation = -pi/1, 
                             fontFamily = 'Segoe UI', fontWeight = 'normal',
                             maxRotation = -pi/1, rotateRatio = 0, color="random-dark", 
                             backgroundColor="white", shape="circle",  ellipticity = 0.5)
plot.cloud_SRF
plot.cloud_DCM
plot.cloud_MES

##### Creating dataframes of each season by layer for the clouds
for(depth in depths){
  for(station in stations) {
    data_name <- get(paste0("data_",depth,".",station))
    vari_name <- paste0("cloud_",depth,".",station)
    assign(vari_name, subset(data_name[1:50,], select = c(desc,n)))
  }
}

##### Plotting stations clouds by layers
wordcloud2(data=cloud_SRF.064, size=0.2, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_SRF.065, size=0.5, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_SRF.068, size=0.2, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_SRF.076, size=0.2, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_SRF.078, size=0.2, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_SRF.098, size=0.2, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_SRF.111, size=0.2, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_SRF.112, size=0.2, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_DCM.064, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_DCM.065, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_DCM.068, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_DCM.076, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_DCM.078, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_DCM.098, size=0.25, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_DCM.111, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_DCM.112, size=0.25, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_MES.064, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_MES.065, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_MES.068, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_MES.076, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_MES.078, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_MES.098, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_MES.111, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")
wordcloud2(data=cloud_MES.112, size=0.3, minRotation = -pi/1, 
           maxRotation = -pi/1, rotateRatio = 0, color='random-dark', 
           backgroundColor="white", shape="circle")


################################################################################
################################################################################
################################################################################

##### Checking unique terms per tier
data_SRF$depth <- "SRF"
data_DCM$depth <- "DCM"
data_MES$depth <- "MES"

df <- bind_rows(data_SRF, data_DCM, data_MES)

# What are the key processes unique to each layer?
df %>% 
  group_by(Annotation) %>% 
  mutate(exclusive = n()) %>% 
  ungroup() %>% 
  arrange(desc(exclusive), desc(n)) -> df2 

# How many biological processes are unique to each layer?
df2 %>% 
  filter(exclusive == 1) %>% 
  group_by(depth) %>% 
  summarise(n())


# Samples/Layers dictionary
dict <- read.table("~/meta_taraocean/data/results/input/functional/runstationdepth.txt", 
                   header = T, sep = "\t", colClasses = rep("character", 3))

# Union of common terms by combining layers
SRF_DCM <- union(data_DCM$Annotation, data_SRF$Annotation)
SRF_MES <- union(data_SRF$Annotation, data_MES$Annotation)
DCM_MES <- union(data_DCM$Annotation, data_MES$Annotation)


# Function to get the number of unique terms in each sample of a layer compared to the terms of the other layers
get_exclusive_distribution_sample <- function(depth, comparison) {
  sapply(dict$run[dict$depth == depth], function(x) {
    get(paste0("counted_", x)) %>% 
      pull(Annotation) %>% 
      base::setdiff(.,comparison) -> gos
    select(GO.db, keys = gos, columns = "ONTOLOGY", keytype = "GOID") %>% 
      filter(ONTOLOGY == "BP") %>% 
      pull(GOID) %>% 
      unique() %>% 
      length()
  })
}

MES_exclusive_distribution_sample <- get_exclusive_distribution_sample("MES", SRF_DCM)
SRF_exclusive_distribution_sample <- get_exclusive_distribution_sample("SRF", DCM_MES)
DCM_exclusive_distribution_sample <- get_exclusive_distribution_sample("DCM", SRF_MES)

# Get description of which terms are unique to each layer (to cite in the paper)
get_exclusive_distribution_TERMS <- function(x, y) {
  gos <- setdiff(x, y)
  select(GO.db, keys = gos, columns = c("TERM", "ONTOLOGY"), keytype = "GOID") %>% 
    filter(ONTOLOGY == "BP")
}

MES_exclusive_distribution_TERMS <- get_exclusive_distribution_TERMS(x = unique(data_MES$Annotation),
                                                                     y = unique(c(data_DCM$Annotation, data_SRF$Annotation)))
SRF_exclusive_distribution_TERMS <- get_exclusive_distribution_TERMS(x = unique(data_SRF$Annotation),
                                                                     y = unique(c(data_DCM$Annotation, data_MES$Annotation)))
DCM_exclusive_distribution_TERMS <- get_exclusive_distribution_TERMS(x = unique(data_DCM$Annotation),
                                                                     y = unique(c(data_MES$Annotation, data_SRF$Annotation)))
# Plotting
build_df <- function(v, depth) {
  data.frame(n = unname(v), depth = depth)
}

df_plot <- bind_rows(build_df(SRF_exclusive_distribution_sample, "SRF"),
                     build_df(DCM_exclusive_distribution_sample, "DCM"),
                     build_df(MES_exclusive_distribution_sample, "MES"))

df_plot$depth <- factor(df_plot$depth, levels = c("SRF", "DCM", "MES"))

df_plot

exc_term_sample <- ggplot(df_plot, aes(x = depth, y = n)) +
  geom_boxplot(alpha = 0.5, outlier.shape = NA) +
  geom_point(position = position_jitter(width = 0.1)) +
  stat_compare_means(comparisons = list(c("SRF", "DCM"), c("SRF", "MES"), c("DCM", "MES")), 
                     method = "wilcox.test", exact = F) +
  labs(x = "", y = "Number of exclusive terms by sample")

### exporting files (PDF)
ggsave(filename = "~/meta_taraocean/data/results/output/functional/plots/pdf/mounting/exc_term_sample.pdf", exc_term_sample,
       width = 15, height = 10, dpi = 500, units = "cm", device='pdf')

### exporting files (PNG)
ggsave(filename = "~/meta_taraocean/data/results/output/functional/plots/png/mounting/exc_term_sample.png", exc_term_sample,
       width = 15, height = 10, dpi = 500, units = "cm", device='png')

### exporting files (SVG)
exc_term_sample
dev.copy(svg,"~/meta_taraocean/data/results/output/functional/plots/svg/mounting/exc_term_sample.svg", width = 7, height = 5)
dev.off()


# By station -------------------------------------------------------------

get_exclusive_distribution_station <- function(depth, comparison) {
  sapply(unique(dict$station[dict$depth == depth]), function(x) {
    get(paste0("data_", depth, ".", x)) %>% 
      pull(Annotation) %>% 
      base::setdiff(.,comparison) -> gos
    select(GO.db, keys = gos, columns = "ONTOLOGY", keytype = "GOID") %>% 
      filter(ONTOLOGY == "BP") %>% 
      pull(GOID) %>% 
      unique() %>% 
      length()
  })
}

MES_exclusive_distribution_station <- get_exclusive_distribution_station("MES", SRF_DCM)
SRF_exclusive_distribution_station <- get_exclusive_distribution_station("SRF", DCM_MES)
DCM_exclusive_distribution_station <- get_exclusive_distribution_station("DCM", SRF_MES)

# Plotting
build_df <- function(v, depth) {
  data.frame(n = unname(v), depth = depth)
}

df_plot <- bind_rows(build_df(SRF_exclusive_distribution_station, "SRF"),
                     build_df(DCM_exclusive_distribution_station, "DCM"),
                     build_df(MES_exclusive_distribution_station, "MES"))

df_plot$depth <- factor(df_plot$depth, levels = c("SRF", "DCM", "MES"))

df_plot$station <- names(MES_exclusive_distribution_station)

df_plot <- unique(df_plot)

exc_term_station <- ggplot(df_plot, aes(x = depth, y = n)) +
  geom_boxplot(alpha = 0.5, outlier.shape = NA) +
  geom_point(position = position_jitter(width = 0.1)) +
  stat_compare_means(comparisons = list(c("SRF", "DCM"), c("SRF", "MES"), c("DCM", "MES")), 
                     method = "wilcox.test", exact = F) +
  labs(x = "", y = "Number of exclusive terms in each depth layer by station")

### exporting files (PDF)
ggsave(filename = "~/meta_taraocean/data/results/output/functional/plots/pdf/mounting/exc_term_station.pdf", exc_term_station,
       width = 10, height = 12, dpi = 500, units = "cm", device='pdf')

### exporting files (PNG)
ggsave(filename = "~/meta_taraocean/data/results/output/functional/plots/png/mounting/exc_term_station.png", exc_term_station,
       width = 15, height = 12, dpi = 500, units = "cm", device='png')

### exporting files (SVG)
exc_term_station
dev.copy(svg,"~/meta_taraocean/data/results/output/functional/plots/svg/mounting/exc_term_station.svg", width = 7, height = 5)
dev.off()

###


######################################################################################################
################################################ PHEATMAP ############################################
######################################################################################################

cloud_DCM <- cloud_DCM %>%
  mutate(region = "DCM")
cloud_SRF <- cloud_SRF %>%
  mutate(region = "SRF")
cloud_MES <- cloud_MES %>%
  mutate(region = "MES")


all_terms <- bind_rows(cloud_DCM, cloud_MES, cloud_SRF)

terms_wide <- all_terms %>%
  pivot_wider(id_cols = region, names_from = desc, values_from = n) %>%
  tibble::column_to_rownames(var = "region") %>%
  as.matrix() %>%
  log() %>%
  t()

write.xlsx(data.frame(terms_wide), "../../output/functional/goterms/Figure4_matrix.xlsx", rowNames = TRUE)

terms_pheatmap <- pheatmap(
  terms_wide,
  border_color = "white",
  cluster_rows = FALSE,
  color = RColorBrewer::brewer.pal(7, "Blues"),
  angle_col = 0,
  na_col = "#fafafa"
)

terms_pheatmap

# exporting files
ggsave(terms_pheatmap, filename = "../../output/functional/plots/pdf/tara_terms_pheatmap.pdf", height = 8)
ggsave(terms_pheatmap, filename = "../../output/functional/plots/png/tara_terms_pheatmap.png", height = 8)
