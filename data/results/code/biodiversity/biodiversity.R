########################################################################################################
##################################### work environment preparation #####################################
########################################################################################################

### installing necessary packages to fulfill the requirements and requests of this work
# install.packages('dplyr'); install.packages('tidyr'); install.packages("pals"); install.packages("plyr"); 
# install.packages("FactoMineR"); install.packages("ggplot2"); install.packages("ggdendro"); install.packages("xlsx");
# install.packages("cluster"); install.packages("devtools"); install.packages("factoextra"); install.packages("stats");
# install.packages("dendextend"); install.packages("MultivariateAnalysis"); install.packages("vegan"); # install.packages("patchwork")

### loading the libraries
library(dplyr); library(tidyr); library(pals); library(plyr); library(FactoMineR); library(ggplot2);
library(ggdendro); library(cluster); library(factoextra); library(stats); #library(devtools);
library(dendextend); library(MultivariateAnalysis); library(vegan); library(ggpubr); library(vegan);
library(tidyverse); library(forcats); library(iNEXT); library(scales); library(patchwork)

##########################################################################################################
########################################### DEFINING VARIABLES ###########################################
##########################################################################################################

##### DEFINING VARIABLES
path="~/meta_taraocean/data/results/input/taxonomic/"
taxons <- c("kingdom", "phylum", "class", "order", "family", "genus", "species")
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
stations <- c("064","064","064","064","064","064","064","064","064","064","064","065","065","065",
              "065","065","065","065","065","065","065","065","065","065","068","068","068","068",
              "068","068","068","068","068","068","068","068","068","068","068","076","076","076",
              "076","076","076","076","076","076","076","076","076","076","078","078","078","078",
              "078","078","078","078","078","078","078","078","098","098","098","098","098","098",
              "111","111","111","112","112","112")
oceans <- c("IO","IO","IO","IO","IO","IO","IO","IO","IO","IO","IO","IO","IO","IO",
            "IO","IO","IO","IO","IO","IO","IO","IO","IO","IO","SAO","SAO","SAO","SAO",
            "SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO",
            "SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO",
            "SAO","SAO","SAO","SAO","SAO","SAO","SAO","SAO","SPO","SPO","SPO","SPO","SPO","SPO",
            "SPO","SPO","SPO","SPO","SPO","SPO")
depths <- c("DCM","DCM","DCM","DCM","DCM","MES","MES","SRF","SRF","SRF","SRF","DCM","DCM","DCM",
            "DCM","DCM","DCM","MES","MES","SRF","SRF","SRF","SRF","SRF","DCM","DCM","DCM","DCM",
            "DCM","DCM","MES","MES","MES","SRF","SRF","SRF","SRF","SRF","SRF","DCM","DCM","DCM",
            "DCM","DCM","MES","MES","MES","SRF","SRF","SRF","SRF","SRF","DCM","DCM","DCM","DCM",
            "MES","MES","MES","SRF","SRF","SRF","SRF","SRF","DCM","DCM","MES","MES","SRF","SRF",
            "DCM","MES","SRF","DCM","MES","SRF")
latitude <- c("-29,5333","-29,5333","-29,5333","-29,5333","-29,5333","-29,5046",
              "-29,5046","-29,5019","-29,5019","-29,5019","-29,5019","-35,2421",
              "-35,2421","-35,2421","-35,2421","-35,2421","-35,2421","-35,1889",
              "-35,1889","-35,1728","-35,1728","-35,1728","-35,1728","-35,1728",
              "-31,027","-31,027","-31,027","-31,027","-31,027","-31,027",
              "-31,0198","-31,0198","-31,0198","-31,0266","-31,0266","-31,0266",
              "-31,0266","-31,0266","-31,0266","-21,0292","-21,0292","-21,0292",
              "-21,0292","-21,0292","-20,9315","-20,9315","-20,9315","-20,9354",
              "-20,9354","-20,9354","-20,9354","-20,9354","-30,1484","-30,1484",
              "-30,1484","-30,1484","-30,1471","-30,1471","-30,1471","-30,1367",
              "-30,1367","-30,1367","-30,1367","-30,1367","-25,826","-25,826",
              "-25,8076","-25,8076","-25,8051","-25,8051","-16,9587","-16,9486",
              "-16,9601","-23,2189","-23,2232","-23,2811")
longitude <- c("37,9117","37,9117","37,9117","37,9117","37,9117","37,9599",
               "37,9599","37,9889","37,9889","37,9889","37,9889","26,3048",
               "26,3048","26,3048","26,3048","26,3048","26,3048","26,2905",
               "26,2905","26,2868","26,2868","26,2868","26,2868","26,2868",
               "4,6802","4,6802","4,6802","4,6802","4,6802","4,6802",
               "4,6685","4,6685","4,6685","4,665","4,665","4,665",
               "4,665","4,665","4,665","-35,3498","-35,3498","-35,3498",
               "-35,3498","-35,3498","-35,1794","-35,1794","-35,1794","-35,1803",
               "-35,1803","-35,1803","-35,1803","-35,1803","-43,2705","-43,2705",
               "-43,2705","-43,2705","-43,2915","-43,2915","-43,2915","-43,2899",
               "-43,2899","-43,2899","-43,2899","-43,2899","-111,7294","-111,7294",
               "-111,6906","-111,6906","-111,7202","-111,7202","-100,6751","-100,6715",
               "-100,6335","-129,4997","-129,5986", "-129,3947")
prof_meters <- c("65","65","65","65","65","1000","1000","5","5","5",
                 "5","30","30","30","30","30","30","850","850","5",
                 "5","5","5","5","50","50","50","50","50","50",
                 "700","700","700","5","5","5","5","5","5","150",
                 "150","150","150","150","800","800","800","5","5","5",
                 "5","5","120","120","120","120","800","800","800","5",
                 "5","5","5","5","188","188","488","488","5","5",
                 "90","350","5","155","696","5")
data_time <- c("2010-07-08T06:21","2010-07-08T06:21","2010-07-08T06:21","2010-07-08T06:21",
               "2010-07-08T06:21","2010-07-07T12:13:35","2010-07-07T12:13:35","2010-07-07T04:48",
               "2010-07-07T04:48","2010-07-07T04:48","2010-07-07T04:48","2010-07-12T11:03:22",
               "2010-07-12T11:03:22","2010-07-12T11:03:22","2010-07-12T11:03:22","2010-07-12T11:03:22",
               "2010-07-12T11:03:22","2010-07-12T06:46:23","2010-07-12T06:46:23","2010-07-12T05:59",
               "2010-07-12T05:59","2010-07-12T05:59","2010-07-12T05:59","2010-07-12T05:59",
               "2010-09-14T13:30","2010-09-14T13:30","2010-09-14T13:30","2010-09-14T13:30",
               "2010-09-14T13:30","2010-09-14T13:30","2010-09-13T13:02:33","2010-09-13T13:02:33",
               "2010-09-13T13:02:33","2010-09-14T06:55","2010-09-14T06:55","2010-09-14T06:55",
               "2010-09-14T06:55","2010-09-14T06:55","2010-09-14T06:55","2010-10-16T16:58:37",
               "2010-10-16T16:58:37","2010-10-16T16:58:37","2010-10-16T16:58:37","2010-10-16T16:58:37",
               "2010-10-17T09:05:05","2010-10-17T09:05:05","2010-10-17T09:05:05","2010-10-16T09:55",
               "2010-10-16T09:55","2010-10-16T09:55","2010-10-16T09:55","2010-10-16T09:55",
               "2010-11-04T18:16:53","2010-11-04T18:16:53","2010-11-04T18:16:53","2010-11-04T18:16:53",
               "2010-11-05T12:33:27","2010-11-05T12:33:27","2010-11-05T12:33:27","2010-11-04T10:04",
               "2010-11-04T10:04","2010-11-04T10:04","2010-11-04T10:04","2010-11-04T10:04",
               "2011-04-03T21:50:58","2011-04-03T21:50:58","2011-04-04T13:55:02","2011-04-04T13:55:02",
               "2011-04-03T13:44","2011-04-03T13:44","2011-05-31T20:28:10","2011-06-01T16:00:59",
               "2011-05-31T14:25","2011-06-15T00:55:48","2011-06-15T18:43:16","2011-06-14T16:45")
biome <- c("Coastal Biome","Coastal Biome","Coastal Biome","Coastal Biome", 
           "Coastal Biome","Coastal Biome","Coastal Biome","Coastal Biome", 
           "Coastal Biome","Coastal Biome","Coastal Biome","Coastal Biome", 
           "Coastal Biome","Coastal Biome","Coastal Biome","Coastal Biome", 
           "Coastal Biome","Coastal Biome","Coastal Biome","Coastal Biome", 
           "Coastal Biome","Coastal Biome","Coastal Biome","Coastal Biome", 
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome",
           "Trades Biome","Trades Biome","Trades Biome","Trades Biome")
shapes <- c("0","0","0","0","0","0","0","0","0","0","0","1","1","1",
            "1","1","1","1","1","1","1","1","1","1","2","2","2","2",
            "2","2","2","2","2","2","2","2","2","2","2","3","3","3",
            "3","3","3","3","3","3","3","3","3","3","4","4","4","4",
            "4","4","4","4","4","4","4","4","5","5","5","5","5","5",
            "7","7","7","9","9","9")
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
names_runs <- c("DCM - T064 - 594324","DCM - T064 - 598972","DCM - T064 - 599023","DCM - T064 - 599025",
                "DCM - T064 - 594385","MES - T064 - 599021","MES - T064 - 599164","SRF - T064 - 598970",
                "SRF - T064 - 599088","SRF - T064 - 599150","SRF - T064 - 594392","DCM - T065 - 594291",
                "DCM - T065 - 598990","DCM - T065 - 599018","DCM - T065 - 599110","DCM - T065 - 594382",
                "DCM - T065 - 594414","MES - T065 - 598960","MES - T065 - 599034","SRF - T065 - 594320",
                "SRF - T065 - 598979","SRF - T065 - 599146","SRF - T065 - 594359","SRF - T065 - 594361",
                "DCM - T068 - 599017","DCM - T068 - 599056","DCM - T068 - 599103","DCM - T068 - 594294",
                "DCM - T068 - 594348","DCM - T068 - 594415","MES - T068 - 598947","MES - T068 - 599131",
                "MES - T068 - 594302","SRF - T068 - 599129","SRF - T068 - 599171","SRF - T068 - 599174",
                "SRF - T068 - 594318","SRF - T068 - 594297","SRF - T068 - 594391","DCM - T076 - 599040",
                "DCM - T076 - 599148","DCM - T076 - 594321","DCM - T076 - 594298","DCM - T076 - 594355",
                "MES - T076 - 599000","MES - T076 - 599154","MES - T076 - 594333","SRF - T076 - 599010",
                "SRF - T076 - 599126","SRF - T076 - 594310","SRF - T076 - 594286","SRF - T076 - 594354",
                "DCM - T078 - 599046","DCM - T078 - 599101","DCM - T078 - 594336","DCM - T078 - 594303",
                "MES - T078 - 599124","MES - T078 - 599159","MES - T078 - 594289","SRF - T078 - 599006",
                "SRF - T078 - 599022","SRF - T078 - 594340","SRF - T078 - 594332","SRF - T078 - 594411",
                "DCM - T098 - 599042","DCM - T098 - 599079","MES - T098 - 599071","MES - T098 - 599085",
                "SRF - T098 - 599093","SRF - T098 - 599120","DCM - T111 - 598961","MES - T111 - 599086",
                "SRF - T111 - 599077","DCM - T112 - 598957","MES - T112 - 599072","SRF - T112 - 598954")
stations_name <- c("064","065","068","076","078","098","111","112")
depths_name <- c("SRF","DCM","MES")
indexes <- c("shannon","shannon.norm","pielou")
distances <- c("euclidean", "minkowski", "canberra")
methods <- c("single","complete","ward.D2","average")
comp_depths <- list( c("SRF", "DCM"), c("SRF", "MES"), c("DCM", "MES"))

############################################################################################################
############################################ PREPARING THE DATA ############################################
############################################################################################################

##### Retrieving samples
for (run in runs) {
  for (taxon in taxons){
    file_name <- paste0(path,taxon,"_",run,"_names.txt")
    vari_name <- paste0("cluster_",run,"_",taxon)
    assign(vari_name, read.csv(file_name, sep = "\t", header = FALSE, stringsAsFactors = FALSE))
    rm(file_name, vari_name)
  }
  rm(run, taxon)
}

##### Renaming columns
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("cluster_",run,"_",taxon))
    names(data_name)[1:2] <- c(taxon, "n")
    assign(paste0("cluster_",run,"_",taxon), data_name)
    rm(data_name)
  }
  rm(run, taxon)
}

##### Ordering dataframes
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("cluster_",run,"_",taxon))
    vari_name <- paste0("cluster_",run,"_",taxon)
    assign(vari_name, data_name[order(data_name$n, decreasing = TRUE), ])
    rm(data_name, vari_name)
  }
  rm(run, taxon)
}

##### Converting NAs
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("cluster_",run,"_",taxon))
    data_name[is.na(data_name)] <- "unclassified"
    assign(paste0("cluster_",run,"_",taxon), data_name)
    rm(data_name)
  }
  rm(run,taxon)
}

##### Excluding undefined
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("cluster_",run,"_",taxon))
    vari_name <- paste0("cluster_",run,"_",taxon)
    assign(vari_name, subset(data_name, data_name[,1] != "unclassified"))   #for unclassified data
    # assign(vari_name, subset(data_name, !is.na(data_name[,1])))             #for N.A. data
    rm(data_name, vari_name)
  }
  rm(run, taxon)
}

##### Transposing dataframes
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("cluster_",run,"_",taxon))
    vari_name <- paste0("trans_",run,"_",taxon)
    assign(vari_name, as.data.frame(t(data_name)))
    rm(data_name, vari_name)
  }
  rm(run, taxon)
}

##### Retrieving the names for the columns
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("cluster_",run,"_",taxon))
    vari_name <- paste0("colnames_",run,"_",taxon)
    assign(vari_name, data_name[,1])
    rm(data_name, vari_name)
  }
  rm(run, taxon)
}

##### Renaming columns
for (run in runs) {
  for (taxon in taxons){
    data_name1 <- get(paste0("trans_",run,"_",taxon))
    data_name2 <- get(paste0("colnames_",run,"_",taxon))
    names(data_name1) <- data_name2
    assign(paste0("trans_",run,"_",taxon), data_name1)
    rm(data_name1, data_name2)
  }
  rm(run, taxon)
}

##### Removing the line with the column names
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("trans_",run,"_",taxon))
    vari_name <- paste0("trans_",run,"_",taxon)
    data_name = data_name[-1,]
    assign(vari_name, data_name)
    rm(data_name)
  }
  rm(run, taxon)
}

##### Creating dataframes with all samples in each taxon
data_kingdom <- rbind.fill(trans_ERR594324_kingdom,trans_ERR598972_kingdom,trans_ERR599023_kingdom,trans_ERR599025_kingdom,trans_ERR594385_kingdom,trans_ERR599021_kingdom,trans_ERR599164_kingdom,trans_ERR598970_kingdom,
                           trans_ERR599088_kingdom,trans_ERR599150_kingdom,trans_ERR594392_kingdom,trans_ERR594291_kingdom,trans_ERR598990_kingdom,trans_ERR599018_kingdom,trans_ERR599110_kingdom,trans_ERR594382_kingdom,
                           trans_ERR594414_kingdom,trans_ERR598960_kingdom,trans_ERR599034_kingdom,trans_ERR594320_kingdom,trans_ERR598979_kingdom,trans_ERR599146_kingdom,trans_ERR594359_kingdom,trans_ERR594361_kingdom,
                           trans_ERR599017_kingdom,trans_ERR599056_kingdom,trans_ERR599103_kingdom,trans_ERR594294_kingdom,trans_ERR594348_kingdom,trans_ERR594415_kingdom,trans_ERR598947_kingdom,trans_ERR599131_kingdom,
                           trans_ERR594302_kingdom,trans_ERR599129_kingdom,trans_ERR599171_kingdom,trans_ERR599174_kingdom,trans_ERR594318_kingdom,trans_ERR594297_kingdom,trans_ERR594391_kingdom,trans_ERR599040_kingdom,
                           trans_ERR599148_kingdom,trans_ERR594321_kingdom,trans_ERR594298_kingdom,trans_ERR594355_kingdom,trans_ERR599000_kingdom,trans_ERR599154_kingdom,trans_ERR594333_kingdom,trans_ERR599010_kingdom,
                           trans_ERR599126_kingdom,trans_ERR594310_kingdom,trans_ERR594286_kingdom,trans_ERR594354_kingdom,trans_ERR599046_kingdom,trans_ERR599101_kingdom,trans_ERR594336_kingdom,trans_ERR594303_kingdom,
                           trans_ERR599124_kingdom,trans_ERR599159_kingdom,trans_ERR594289_kingdom,trans_ERR599006_kingdom,trans_ERR599022_kingdom,trans_ERR594340_kingdom,trans_ERR594332_kingdom,trans_ERR594411_kingdom,
                           trans_ERR599042_kingdom,trans_ERR599079_kingdom,trans_ERR599071_kingdom,trans_ERR599085_kingdom,trans_ERR599093_kingdom,trans_ERR599120_kingdom,trans_ERR598961_kingdom,trans_ERR599086_kingdom,
                           trans_ERR599077_kingdom,trans_ERR598957_kingdom,trans_ERR599072_kingdom,trans_ERR598954_kingdom)
data_phylum <- rbind.fill(trans_ERR594324_phylum,trans_ERR598972_phylum,trans_ERR599023_phylum,trans_ERR599025_phylum,trans_ERR594385_phylum,trans_ERR599021_phylum,trans_ERR599164_phylum,trans_ERR598970_phylum,
                          trans_ERR599088_phylum,trans_ERR599150_phylum,trans_ERR594392_phylum,trans_ERR594291_phylum,trans_ERR598990_phylum,trans_ERR599018_phylum,trans_ERR599110_phylum,trans_ERR594382_phylum,
                          trans_ERR594414_phylum,trans_ERR598960_phylum,trans_ERR599034_phylum,trans_ERR594320_phylum,trans_ERR598979_phylum,trans_ERR599146_phylum,trans_ERR594359_phylum,trans_ERR594361_phylum,
                          trans_ERR599017_phylum,trans_ERR599056_phylum,trans_ERR599103_phylum,trans_ERR594294_phylum,trans_ERR594348_phylum,trans_ERR594415_phylum,trans_ERR598947_phylum,trans_ERR599131_phylum,
                          trans_ERR594302_phylum,trans_ERR599129_phylum,trans_ERR599171_phylum,trans_ERR599174_phylum,trans_ERR594318_phylum,trans_ERR594297_phylum,trans_ERR594391_phylum,trans_ERR599040_phylum,
                          trans_ERR599148_phylum,trans_ERR594321_phylum,trans_ERR594298_phylum,trans_ERR594355_phylum,trans_ERR599000_phylum,trans_ERR599154_phylum,trans_ERR594333_phylum,trans_ERR599010_phylum,
                          trans_ERR599126_phylum,trans_ERR594310_phylum,trans_ERR594286_phylum,trans_ERR594354_phylum,trans_ERR599046_phylum,trans_ERR599101_phylum,trans_ERR594336_phylum,trans_ERR594303_phylum,
                          trans_ERR599124_phylum,trans_ERR599159_phylum,trans_ERR594289_phylum,trans_ERR599006_phylum,trans_ERR599022_phylum,trans_ERR594340_phylum,trans_ERR594332_phylum,trans_ERR594411_phylum,
                          trans_ERR599042_phylum,trans_ERR599079_phylum,trans_ERR599071_phylum,trans_ERR599085_phylum,trans_ERR599093_phylum,trans_ERR599120_phylum,trans_ERR598961_phylum,trans_ERR599086_phylum,
                          trans_ERR599077_phylum,trans_ERR598957_phylum,trans_ERR599072_phylum,trans_ERR598954_phylum)
data_class <- rbind.fill(trans_ERR594324_class,trans_ERR598972_class,trans_ERR599023_class,trans_ERR599025_class,trans_ERR594385_class,trans_ERR599021_class,trans_ERR599164_class,trans_ERR598970_class,
                         trans_ERR599088_class,trans_ERR599150_class,trans_ERR594392_class,trans_ERR594291_class,trans_ERR598990_class,trans_ERR599018_class,trans_ERR599110_class,trans_ERR594382_class,
                         trans_ERR594414_class,trans_ERR598960_class,trans_ERR599034_class,trans_ERR594320_class,trans_ERR598979_class,trans_ERR599146_class,trans_ERR594359_class,trans_ERR594361_class,
                         trans_ERR599017_class,trans_ERR599056_class,trans_ERR599103_class,trans_ERR594294_class,trans_ERR594348_class,trans_ERR594415_class,trans_ERR598947_class,trans_ERR599131_class,
                         trans_ERR594302_class,trans_ERR599129_class,trans_ERR599171_class,trans_ERR599174_class,trans_ERR594318_class,trans_ERR594297_class,trans_ERR594391_class,trans_ERR599040_class,
                         trans_ERR599148_class,trans_ERR594321_class,trans_ERR594298_class,trans_ERR594355_class,trans_ERR599000_class,trans_ERR599154_class,trans_ERR594333_class,trans_ERR599010_class,
                         trans_ERR599126_class,trans_ERR594310_class,trans_ERR594286_class,trans_ERR594354_class,trans_ERR599046_class,trans_ERR599101_class,trans_ERR594336_class,trans_ERR594303_class,
                         trans_ERR599124_class,trans_ERR599159_class,trans_ERR594289_class,trans_ERR599006_class,trans_ERR599022_class,trans_ERR594340_class,trans_ERR594332_class,trans_ERR594411_class,
                         trans_ERR599042_class,trans_ERR599079_class,trans_ERR599071_class,trans_ERR599085_class,trans_ERR599093_class,trans_ERR599120_class,trans_ERR598961_class,trans_ERR599086_class,
                         trans_ERR599077_class,trans_ERR598957_class,trans_ERR599072_class,trans_ERR598954_class)
data_order <- rbind.fill(trans_ERR594324_order,trans_ERR598972_order,trans_ERR599023_order,trans_ERR599025_order,trans_ERR594385_order,trans_ERR599021_order,trans_ERR599164_order,trans_ERR598970_order,
                         trans_ERR599088_order,trans_ERR599150_order,trans_ERR594392_order,trans_ERR594291_order,trans_ERR598990_order,trans_ERR599018_order,trans_ERR599110_order,trans_ERR594382_order,
                         trans_ERR594414_order,trans_ERR598960_order,trans_ERR599034_order,trans_ERR594320_order,trans_ERR598979_order,trans_ERR599146_order,trans_ERR594359_order,trans_ERR594361_order,
                         trans_ERR599017_order,trans_ERR599056_order,trans_ERR599103_order,trans_ERR594294_order,trans_ERR594348_order,trans_ERR594415_order,trans_ERR598947_order,trans_ERR599131_order,
                         trans_ERR594302_order,trans_ERR599129_order,trans_ERR599171_order,trans_ERR599174_order,trans_ERR594318_order,trans_ERR594297_order,trans_ERR594391_order,trans_ERR599040_order,
                         trans_ERR599148_order,trans_ERR594321_order,trans_ERR594298_order,trans_ERR594355_order,trans_ERR599000_order,trans_ERR599154_order,trans_ERR594333_order,trans_ERR599010_order,
                         trans_ERR599126_order,trans_ERR594310_order,trans_ERR594286_order,trans_ERR594354_order,trans_ERR599046_order,trans_ERR599101_order,trans_ERR594336_order,trans_ERR594303_order,
                         trans_ERR599124_order,trans_ERR599159_order,trans_ERR594289_order,trans_ERR599006_order,trans_ERR599022_order,trans_ERR594340_order,trans_ERR594332_order,trans_ERR594411_order,
                         trans_ERR599042_order,trans_ERR599079_order,trans_ERR599071_order,trans_ERR599085_order,trans_ERR599093_order,trans_ERR599120_order,trans_ERR598961_order,trans_ERR599086_order,
                         trans_ERR599077_order,trans_ERR598957_order,trans_ERR599072_order,trans_ERR598954_order)
data_family <- rbind.fill(trans_ERR594324_family,trans_ERR598972_family,trans_ERR599023_family,trans_ERR599025_family,trans_ERR594385_family,trans_ERR599021_family,trans_ERR599164_family,trans_ERR598970_family,
                          trans_ERR599088_family,trans_ERR599150_family,trans_ERR594392_family,trans_ERR594291_family,trans_ERR598990_family,trans_ERR599018_family,trans_ERR599110_family,trans_ERR594382_family,
                          trans_ERR594414_family,trans_ERR598960_family,trans_ERR599034_family,trans_ERR594320_family,trans_ERR598979_family,trans_ERR599146_family,trans_ERR594359_family,trans_ERR594361_family,
                          trans_ERR599017_family,trans_ERR599056_family,trans_ERR599103_family,trans_ERR594294_family,trans_ERR594348_family,trans_ERR594415_family,trans_ERR598947_family,trans_ERR599131_family,
                          trans_ERR594302_family,trans_ERR599129_family,trans_ERR599171_family,trans_ERR599174_family,trans_ERR594318_family,trans_ERR594297_family,trans_ERR594391_family,trans_ERR599040_family,
                          trans_ERR599148_family,trans_ERR594321_family,trans_ERR594298_family,trans_ERR594355_family,trans_ERR599000_family,trans_ERR599154_family,trans_ERR594333_family,trans_ERR599010_family,
                          trans_ERR599126_family,trans_ERR594310_family,trans_ERR594286_family,trans_ERR594354_family,trans_ERR599046_family,trans_ERR599101_family,trans_ERR594336_family,trans_ERR594303_family,
                          trans_ERR599124_family,trans_ERR599159_family,trans_ERR594289_family,trans_ERR599006_family,trans_ERR599022_family,trans_ERR594340_family,trans_ERR594332_family,trans_ERR594411_family,
                          trans_ERR599042_family,trans_ERR599079_family,trans_ERR599071_family,trans_ERR599085_family,trans_ERR599093_family,trans_ERR599120_family,trans_ERR598961_family,trans_ERR599086_family,
                          trans_ERR599077_family,trans_ERR598957_family,trans_ERR599072_family,trans_ERR598954_family)
data_genus <- rbind.fill(trans_ERR594324_genus,trans_ERR598972_genus,trans_ERR599023_genus,trans_ERR599025_genus,trans_ERR594385_genus,trans_ERR599021_genus,trans_ERR599164_genus,trans_ERR598970_genus,
                         trans_ERR599088_genus,trans_ERR599150_genus,trans_ERR594392_genus,trans_ERR594291_genus,trans_ERR598990_genus,trans_ERR599018_genus,trans_ERR599110_genus,trans_ERR594382_genus,
                         trans_ERR594414_genus,trans_ERR598960_genus,trans_ERR599034_genus,trans_ERR594320_genus,trans_ERR598979_genus,trans_ERR599146_genus,trans_ERR594359_genus,trans_ERR594361_genus,
                         trans_ERR599017_genus,trans_ERR599056_genus,trans_ERR599103_genus,trans_ERR594294_genus,trans_ERR594348_genus,trans_ERR594415_genus,trans_ERR598947_genus,trans_ERR599131_genus,
                         trans_ERR594302_genus,trans_ERR599129_genus,trans_ERR599171_genus,trans_ERR599174_genus,trans_ERR594318_genus,trans_ERR594297_genus,trans_ERR594391_genus,trans_ERR599040_genus,
                         trans_ERR599148_genus,trans_ERR594321_genus,trans_ERR594298_genus,trans_ERR594355_genus,trans_ERR599000_genus,trans_ERR599154_genus,trans_ERR594333_genus,trans_ERR599010_genus,
                         trans_ERR599126_genus,trans_ERR594310_genus,trans_ERR594286_genus,trans_ERR594354_genus,trans_ERR599046_genus,trans_ERR599101_genus,trans_ERR594336_genus,trans_ERR594303_genus,
                         trans_ERR599124_genus,trans_ERR599159_genus,trans_ERR594289_genus,trans_ERR599006_genus,trans_ERR599022_genus,trans_ERR594340_genus,trans_ERR594332_genus,trans_ERR594411_genus,
                         trans_ERR599042_genus,trans_ERR599079_genus,trans_ERR599071_genus,trans_ERR599085_genus,trans_ERR599093_genus,trans_ERR599120_genus,trans_ERR598961_genus,trans_ERR599086_genus,
                         trans_ERR599077_genus,trans_ERR598957_genus,trans_ERR599072_genus,trans_ERR598954_genus)
data_species <- rbind.fill(trans_ERR594324_species,trans_ERR598972_species,trans_ERR599023_species,trans_ERR599025_species,trans_ERR594385_species,trans_ERR599021_species,trans_ERR599164_species,trans_ERR598970_species,
                           trans_ERR599088_species,trans_ERR599150_species,trans_ERR594392_species,trans_ERR594291_species,trans_ERR598990_species,trans_ERR599018_species,trans_ERR599110_species,trans_ERR594382_species,
                           trans_ERR594414_species,trans_ERR598960_species,trans_ERR599034_species,trans_ERR594320_species,trans_ERR598979_species,trans_ERR599146_species,trans_ERR594359_species,trans_ERR594361_species,
                           trans_ERR599017_species,trans_ERR599056_species,trans_ERR599103_species,trans_ERR594294_species,trans_ERR594348_species,trans_ERR594415_species,trans_ERR598947_species,trans_ERR599131_species,
                           trans_ERR594302_species,trans_ERR599129_species,trans_ERR599171_species,trans_ERR599174_species,trans_ERR594318_species,trans_ERR594297_species,trans_ERR594391_species,trans_ERR599040_species,
                           trans_ERR599148_species,trans_ERR594321_species,trans_ERR594298_species,trans_ERR594355_species,trans_ERR599000_species,trans_ERR599154_species,trans_ERR594333_species,trans_ERR599010_species,
                           trans_ERR599126_species,trans_ERR594310_species,trans_ERR594286_species,trans_ERR594354_species,trans_ERR599046_species,trans_ERR599101_species,trans_ERR594336_species,trans_ERR594303_species,
                           trans_ERR599124_species,trans_ERR599159_species,trans_ERR594289_species,trans_ERR599006_species,trans_ERR599022_species,trans_ERR594340_species,trans_ERR594332_species,trans_ERR594411_species,
                           trans_ERR599042_species,trans_ERR599079_species,trans_ERR599071_species,trans_ERR599085_species,trans_ERR599093_species,trans_ERR599120_species,trans_ERR598961_species,trans_ERR599086_species,
                           trans_ERR599077_species,trans_ERR598957_species,trans_ERR599072_species,trans_ERR598954_species)

##### Renaming lines with sample names
for (taxon in taxons){
  data_name <- get(paste0("data_",taxon))
  row.names(data_name) <- names_runs
  assign(paste0("data_",taxon), data_name)
  rm(data_name, taxon)
}

##### Converting NAs to null values
for (taxon in taxons){
  data_name <- get(paste0("data_",taxon))
  data_name[is.na(data_name)] <- 0
  assign(paste0("data_",taxon), data_name)
  rm(data_name, taxon)
}

##### Converting dataframes from char to numeric
for (taxon in taxons){
  data_name <- get(paste0("data_",taxon))
  assign(paste0("data_",taxon), data_name %>% mutate_at(c(1:length(data_name)), as.numeric))
  rm(data_name, taxon)
}

###################################################################################################################################################################################
####################################################################### CALCULATION OF BIOLOGICAL DIVERSITY #######################################################################
###################################################################################################################################################################################

##### Creating biological diversity indices

##### Shannon Index
for (taxon in taxons){
  data_name <- get(paste0("data_",taxon))
  assign(paste0("shannon_",taxon), diversity(data_name))
  rm(data_name, taxon)
}

##### Shannon Index Normalized
for (taxon in taxons){
  data_name1 <- get(paste0("shannon_",taxon))
  data_name2 <- get(paste0("data_",taxon))
  assign(paste0("shannon.norm_",taxon), data_name1/log(ncol(data_name2)))
  rm(data_name1, data_name2, taxon)
}

##### Pielou's Equitability
for (taxon in taxons){
  data_name1 <- get(paste0("shannon_",taxon))
  data_name2 <- get(paste0("data_",taxon))
  assign(paste0("pielou_",taxon), data_name1/log(specnumber(data_name2)))
  rm(data_name1, data_name2, taxon)
}

##### Creating the biological diversity dataframes
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0(index,"_",taxon))
    vari_name <- paste0("data_",index,"_",taxon)
    assign(vari_name, data.frame(data_name))
  }
  rm(data_name, vari_name, taxon, index)
}

### Renaming data column
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("data_",index,"_",taxon))
    names(data_name)[1] <- c("diversity_index")
    assign(paste0("data_",index,"_",taxon), data_name)
  }
  rm(data_name, taxon, index)
}

##### Testing the normality of the indices

### Shannon
shannon_kingdom; order(shannon_kingdom); shannon_kingdom[order(shannon_kingdom)]; hist(shannon_kingdom)
shannon_phylum; order(shannon_phylum); shannon_phylum[order(shannon_phylum)]; hist(shannon_phylum)
shannon_class; order(shannon_class); shannon_class[order(shannon_class)]; hist(shannon_class)
shannon_order; order(shannon_order); shannon_order[order(shannon_order)]; hist(shannon_order)
shannon_family; order(shannon_family); shannon_family[order(shannon_family)]; hist(shannon_family)
shannon_genus; order(shannon_genus); shannon_genus[order(shannon_genus)]; hist(shannon_genus)
shannon_species; order(shannon_species); shannon_species[order(shannon_species)]; hist(shannon_species)

### Shannon Normalized
shannon.norm_kingdom; order(shannon.norm_kingdom); shannon.norm_kingdom[order(shannon.norm_kingdom)]; hist(shannon.norm_kingdom)
shannon.norm_phylum; order(shannon.norm_phylum); shannon.norm_phylum[order(shannon.norm_phylum)]; hist(shannon.norm_phylum)
shannon.norm_class; order(shannon.norm_class); shannon.norm_class[order(shannon.norm_class)]; hist(shannon.norm_class)
shannon.norm_order; order(shannon.norm_order); shannon.norm_order[order(shannon.norm_order)]; hist(shannon.norm_order)
shannon.norm_family; order(shannon.norm_family); shannon.norm_family[order(shannon.norm_family)]; hist(shannon.norm_family)
shannon.norm_genus; order(shannon.norm_genus); shannon.norm_genus[order(shannon.norm_genus)]; hist(shannon.norm_genus)
shannon.norm_species; order(shannon.norm_species); shannon.norm_species[order(shannon.norm_species)]; hist(shannon.norm_species)

### Pielou
pielou_kingdom; order(pielou_kingdom); pielou_kingdom[order(pielou_kingdom)]; hist(pielou_kingdom)
pielou_phylum; order(pielou_phylum); pielou_phylum[order(pielou_phylum)]; hist(pielou_phylum)
pielou_class; order(pielou_class); pielou_class[order(pielou_class)]; hist(pielou_class)
pielou_order; order(pielou_order); pielou_order[order(pielou_order)]; hist(pielou_order)
pielou_family; order(pielou_family); pielou_family[order(pielou_family)]; hist(pielou_family)
pielou_genus; order(pielou_genus); pielou_genus[order(pielou_genus)]; hist(pielou_genus)
pielou_species; order(pielou_species); pielou_species[order(pielou_species)]; hist(pielou_species)

########################################################################################################################################################################
############################################################################ DATA GROUPING #############################################################################
########################################################################################################################################################################

##### Clustering 1: Static package

### Distance matrices
for (taxon in taxons){
  for(index in indexes){
    for(distance in distances){
      data_name <- get(paste0("data_",index,"_",taxon))
      vari_name <- paste0("dist.",distance,"_",index,"_",taxon)
      assign(vari_name, dist(data_name, method=distance))
    }
  }
  rm(data_name, vari_name, taxon, index, distance)
}

### Grouping methods
for (taxon in taxons){
  for(index in indexes){
    for(distance in distances){
      for(method in methods){
        data_name <- get(paste0("dist.",distance,"_",index,"_",taxon))
        vari_name <- paste0("hc.",method,"_",distance,"_",index,"_",taxon)
        assign(vari_name, hclust(d=data_name,method=method))
      }
    }
  }
  rm(data_name, vari_name, taxon, index, distance, method)
}

### Dendrograms
for (taxon in taxons){
  for(index in indexes){
    for(distance in distances){
      for(method in methods){
        data_name <- get(paste0("hc.",method,"_",distance,"_",index,"_",taxon))
        vari_name <- paste0("dend.",method,"_",distance,"_",index,"_",taxon)
        assign(vari_name, as.dendrogram(data_name))
      }
    }
  }
  rm(data_name, vari_name, taxon, index, distance, method)
}


##### Clustering 2: MultivariateAnalysis Package

### Distance Matrix (MA) - Euclidean, Shannon and Pielou
for (taxon in taxons){
  for( index in indexes){
    data_name <- get(paste0("data_",index,"_",taxon))
    vari_name <- paste0("ma_dist.euclidean_",index,"_",taxon)
    assign(vari_name, (Distancia(data_name, Metodo = 1)))
  }
  rm(data_name, vari_name, taxon, index)
}

### Data and simplified printing of clusters - Shannon
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon_kingdom, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon_phylum, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon_class, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon_order, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon_family, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon_genus, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon_species, Metodo = 3)

### Data and simplified printing of clusters - Shannon Normalized
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon.norm_kingdom, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon.norm_phylum, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon.norm_class, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon.norm_order, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon.norm_family, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon.norm_genus, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_shannon.norm_species, Metodo = 3)

### Data and simplified printing of clusters - Pielou
Dendrograma(Dissimilaridade = ma_dist.euclidean_pielou_kingdom, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_pielou_phylum, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_pielou_class, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_pielou_order, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_pielou_family, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_pielou_genus, Metodo = 3)
Dendrograma(Dissimilaridade = ma_dist.euclidean_pielou_species, Metodo = 3)

###############################################################################################################################################################################
############################################################################ ASSEMBLY OF GRAPHICS #############################################################################
###############################################################################################################################################################################

##### Configuring the Figures (Normalized Shannon)
ngroups_kingdom <- 6; hgroups_kingdom <- 0.09368541;
ngroups_phylum <- 7; hgroups_phylum <- 0.02016725;
ngroups_class <- 7; hgroups_class <- 0.02249256;
ngroups_order <- 6; hgroups_order <- 0.03924449;
ngroups_family <- 7; hgroups_family <- 0.04585919;
ngroups_genus <- 6; hgroups_genus <- 0.05550896;
ngroups_species <- 7; hgroups_species <- 0.03345357;

mycolors <- c("#D32F2F", "#7B1FA2", "#303F9F", "#00796B", "#FFA000",
              "#F06292", "#E040FB", "#40C4FF", "#00E676", "#FFD600")
mycolors.black <- c(rep("black",8))

##### Dendrogram
for (taxon in taxons){
  for(index in indexes){
    for(distance in distances){
      for(method in methods){
        data_name <- get(paste0("hc.",method,"_",distance,"_",index,"_",taxon))
        vari_name <- paste0("dend_",method,"_",distance,"_",index,"_",taxon)
        assign(vari_name, fviz_dend(
          data_name, 
          # k = get(paste0("ngroups_",taxon)),
          h = get(paste0("hgroups_",taxon)),
          color_labels_by_k = FALSE, # 
          cex = 0.4,                 
          lwd = 0.4,                 
          rect = TRUE,               
          lower_rect = 0,
          k_colors = mycolors.black,       
          horiz = FALSE,
          # main = paste0("Dendrogram - Method: Average (UPGMA), Taxon: ", toupper(taxon)),
          xlab = "Samples",
          ylab = "Distance",
          sub = "",
          ggtheme = theme_classic())
        )
      }
    }
  }
  rm(data_name, vari_name, taxon, index, distance, method)
}

dend_average_euclidean_shannon.norm_kingdom
dend_average_euclidean_shannon.norm_phylum
dend_average_euclidean_shannon.norm_class
dend_average_euclidean_shannon.norm_order
dend_average_euclidean_shannon.norm_family
dend_average_euclidean_shannon.norm_genus
dend_average_euclidean_shannon.norm_species


############################################################################ EXPORTING FILES #############################################################################

### exporting files (PDF)
for (taxon in taxons){
  for(index in indexes){
    for(distance in distances) {
      for(method in methods){
        data_name <- get(paste0("dend_",method,"_",distance,"_",index,"_",taxon))
        vari_name <- paste0("~/meta_taraocean/data/results/output/biodiversity/plots/pdf/",index,"/dend/dend_",method,"_",distance,"_",index,"_",taxon,".pdf")
        ggsave(filename = vari_name, data_name,
               width = 15, height = 10, dpi = 500, units = "cm", device='pdf')
      }
    }
  }
  rm(data_name, vari_name, distance, method, index, taxon)
}

### exporting files (PNG)
for (taxon in taxons){
  for(index in indexes){
    for(distance in distances) {
      for(method in methods){
        data_name <- get(paste0("dend_",method,"_",distance,"_",index,"_",taxon))
        vari_name <- paste0("~/meta_taraocean/data/results/output/biodiversity/plots/png/",index,"/dend/dend_",method,"_",distance,"_",index,"_",taxon,".png")
        ggsave(filename = vari_name, data_name,
               width = 15, height = 10, dpi = 500, units = "cm", device='png')
      }
    }
  }
  rm(data_name, vari_name, distance, method, index, taxon)
}

### exporting files (SVG)
for (taxon in taxons){
  for(index in indexes){
    for(distance in distances) {
      for(method in methods){
        data_name <- get(paste0("dend_",method,"_",distance,"_",index,"_",taxon))
        vari_name <- paste0("~/meta_taraocean/data/results/output/biodiversity/plots/svg/",index,"/dend/dend_",method,"_",distance,"_",index,"_",taxon,".svg")
        dev.copy(svg,vari_name,width = 7,height = 5)
        dev.off()
      }
    }
  }
  rm(data_name, vari_name, distance, method, index, taxon)
}
############################################################################################################################################################################
############################################################################ DIVERSITY MEASURES ############################################################################
############################################################################################################################################################################

##### Retrieving the original data
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("data_",index,"_",taxon))
    vari_name <- paste0("complete_",index,"_",taxon)
    assign(vari_name, data_name)
  }
  rm(data_name, vari_name, taxon, index)
}

##### Adding data columns
for (taxon in taxons){
  for(index in indexes){
    data_name1 <- get(paste0("data_",taxon))
    data_name2 <- get(paste0("complete_",index,"_",taxon))
    data_name2$abund <- apply(data_name1[,], 1, sum)
    data_name2$depths <- depths
    data_name2$stations <- stations
    data_name2$shapes <- shapes
    data_name2$samples <- runs
    assign(paste0("complete","_",index,"_",taxon), data_name2)
  }
  rm(data_name1, data_name2, taxon, index)
}

################################################################################
################################################################################
################################################################################

#### Scatter Chart - Diversity x Abundance

for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("complete_",index,"_",taxon))
    vari_name <- paste0("stac.dvst.abdc_",index,"_",taxon)
    assign(vari_name, ggplot(data_name, aes(x = log10(abund), y = diversity_index)) +
             # geom_jitter(aes(color = factor(depths, levels = c("SRF","DCM","MES")), 
             #                 shape = shapes), position=position_jitter(width=.1), size = 3.5) + # COM FORMAS
             geom_jitter(aes(color = factor(depths, levels = c("SRF","DCM","MES"))),
                         position=position_jitter(width=.1), size = 2) + # SEM FORMAS
             # geom_hline(yintercept = 0.5) +
             # geom_vline(xintercept = max(data_name$abund)/2) +
             scale_color_manual(labels = c("SRF", "DCM", "MES"),
                                values = c("#303F9F","#D32F2F","#FFA000")) +
             scale_shape_manual(labels = c("064","065","068","076","078","098","111","112"),
                                values = c(0,1,2,3,4,5,7,9)) +
             # scale_x_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_y_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             scale_x_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             scale_y_continuous(limits = c(0, 1)) +
             labs(color = "Layers", shape = "Shapes", y = "Diversity", x = "log10(Abundance)") +
             theme(axis.text.x = element_text(angle = 90,hjust = 1,face = "italic"))
    )
  }
  rm(data_name, vari_name, index, taxon)
}

stac.dvst.abdc_shannon.norm_kingdom + theme_light()
stac.dvst.abdc_shannon.norm_phylum + theme_light()
stac.dvst.abdc_shannon.norm_class + theme_light()
stac.dvst.abdc_shannon.norm_order + theme_light()
stac.dvst.abdc_shannon.norm_family + theme_light()
stac.dvst.abdc_shannon.norm_genus + theme_light()
stac.dvst.abdc_shannon.norm_species + theme_light()

############################################################################ EXPORTING FILES #############################################################################

### exporting files (PDF)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.abdc_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/pdf/",index,"/stac.dvst.abdc/stac.dvst.abdc_",index,"_",taxon,".pdf")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='pdf')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (PNG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.abdc_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/png/",index,"/stac.dvst.abdc/stac.dvst.abdc_",index,"_",taxon,".png")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='png')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (SVG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.abdc_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/svg/",index,"/stac.dvst.abdc/stac.dvst.abdc_",index,"_",taxon,".svg")
    dev.copy(svg, vari_name, width = 7.5, height = 5)
    dev.off()
  }
  rm(data_name, vari_name, index, taxon)
}


##### Scatter Chart - Diversity x Stations

for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("complete_",index,"_",taxon))
    vari_name <- paste0("stac.dvst.stt","_",index,"_",taxon)
    assign(vari_name, ggplot(data_name, aes(x = stations, y = diversity_index)) +
             # geom_jitter(aes(color = factor(depths, levels = c("SRF","DCM","MES")), 
             #                 shape = shapes), position=position_jitter(width=.1), size = 3.5) + # COM FORMAS
             geom_jitter(aes(color = factor(depths, levels = c("SRF","DCM","MES"))),
                         position=position_jitter(width=.1), size = 2) + # SEM FORMAS
             # geom_hline(yintercept = 0.50) +
             # geom_vline(xintercept = 4.5) +
             scale_color_manual(labels = c("SRF", "DCM", "MES"),
                                values = c("#303F9F","#D32F2F","#FFA000")) +
             scale_shape_manual(labels = c("064","065","068","076","078","098","111","112"),
                                values = c(0,1,2,3,4,5,7,9)) +
             # scale_x_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_y_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_x_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             scale_y_continuous(limits = c(0, 1)) +
             labs(color = "Layers", shape = "Shapes",  y = "Diversity", x = "Stations") +
             theme(axis.text.x = element_text(angle = 90,hjust = 1,face = "italic"))
    )
  }
  rm(data_name, vari_name, index, taxon)
}

stac.dvst.stt_shannon.norm_kingdom + theme_light()
stac.dvst.stt_shannon.norm_phylum + theme_light()
stac.dvst.stt_shannon.norm_class + theme_light()
stac.dvst.stt_shannon.norm_order + theme_light()
stac.dvst.stt_shannon.norm_family + theme_light()
stac.dvst.stt_shannon.norm_genus + theme_light()
stac.dvst.stt_shannon.norm_species + theme_light()

############################################################################ EXPORTING FILES #############################################################################

### exporting files (PDF)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.stt_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/pdf/",index,"/stac.dvst.stt/stac.dvst.stt_",index,"_",taxon,".pdf")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='pdf')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (PNG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.stt_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/png/",index,"/stac.dvst.stt/stac.dvst.stt_",index,"_",taxon,".png")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='png')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (SVG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.stt_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/svg/",index,"/stac.dvst.stt/stac.dvst.stt_",index,"_",taxon,".svg")
    dev.copy(svg,vari_name,width = 7,height = 5)
    dev.off()
  }
  rm(data_name, vari_name, index, taxon)
}


### Scatter Chart - Abundance x Stations

for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("complete_",index,"_",taxon))
    vari_name <- paste0("stac.abdc.stt","_",index,"_",taxon)
    assign(vari_name, ggplot(data_name, aes(x = stations, y = log10(abund))) +
             # geom_jitter(aes(color = factor(depths, levels = c("SRF","DCM","MES")), 
             #                 shape = shapes), position=position_jitter(width=.1), size = 3.5) + # COM FORMAS
             geom_jitter(aes(color = factor(depths, levels = c("SRF","DCM","MES"))),
                         position=position_jitter(width=.1), size = 2) + # SEM FORMAS
             # geom_hline(yintercept = max(data_name$abund)/2) +
             # geom_vline(xintercept = 4.5) +
             scale_color_manual(labels = c("SRF", "DCM", "MES"),
                                values = c("#303F9F","#D32F2F","#FFA000")) +
             scale_shape_manual(labels = c("064","065","068","076","078","098","111","112"),
                                values = c(0,1,2,3,4,5,7,9)) +
             # scale_x_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_y_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_x_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             scale_y_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             labs(color = "Layers", shape = "Shapes", y = "log10(Abundance)", x = "Stations") +
             theme(axis.text.x = element_text(angle = 90,hjust = 1,face = "italic"))
    )
  }
  rm(data_name, vari_name, taxon, index)
}

stac.abdc.stt_shannon.norm_kingdom + theme_light()
stac.abdc.stt_shannon.norm_phylum + theme_light()
stac.abdc.stt_shannon.norm_class + theme_light()
stac.abdc.stt_shannon.norm_order + theme_light()
stac.abdc.stt_shannon.norm_family + theme_light()
stac.abdc.stt_shannon.norm_genus + theme_light()
stac.abdc.stt_shannon.norm_species + theme_light()

############################################################################ EXPORTING FILES #############################################################################

### exporting files (PDF)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.abdc.stt_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/pdf/",index,"/stac.abdc.stt/stac.abdc.stt_",index,"_",taxon,".pdf")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='pdf')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (PNG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.abdc.stt_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/png/",index,"/stac.abdc.stt/stac.abdc.stt_",index,"_",taxon,".png")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='png')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (SVG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.abdc.stt_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/svg/",index,"/stac.abdc.stt/stac.abdc.stt_",index,"_",taxon,".svg")
    dev.copy(svg,vari_name,width = 7,height = 5)
    dev.off()
  }
  rm(data_name, vari_name, index, taxon)
}


##### Boxplot - Diversity per depth

for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("complete_",index,"_",taxon))
    vari_name <- paste0("box.dvst.depths","_",index,"_",taxon)
    Layers <- factor(depths, levels = c("SRF","DCM","MES"), ordered = TRUE)
    assign(vari_name, ggplot(data_name, aes(x = Layers, y = diversity_index, color = Layers)) +
             geom_boxplot(aes(fill = Layers),outlier.shape=NA) +
             # geom_jitter(aes(shape=shapes), position=position_jitter(width=.1, height=0), size = 2.5) + # COM FORMAS
             geom_jitter(position=position_jitter(width=.1, height=0), size = 2) + # SEM FORMAS
             scale_color_manual(labels = c("SRF", "DCM", "MES"),
                                values = c("#020202","#330000","#FF6600")) +
             scale_fill_manual(labels = c("SRF", "DCM", "MES"),
                               values = c("#303F9F","#D32F2F","#FFA000")) +
             scale_shape_manual(labels = c("064","065","068","076","078","098","111","112"),
                                values = c(0,1,2,3,4,5,7,9)) +
             # scale_x_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_y_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_x_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             scale_y_continuous(limits = c(0, 1)) +
             # stat_compare_means(method = "wilcox.test", comparisons = comp_depths) +
             geom_signif(annotations = 'ns', y_position = 0.85, xmin = 1, xmax = 2, size = 0.3, textsize = 4.5, color = "black") +
             geom_signif(annotations = '****', y_position = 0.90, xmin = 2, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
             geom_signif(annotations = '****', y_position = 0.95, xmin = 1, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
             labs(y = "Diversity", x = "Layers") +
             theme(axis.text.x = element_text(angle = 90,hjust = 1,face = "italic"))
    )
  }
  rm(data_name, vari_name, taxon, index)
}

### Significance Test
compare_means(formula = diversity_index ~ depths, data = complete_shannon.norm_species, 
              method = "wilcox.test", p.adjust.method = "bonferroni")

box.dvst.depths_shannon.norm_kingdom + theme_light()
box.dvst.depths_shannon.norm_phylum + theme_light()
box.dvst.depths_shannon.norm_class + theme_light()
box.dvst.depths_shannon.norm_order + theme_light()
box.dvst.depths_shannon.norm_family + theme_light()
box.dvst.depths_shannon.norm_genus + theme_light()
box.dvst.depths_shannon.norm_species + theme_light()


############################################################################ EXPORTING FILES #############################################################################

### exporting files (PDF)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("box.dvst.depths_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/pdf/",index,"/box.dvst.depths/box.dvst.depths_",index,"_",taxon,".pdf")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='pdf')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (PNG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("box.dvst.depths_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/png/",index,"/box.dvst.depths/box.dvst.depths_",index,"_",taxon,".png")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='png')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (SVG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("box.dvst.depths_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/svg/",index,"/box.dvst.depths/box.dvst.depths_",index,"_",taxon,".svg")
    dev.copy(svg,vari_name,width = 7,height = 5)
    dev.off()
  }
  rm(data_name, vari_name, index, taxon)
}


##### Boxplot - Abundance per depth

for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("complete_",index,"_",taxon))
    vari_name <- paste0("box.abdc.depths","_",index,"_",taxon)
    Layers <- factor(depths, levels = c("SRF","DCM","MES"), ordered = TRUE)
    assign(vari_name, ggplot(data_name, aes(x = Layers, y = log10(abund), color = Layers)) +
             geom_boxplot(aes(fill = Layers),outlier.shape=NA) +
             # geom_jitter(aes(shape=shapes), position=position_jitter(width=.1, height=0), size = 2.5) + # COM FORMAS
             geom_jitter(position=position_jitter(width=.1, height=0), size = 2) + # SEM FORMAS
             scale_color_manual(labels = c("SRF", "DCM", "MES"),
                                values = c("#020202","#330000","#FF6600")) +
             scale_fill_manual(labels = c("SRF", "DCM", "MES"),
                               values = c("#303F9F","#D32F2F","#FFA000")) +
             scale_shape_manual(labels = c("064","065","068","076","078","098","111","112"),
                                values = c(0,1,2,3,4,5,7,9)) +
             # scale_x_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_y_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # scale_x_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             scale_y_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
             # stat_compare_means(method = "wilcox.test", comparisons = comp_depths) +
             geom_signif(annotations = 'ns', y_position = 8.00, xmin = 1, xmax = 2, size = 0.3, textsize = 4.5, color = "black") +
             geom_signif(annotations = 'ns', y_position = 8.15, xmin = 2, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
             geom_signif(annotations = 'ns', y_position = 8.30, xmin = 1, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
             labs(y = "log10(Abundance)", x = "Layers") +
             theme(axis.text.x = element_text(angle = 90,hjust = 1,face = "italic"))
    )
  }
  rm(data_name, vari_name, taxon, index)
}

### Significance Test
compare_means(formula = abund ~ depths, data = complete_shannon.norm_species,
              method = "wilcox.test", p.adjust.method = "bonferroni")

box.abdc.depths_shannon.norm_kingdom + theme_light()
box.abdc.depths_shannon.norm_phylum + theme_light()
box.abdc.depths_shannon.norm_class + theme_light()
box.abdc.depths_shannon.norm_order + theme_light()
box.abdc.depths_shannon.norm_family + theme_light()
box.abdc.depths_shannon.norm_genus + theme_light()
box.abdc.depths_shannon.norm_species + theme_light()

############################################################################ EXPORTING FILES #############################################################################

### exporting files (PDF)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("box.abdc.depths_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/pdf/",index,"/box.abdc.depths/box.abdc.depths_",index,"_",taxon,".pdf")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='pdf')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (PNG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("box.abdc.depths_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/png/",index,"/box.abdc.depths/box.abdc.depths_",index,"_",taxon,".png")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='png')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (SVG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("box.abdc.depths_",index,"_",taxon))
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/svg/",index,"/box.abdc.depths/box.abdc.depths_",index,"_",taxon,".svg")
    dev.copy(svg,vari_name,width = 7,height = 5)
    dev.off()
  }
  rm(data_name, vari_name, index, taxon)
}


##### Abundance and Diversity (average of stations per depth)

##### Retrieving full dataframe data
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("complete_",index,"_",taxon))
    vari_name <- paste0("stationsXdepths_",index,"_",taxon)
    assign(vari_name, data_name)
  }
  rm(data_name, vari_name, taxon, index)
}

##### Grouping lines by station and layer simultaneously
for (taxon in taxons){
  for(index in indexes){
    for(depth in depths_name){
      for(station in stations_name){
        data_name <- get(paste0("stationsXdepths_",index,"_",taxon))
        data_name <- data_name[(data_name$stations == station & data_name$depths == depth), ]
        vari_name <- paste0("T",station,".",depth,"_",index,"_",taxon)
        assign(vari_name, data_name)
      }
    }
  }
  rm(data_name, vari_name, taxon, depth, station)
}

##### Calculating the average of each column
for (taxon in taxons){
  for(index in indexes){
    for(depth in depths_name){
      for(station in stations_name){
        data_name <- get(paste0("T",station,".",depth,"_",index,"_",taxon))
        vari_name <- paste0("T",station,".",depth,"_",index,"_",taxon,".mean")
        assign(vari_name, as.data.frame(apply(data_name[,c("abund","diversity_index")], 2, mean)))
      }
    }
  }
  rm(data_name, vari_name, taxon, depth, station)
}

##### Transposing the dataframe
for (taxon in taxons){
  for(index in indexes){
    for(depth in depths_name){
      for(station in stations_name){
        data_name <- get(paste0("T",station,".",depth,"_",index,"_",taxon,".mean"))
        assign(paste0("T",station,".",depth,"_",index,"_",taxon,".mean"), t(data_name))
      }
    }
  }
  rm(data_name, taxon, depth, station)
}

##### Renaming the line
for (taxon in taxons){
  for(index in indexes){
    for(depth in depths_name){
      for(station in stations_name){
        data_name <- get(paste0("T",station,".",depth,"_",index,"_",taxon,".mean"))
        row.names(data_name) <- paste0("T",station,".",depth,"_",index,"_",taxon)
        assign(paste0("T",station,".",depth,"_",index,"_",taxon,".mean"), data_name)
      }
    }
  }
  rm(data_name, taxon, depth, station)
}

##### TESTS WITH INDEX: SHANNON.NORM, TAXON: SPECIES
species_SRF <- rbind(T064.SRF_shannon.norm_species.mean,T065.SRF_shannon.norm_species.mean,T068.SRF_shannon.norm_species.mean,
                     T076.SRF_shannon.norm_species.mean,T078.SRF_shannon.norm_species.mean,T098.SRF_shannon.norm_species.mean,
                     T111.SRF_shannon.norm_species.mean,T112.SRF_shannon.norm_species.mean)

species_DCM <- rbind(T064.DCM_shannon.norm_species.mean,T065.DCM_shannon.norm_species.mean,T068.DCM_shannon.norm_species.mean,
                     T076.DCM_shannon.norm_species.mean,T078.DCM_shannon.norm_species.mean,T098.DCM_shannon.norm_species.mean,
                     T111.DCM_shannon.norm_species.mean,T112.DCM_shannon.norm_species.mean)

species_MES <- rbind(T064.MES_shannon.norm_species.mean,T065.MES_shannon.norm_species.mean,T068.MES_shannon.norm_species.mean,
                     T076.MES_shannon.norm_species.mean,T078.MES_shannon.norm_species.mean,T098.MES_shannon.norm_species.mean,
                     T111.MES_shannon.norm_species.mean,T112.MES_shannon.norm_species.mean)

species_mean <- as.data.frame(rbind(species_SRF,species_DCM,species_MES))


species_mean$depths <- c("SRF","SRF","SRF","SRF","SRF","SRF","SRF","SRF",
                         "DCM","DCM","DCM","DCM","DCM","DCM","DCM","DCM",
                         "MES","MES","MES","MES","MES","MES","MES","MES")
species_mean$stations <- c("064","065","068","076","078","098","111","112",
                           "064","065","068","076","078","098","111","112",
                           "064","065","068","076","078","098","111","112")
species_mean$shapes <- c("0","1","2","3","4","5","7","9",
                         "0","1","2","3","4","5","7","9",
                         "0","1","2","3","4","5","7","9")

taxons <- c("species")

for (taxon in taxons){
  data_name <- get(paste0(taxon,"_mean"))
  vari_name <- paste0("stac.dvst.abdc.mean_",taxon)
  assign(vari_name, ggplot(data_name, aes(x = log10(abund), y = diversity_index)) +
           # geom_jitter(aes(color = factor(depths, levels = c("SRF","DCM","MES")),
           #                 shape = shapes), position=position_jitter(width=.1), size = 3.5) + # COM FORMAS
           geom_jitter(aes(color = factor(depths, levels = c("SRF","DCM","MES"))),
                       position=position_jitter(width=0), size = 2) + # SEM FORMAS
           # geom_errorbar(aes(ymin = diversity_index - sd(diversity_index),
           #                   ymax = diversity_index + sd(diversity_index)), width = 0.01) + 
           # geom_errorbarh(aes(xmin = log10(abund) - sd(log10(abund)),
           #                    xmax = log10(abund) + sd(log10(abund))), height = 0.01) + 
           # geom_point(position = position_dodge(0.1)) + 
           # geom_line(position = position_dodge(0.1)) + 
           # geom_hline(yintercept = 0.50) +
           # geom_vline(xintercept = max(log10(data_name$abund))/2) +
           scale_color_manual(labels = c("SRF", "DCM", "MES"),
                              values = c("#303F9F","#D32F2F","#FFA000")) +
           # scale_shape_manual(labels = c("064","065","068","076","078","098","111","112"),
           #                    values = c(0,1,2,3,4,5,7,9)) +
           # scale_x_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
           # scale_y_log10(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
           # scale_x_continuous(limits = c(0, 8)) +
           scale_y_continuous(limits = c(0, 1)) +
           labs(color = "Layers", shape = "Shapes", y = "Diversity", x = "log10(Abundance)") +
           theme(axis.text.x = element_text(angle = 90, hjust = 1, face = "italic"))
  )
  rm(data_name, vari_name, taxon)
}

stac.dvst.abdc.mean_species + theme_light()


############################################################################ EXPORTING FILES #############################################################################

### exporting files (PDF)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.abdc.mean_",taxon))
    # vari_name <- paste0("plots/pdf/",index,"/stac.dvst.abdc.mean/stac.dvst.abdc.mean_",taxon,".pdf")
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/pdf/shannon.norm/stac.dvst.abdc.mean/stac.dvst.abdc.mean_",taxon,".pdf")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='pdf')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (PNG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.abdc.mean_",taxon))
    # vari_name <- paste0("plots/png/",index,"/stac.dvst.abdc.mean/stac.dvst.abdc.mean_",taxon,".png")
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/png/shannon.norm/stac.dvst.abdc.mean/stac.dvst.abdc.mean_",taxon,".png")
    ggsave(filename = vari_name, data_name + theme_light(),
           width = 15, height = 10, dpi = 500, units = "cm", device='png')
  }
  rm(data_name, vari_name, index, taxon)
}

### exporting files (SVG)
for (taxon in taxons){
  for(index in indexes){
    data_name <- get(paste0("stac.dvst.abdc.mean_",taxon))
    # vari_name <- paste0("plots/svg/",index,"/stac.dvst.abdc.mean/stac.dvst.abdc.mean_",taxon,".svg")
    vari_name <- paste0("~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/svg/shannon.norm/stac.dvst.abdc.mean/stac.dvst.abdc.mean_",taxon,".svg")
    dev.copy(svg,vari_name,width = 7,height = 5)
    dev.off()
  }
  rm(data_name, vari_name, index, taxon)
}

taxons <- c("kingdom", "phylum", "class", "order", "family", "genus", "species")

### Building layout (grid) of the final figures
mounting_1 <- stac.dvst.abdc_shannon.norm_species + theme_light() +
  stac.dvst.abdc.mean_species + theme_light() +
  stac.dvst.stt_shannon.norm_species + theme_light() +
  stac.abdc.stt_shannon.norm_species + theme_light() +
  plot_layout(guides='collect') &
  theme(legend.position='top')
mounting_1

mounting_2 <- box.dvst.depths_shannon.norm_species + theme_light() +
  box.abdc.depths_shannon.norm_species + theme_light() +
  plot_layout(guides='collect') &
  theme(legend.position='top')
mounting_2

############################################################################ EXPORTING FILES #############################################################################

### exporting files (PDF)
ggsave(filename = "~/Documentos/meta_taraocean/data/results/output/biodiversity/plots/pdf/mounting/mounting_1.pdf", mounting_1,
       width = 30, height = 20, dpi = 500, units = "cm", device='pdf')
ggsave(filename = "~/Documentos/meta_taraocean/data/results/output/biodiversity/plots/pdf/mounting/mounting_2.pdf", mounting_2,
       width = 30, height = 15, dpi = 500, units = "cm", device='pdf')

### exporting files (PNG)
ggsave(filename = "~/Documentos/meta_taraocean/data/results/output/biodiversity/plots/png/mounting/mounting_1.png", mounting_1,
       width = 30, height = 20, dpi = 500, units = "cm", device='png')
ggsave(filename = "~/Documentos/meta_taraocean/data/results/output/biodiversity/plots/png/mounting/mounting_2.png", mounting_2,
       width = 30, height = 15, dpi = 500, units = "cm", device='png')

### exporting files (SVG)
mounting_1
dev.copy(svg,"~/Documentos/meta_taraocean/data/results/output/biodiversity/plots/svg/mounting/mounting_1.svg", width = 8, height = 6)
dev.off()
mounting_2
dev.copy(svg,"~/Documentos/meta_taraocean/data/results/output/biodiversity/plots/svg/mounting/mounting_2.svg", width = 8, height = 6)
dev.off()


##### Boxplot - Proportion of domains per depth

data_prop_kingdom_depth <- data_kingdom
data_prop_kingdom_depth$depth <- sapply(strsplit(rownames(data_prop_kingdom_depth), split = " - "), "[[" , 1)
data_prop_kingdom_depth$samples <- as.character(sapply(strsplit(rownames(data_prop_kingdom_depth), split = " - "), "[[" , 3))
data_prop_kingdom_depth %>% 
  pivot_longer(Viruses:Archaea, names_to = "domain", values_to = "n") %>% 
  group_by(samples) %>% 
  mutate(total_samples = sum(n), prop = round(n/total_samples, 4),
         depth = factor(depth, levels = c("SRF", "DCM", "MES"))) -> data_prop_kingdom_depth_plot 

prop_domain_depth <- 
  data_prop_kingdom_depth_plot %>%
  ggplot(aes(x = depth, y = prop, color = depth)) +
  geom_boxplot(aes(fill = depth)) +
  scale_color_manual(labels = c("SRF", "DCM", "MES"),
                     values = c("#020202","#330000","#FF6600")) +
  scale_fill_manual(labels = c("SRF", "DCM", "MES"),
                    values = c("#303F9F","#D32F2F","#FFA000")) +
  facet_wrap(~domain) +
  geom_signif(annotations = '', y_position = 1.05, xmin = 1, xmax = 2, size = 0.3, textsize = 4.5, color = "black") +
  geom_signif(annotations = '', y_position = 1.10, xmin = 2, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
  geom_signif(annotations = '', y_position = 1.15, xmin = 1, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
  labs(y = "Proportion", x = "Layers")
# stat_compare_means(method = "wilcox.test",
#                    comparisons = list(c("SRF", "DCM"), c("SRF", "MES"), c("DCM", "MES")))
prop_domain_depth

############################################################################ EXPORTING FILES #############################################################################

save(data_kingdom, data_prop_kingdom_depth, data_prop_kingdom_depth_plot, 
     prop_domain_depth, file = "prop_depth.RData")


##### Boxplot - Proportion of domains per ocean

data_prop_kingdom_ocean <- data_kingdom
data_prop_kingdom_ocean$ocean <- oceans
data_prop_kingdom_ocean$samples <- as.character(sapply(strsplit(rownames(data_prop_kingdom_ocean), split = " - "), "[[" , 3))
data_prop_kingdom_ocean %>% 
  pivot_longer(Viruses:Archaea, names_to = "domain", values_to = "n") %>% 
  group_by(samples) %>% 
  mutate(total_samples = sum(n), prop = round(n/total_samples, 4),
         ocean = factor(ocean, levels = c("IO", "SAO", "SPO"))) -> data_prop_kingdom_ocean_plot 

prop_domain_ocean <- 
  data_prop_kingdom_ocean_plot %>%
  ggplot(aes(x = ocean, y = prop, color = ocean)) +
  geom_boxplot(aes(fill = ocean)) +
  scale_color_manual(labels = c("IO", "SAO", "SPO"),
                     values = c("#303F9F","#D32F2F","#DAA520")) +
  scale_fill_manual(labels = c("IO", "SAO", "SPO"),
                    values = c("#7f80c7", "#ec45bd", "#dcbf73")) +
  facet_wrap(~domain) +
  geom_signif(annotations = '', y_position = 1.05, xmin = 1, xmax = 2, size = 0.3, textsize = 4.5, color = "black") +
  geom_signif(annotations = '', y_position = 1.10, xmin = 2, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
  geom_signif(annotations = '', y_position = 1.15, xmin = 1, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
  labs(y = "Proportion", x = "Layers")
# stat_compare_means(method = "wilcox.test",
#                    comparisons = list(c("IO", "SAO"), c("IO", "SPO"), c("SAO", "SPO")))
prop_domain_ocean

############################################################################ EXPORTING FILES #############################################################################

save(data_kingdom, data_prop_kingdom_ocean, data_prop_kingdom_ocean_plot, 
     prop_domain_ocean, file = "prop_ocean.RData")




#####################################################################################################################################################################
############################################################################ OTHER TESTS ############################################################################
#####################################################################################################################################################################

##### Taxonomic Average
names_groups <- c("DCM - T064 - 594324", "DCM - T064 - 594385", "DCM - T068 - 594415", "DCM - T065 - 594382", "SRF - T078 - 594411",
                  "SRF - T065 - 594359", "SRF - T068 - 594391", "DCM - T065 - 594414", "SRF - T065 - 594320", "DCM - T065 - 594291", 
                  "SRF - T065 - 594361", "SRF - T064 - 599150", "DCM - T098 - 599079", "SRF - T068 - 599129", "DCM - T068 - 599056",
                  "SRF - T068 - 599171", "SRF - T064 - 598970", "DCM - T068 - 599103", "DCM - T068 - 599017", "DCM - T068 - 594348",
                  "SRF - T098 - 599093", "SRF - T064 - 599088", "DCM - T112 - 598957", "SRF - T068 - 594297", "SRF - T078 - 599006",
                  "DCM - T068 - 594294", "SRF - T098 - 599120", "SRF - T076 - 594286", "SRF - T112 - 598954", "SRF - T068 - 599174",
                  "DCM - T078 - 594336", "DCM - T076 - 594321", "DCM - T098 - 599042", "SRF - T078 - 599022", "DCM - T111 - 598961",
                  "SRF - T064 - 594392", "DCM - T076 - 594355", "SRF - T076 - 594310", "SRF - T078 - 594332", "SRF - T076 - 594354",
                  "SRF - T068 - 594318", "SRF - T078 - 594340", "MES - T076 - 594333", "MES - T068 - 598947", "MES - T068 - 594302",
                  "MES - T064 - 599021", "MES - T068 - 599131", "DCM - T076 - 594298", "MES - T098 - 599071", "MES - T112 - 599072",
                  "MES - T098 - 599085", "DCM - T076 - 599148", "MES - T078 - 599159", "MES - T111 - 599086", "MES - T078 - 599124",
                  "MES - T065 - 598960", "MES - T076 - 599000", "MES - T078 - 594289", "MES - T076 - 599154", "MES - T065 - 599034",
                  "DCM - T076 - 599040", "DCM - T065 - 599018", "SRF - T076 - 599010", "DCM - T065 - 598990", "DCM - T065 - 599110",
                  "DCM - T064 - 599023", "DCM - T078 - 599101", "MES - T064 - 599164", "DCM - T078 - 599046", "SRF - T065 - 599146",
                  "SRF - T065 - 598979", "DCM - T078 - 594303", "DCM - T064 - 598972", "DCM - T064 - 599025", "SRF - T076 - 599126", 
                  "SRF - T111 - 599077")

order_group <- c(rep("G1",1), rep("G2",2), rep("G3",8), rep("G4",31), rep("G5",1), rep("G6",18), rep("G7",15))

G1 <- data_kingdom[c("DCM - T064 - 594324"), ]
G1_sum <- G1 %>% summarise_all(sum); row.names(G1_sum) <- "total"; G1 <- rbind(G1, G1_sum); row.names(G1)

G2 <- data_kingdom[c("DCM - T064 - 594385", "DCM - T068 - 594415"), ]
G2_sum <- G2 %>% summarise_all(sum); row.names(G2_sum) <- "total"; G2 <- rbind(G2, G2_sum); row.names(G2)

G3 <- data_kingdom[c("DCM - T065 - 594382", "SRF - T078 - 594411", "SRF - T065 - 594359", "SRF - T068 - 594391",
                     "DCM - T065 - 594414", "SRF - T065 - 594320", "DCM - T065 - 594291", "SRF - T065 - 594361"), ]
G3_sum <- G3 %>% summarise_all(sum); row.names(G3_sum) <- "total"; G3 <- rbind(G3, G3_sum); row.names(G3)

G4 <- data_kingdom[c("SRF - T064 - 599150", "DCM - T098 - 599079", "SRF - T068 - 599129", "DCM - T068 - 599056",
                     "SRF - T068 - 599171", "SRF - T064 - 598970", "DCM - T068 - 599103", "DCM - T068 - 599017",
                     "DCM - T068 - 594348", "SRF - T098 - 599093", "SRF - T064 - 599088", "DCM - T112 - 598957",
                     "SRF - T068 - 594297", "SRF - T078 - 599006", "DCM - T068 - 594294", "SRF - T098 - 599120",
                     "SRF - T076 - 594286", "SRF - T112 - 598954", "SRF - T068 - 599174", "DCM - T078 - 594336",
                     "DCM - T076 - 594321", "DCM - T098 - 599042", "SRF - T078 - 599022", "DCM - T111 - 598961",
                     "SRF - T064 - 594392", "DCM - T076 - 594355", "SRF - T076 - 594310", "SRF - T078 - 594332",
                     "SRF - T076 - 594354", "SRF - T068 - 594318", "SRF - T078 - 594340"), ]
G4_sum <- G4 %>% summarise_all(sum); row.names(G4_sum) <- "total"; G4 <- rbind(G4, G4_sum); row.names(G4)

G5 <- data_kingdom[c("MES - T076 - 594333"), ]
G5_sum <- G5 %>% summarise_all(sum); row.names(G5_sum) <- "total"; G5 <- rbind(G5, G5_sum); row.names(G5)

G6 <- data_kingdom[c("MES - T068 - 598947", "MES - T068 - 594302", "MES - T064 - 599021", "MES - T068 - 599131",
                     "DCM - T076 - 594298", "MES - T098 - 599071", "MES - T112 - 599072", "MES - T098 - 599085",
                     "DCM - T076 - 599148", "MES - T078 - 599159", "MES - T111 - 599086", "MES - T078 - 599124",
                     "MES - T065 - 598960", "MES - T076 - 599000", "MES - T078 - 594289", "MES - T076 - 599154",
                     "MES - T065 - 599034", "DCM - T076 - 599040"), ]
G6_sum <- G6 %>% summarise_all(sum); row.names(G6_sum) <- "total"; G6 <- rbind(G6, G6_sum); row.names(G6)

G7 <- data_kingdom[c("DCM - T065 - 599018", "SRF - T076 - 599010", "DCM - T065 - 598990", "DCM - T065 - 599110",
                     "DCM - T064 - 599023", "DCM - T078 - 599101", "MES - T064 - 599164", "DCM - T078 - 599046",
                     "SRF - T065 - 599146", "SRF - T065 - 598979", "DCM - T078 - 594303", "DCM - T064 - 598972",
                     "DCM - T064 - 599025", "SRF - T076 - 599126", "SRF - T111 - 599077"), ]
G7_sum <- G7 %>% summarise_all(sum); row.names(G7_sum) <- "total"; G7 <- rbind(G7, G7_sum); row.names(G7)


# ### Juntandos os grupos num único dataframe (sem sum)
# GROUPS <- rbind.fill(G1,G2,G3,G4,G5,G6,G7)
# GROUPS$groups <- order_group
# row.names(GROUPS) <- names_groups

### Juntandos os grupos num único dataframe (comsum)
GROUPS <- rbind.fill(G1_sum,G2_sum,G3_sum,G4_sum,G5_sum,G6_sum,G7_sum)
row.names(GROUPS) <- c("G1", "G2", "G3", "G4", "G5", "G6", "G7")
# GROUPS$total_ind <- apply(GROUPS[,], 1, sum)
GROUPS_PERCENT <- GROUPS/rowSums(GROUPS)
GROUPS_PERCENT$total_ind <- apply(GROUPS_PERCENT[,], 1, sum)
GROUPS_PERCENT <- GROUPS_PERCENT[,1:3]*100

######################### KINGDOM ######################### 
mat_pal_kgd <- c("#40C4FF","#F06292","#FFD600")

# Montando o dataset de plot
sample_kingdom <- c(rep("G1",3), rep("G2",3), rep("G3",3), rep("G4",3), rep("G5",3), rep("G6",3),rep("G7",3))

condition_kingdom <- rep(c("Viruses","Bacteria","Archaea"),7)

value_kingdom <- c(G1_sum$Viruses,G1_sum$Bacteria,G1_sum$Archaea,
                   G2_sum$Viruses,G2_sum$Bacteria,G2_sum$Archaea,
                   G3_sum$Viruses,G3_sum$Bacteria,G3_sum$Archaea,
                   G4_sum$Viruses,G4_sum$Bacteria,G4_sum$Archaea,
                   G5_sum$Viruses,G5_sum$Bacteria,G5_sum$Archaea,
                   G6_sum$Viruses,G6_sum$Bacteria,G6_sum$Archaea,
                   G7_sum$Viruses,G7_sum$Bacteria,G7_sum$Archaea)

dataplot_kingdom <- data.frame(sample_kingdom, condition_kingdom, value_kingdom)


############################################################################ EXPORTING FILES #############################################################################


### Salvando imagens (PDF)
ggsave(filename = "~/meta_taraocean/data/results/output/biodiversity/plots/pdf/mounting/taxonomic.mean.pdf", taxo_kingdom,
       width = 15, height = 10, dpi = 500, units = "cm", device='pdf')

### Salvando imagens (PNG)
ggsave(filename = "~/meta_taraocean/data/results/output/biodiversity/plots/png/mounting/taxonomic.mean.png", taxo_kingdom,
       width = 15, height = 10, dpi = 500, units = "cm", device='png')

### Salvando imagens (SVG)
taxo_kingdom
dev.copy(svg,"~/meta_taraocean/data/results/output/biodiversity/plots/svg/mounting/taxo_kingdom.svg", width = 7, height = 5)
dev.off()

#################################################################################################


prop_depth <- data_kingdom
prop_depth$depths <- factor(complete_shannon.norm_kingdom$depths, levels = c("SRF","DCM","MES"), ordered = TRUE)
prop_depth <- aggregate(x = data_kingdom, by = list(depths), FUN = "sum")
row.names(prop_depth) <- c("DCM","MES","SRF")
prop_depth <- subset(prop_depth, select = -c(Group.1))
prop_depth <- prop_depth %>% 
  mutate_at(c(1:length(prop_depth)), as.numeric)

prop_PERCENT <- prop_depth/rowSums(prop_depth)
prop_PERCENT$total_ind <- apply(prop_PERCENT[,], 1, sum)
prop_PERCENT <- prop_PERCENT[,1:3]*100

prop_DCM <- prop_depth[1,]
prop_MES <- prop_depth[2,]
prop_SRF <- prop_depth[3,]

# Montando o dataset de plot
sample_kingdom <- c(rep("SRF",3), rep("DCM",3), rep("MES",3))

condition_kingdom <- rep(c("Viruses","Bacteria","Archaea"),3)

value_kingdom <- c(prop_SRF$Viruses,prop_SRF$Bacteria,prop_SRF$Archaea,
                   prop_DCM$Viruses,prop_DCM$Bacteria,prop_DCM$Archaea,
                   prop_MES$Viruses,prop_MES$Bacteria,prop_MES$Archaea)

dataplot_kingdom <- data.frame(sample_kingdom, condition_kingdom, value_kingdom)

# Plotando
Layers <- factor(sample_kingdom, levels = c("SRF","DCM","MES"), ordered = TRUE)
taxo_kingdom <- ggplot(dataplot_kingdom, aes(fill=condition_kingdom, y=value_kingdom, x=Layers)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal_kgd, name  = "Domains") +
  labs(title = '',
       y = 'Frequency',
       x = 'Depths') +
  theme(plot.title = element_text(hjust = 0.5),         
        axis.text.x = element_text(vjust=0.6))
taxo_kingdom

############################################################################ EXPORTING FILES #############################################################################

save(data_kingdom, prop_depth, prop_SRF, prop_DCM, prop_MES, Layers,
     prop_PERCENT, sample_kingdom, condition_kingdom, value_kingdom, 
     dataplot_kingdom, mat_pal_kgd, taxo_kingdom, file = "prop_depth.RData")

### Salvando imagens (PDF)
ggsave(filename = "~/meta_taraocean/data/results/output/biodiversity/plots/pdf/mounting/prop_depth.mean.pdf", taxo_kingdom,
       width = 15, height = 10, dpi = 500, units = "cm", device='pdf')

### Salvando imagens (PNG)
ggsave(filename = "~/meta_taraocean/data/results/output/biodiversity/plots/png/mounting/prop_depth.mean.png", taxo_kingdom,
       width = 15, height = 10, dpi = 500, units = "cm", device='png')

### Salvando imagens (SVG)
taxo_kingdom
dev.copy(svg,"~/meta_taraocean/data/results/output/biodiversity/plots/svg/mounting/prop_depth.mean.svg", width = 7, height = 5)
dev.off()



##### Proporção de Domínios por camada

data_prop_kingdom <- data_kingdom
data_prop_kingdom$depth <- sapply(strsplit(rownames(data_prop_kingdom), split = " - "), "[[" , 1)
data_prop_kingdom$samples <- as.character(sapply(strsplit(rownames(data_prop_kingdom), split = " - "), "[[" , 3))
data_prop_kingdom %>% 
  pivot_longer(Viruses:Archaea, names_to = "domain", values_to = "n") %>% 
  group_by(samples) %>% 
  mutate(total_samples = sum(n), prop = round(n/total_samples, 4),
         depth = factor(depth, levels = c("SRF", "DCM", "MES"))) -> data_prop_kingdom_plot 

prop_domain <- 
  data_prop_kingdom_plot %>%
  ggplot(aes(x = depth, y = prop, color = depth)) +
  geom_boxplot(aes(fill = depth)) +
  scale_color_manual(labels = c("SRF", "DCM", "MES"),
                     values = c("#303F9F","#D32F2F","#FFA000")) +
  scale_fill_manual(labels = c("SRF", "DCM", "MES"),
                    values = c("#40C4FF","#F06292","#FFD600")) +
  facet_wrap(~domain) +
  # geom_signif(annotations = '', y_position = 1.05, xmin = 1, xmax = 2, size = 0.3, textsize = 4.5, color = "black") +
  # geom_signif(annotations = '', y_position = 1.10, xmin = 2, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
  # geom_signif(annotations = '', y_position = 1.15, xmin = 1, xmax = 3, size = 0.3, textsize = 4.5, color = "black")+
  labs(y = "Proportion", x = "Layers") + 
  stat_compare_means(method = "wilcox.test",
                     comparisons = list(c("SRF", "DCM"), c("SRF", "MES"), c("DCM", "MES")))
prop_domain

############################################################################ EXPORTING FILES #############################################################################

### Salvando imagens (PDF)
ggsave(filename = "~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/pdf/mounting/prop_domain.pdf", prop_domain,
       width = 15, height = 20, dpi = 500, units = "cm", device='pdf')

### Salvando imagens (PNG)
ggsave(filename = "~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/png/mounting/prop_domain.png", prop_domain,
       width = 15, height = 20, dpi = 500, units = "cm", device='png')

### Salvando imagens (SVG)
prop_domain
dev.copy(svg,"~/gitlab/meta_taraocean/data/results/output/biodiversity/plots/svg/mounting/prop_domain.svg", width = 5, height = 8)
dev.off()


