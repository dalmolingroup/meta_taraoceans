########################################################################################################
##################################### work environment preparation #####################################
########################################################################################################

### installing necessary packages to fulfill the requirements and requests of this work
# install.packages('dplyr'); # install.packages('tidyr'); # install.packages('ggplot2')
# install.packages("pals"); # install.packages("factoextra"); # install.packages("patchwork")

### loading the libraries
library(dplyr); library(tidyr); library(ggplot2); 
library(pals); library(factoextra); library(patchwork)

###################################################################### DEFINING VARIABLES ######################################################################
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

###################################################################### RETRIEVING SAMPLES ######################################################################
for (run in runs) {
  for (taxon in taxons){
    file_name <- paste0(path,taxon,"_",run,"_names.txt")
    vari_name <- paste0("rawdata_",run,"_",taxon)
    assign(vari_name, read.csv(file_name, sep = "\t", header = FALSE, stringsAsFactors = FALSE))
    rm(file_name, vari_name)
  }
  rm(run, taxon)
}
###################################################################### RENAMING COLUMNS ######################################################################
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("rawdata_",run,"_",taxon))
    names(data_name)[1:2] <- c(taxon, "n")
    assign(paste0("rawdata_",run,"_",taxon), data_name)
    rm(data_name)
  }
  rm(run, taxon)
}
###################################################################### ORDERING DATAFRAMES ######################################################################
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("rawdata_",run,"_",taxon))
    vari_name <- paste0("order_",run,"_",taxon)
    assign(vari_name, data_name[order(data_name$n, decreasing = TRUE), ])
    rm(data_name, vari_name)
  }
  rm(run, taxon)
}
###################################################################### Cleaning Data --> Converting NAs ######################################################################
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("order_",run,"_",taxon))
    data_name[is.na(data_name)] <- "unclassified"
    assign(paste0("order_",run,"_",taxon), data_name)
    rm(data_name)
  }
  rm(run,taxon)
}
###################################################################### RECOVERING FREQUENT ######################################################################

############################## Retrieving the 11 most frequent (including the undefined) ##############################
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("order_",run,"_",taxon))
    vari_name <- paste0("themore_",run,"_",taxon)
    assign(vari_name, data_name[1:11,])
    rm(data_name, vari_name)
  }
  rm(run, taxon)
}
############################## Retrieving the 10 most frequent (excluding the undefined) ##############################
### FOR NA
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("themore_",run,"_",taxon))
    vari_name <- paste0("final_",run,"_",taxon)
    assign(vari_name, subset(data_name, data_name[,1] != "unclassified"))   #for unclassified data
    # assign(vari_name, subset(data_name, !is.na(data_name[,1])))             #for N.A. data
    rm(data_name, vari_name)
  }
  rm(run, taxon)
}
###################################################################### JOINING DATAFRAMES ######################################################################

list_kingdom <- list(final_ERR594324_kingdom,final_ERR598972_kingdom,final_ERR599023_kingdom,final_ERR599025_kingdom,final_ERR594385_kingdom,final_ERR599021_kingdom,final_ERR599164_kingdom,final_ERR598970_kingdom,
                     final_ERR599088_kingdom,final_ERR599150_kingdom,final_ERR594392_kingdom,final_ERR594291_kingdom,final_ERR598990_kingdom,final_ERR599018_kingdom,final_ERR599110_kingdom,final_ERR594382_kingdom,
                     final_ERR594414_kingdom,final_ERR598960_kingdom,final_ERR599034_kingdom,final_ERR594320_kingdom,final_ERR598979_kingdom,final_ERR599146_kingdom,final_ERR594359_kingdom,final_ERR594361_kingdom,
                     final_ERR599017_kingdom,final_ERR599056_kingdom,final_ERR599103_kingdom,final_ERR594294_kingdom,final_ERR594348_kingdom,final_ERR594415_kingdom,final_ERR598947_kingdom,final_ERR599131_kingdom,
                     final_ERR594302_kingdom,final_ERR599129_kingdom,final_ERR599171_kingdom,final_ERR599174_kingdom,final_ERR594318_kingdom,final_ERR594297_kingdom,final_ERR594391_kingdom,final_ERR599040_kingdom,
                     final_ERR599148_kingdom,final_ERR594321_kingdom,final_ERR594298_kingdom,final_ERR594355_kingdom,final_ERR599000_kingdom,final_ERR599154_kingdom,final_ERR594333_kingdom,final_ERR599010_kingdom,
                     final_ERR599126_kingdom,final_ERR594310_kingdom,final_ERR594286_kingdom,final_ERR594354_kingdom,final_ERR599046_kingdom,final_ERR599101_kingdom,final_ERR594336_kingdom,final_ERR594303_kingdom,
                     final_ERR599124_kingdom,final_ERR599159_kingdom,final_ERR594289_kingdom,final_ERR599006_kingdom,final_ERR599022_kingdom,final_ERR594340_kingdom,final_ERR594332_kingdom,final_ERR594411_kingdom,
                     final_ERR599042_kingdom,final_ERR599079_kingdom,final_ERR599071_kingdom,final_ERR599085_kingdom,final_ERR599093_kingdom,final_ERR599120_kingdom,final_ERR598961_kingdom,final_ERR599086_kingdom,
                     final_ERR599077_kingdom,final_ERR598957_kingdom,final_ERR599072_kingdom,final_ERR598954_kingdom)
list_phylum <- list(final_ERR594324_phylum,final_ERR598972_phylum,final_ERR599023_phylum,final_ERR599025_phylum,final_ERR594385_phylum,final_ERR599021_phylum,final_ERR599164_phylum,final_ERR598970_phylum,
                    final_ERR599088_phylum,final_ERR599150_phylum,final_ERR594392_phylum,final_ERR594291_phylum,final_ERR598990_phylum,final_ERR599018_phylum,final_ERR599110_phylum,final_ERR594382_phylum,
                    final_ERR594414_phylum,final_ERR598960_phylum,final_ERR599034_phylum,final_ERR594320_phylum,final_ERR598979_phylum,final_ERR599146_phylum,final_ERR594359_phylum,final_ERR594361_phylum,
                    final_ERR599017_phylum,final_ERR599056_phylum,final_ERR599103_phylum,final_ERR594294_phylum,final_ERR594348_phylum,final_ERR594415_phylum,final_ERR598947_phylum,final_ERR599131_phylum,
                    final_ERR594302_phylum,final_ERR599129_phylum,final_ERR599171_phylum,final_ERR599174_phylum,final_ERR594318_phylum,final_ERR594297_phylum,final_ERR594391_phylum,final_ERR599040_phylum,
                    final_ERR599148_phylum,final_ERR594321_phylum,final_ERR594298_phylum,final_ERR594355_phylum,final_ERR599000_phylum,final_ERR599154_phylum,final_ERR594333_phylum,final_ERR599010_phylum,
                    final_ERR599126_phylum,final_ERR594310_phylum,final_ERR594286_phylum,final_ERR594354_phylum,final_ERR599046_phylum,final_ERR599101_phylum,final_ERR594336_phylum,final_ERR594303_phylum,
                    final_ERR599124_phylum,final_ERR599159_phylum,final_ERR594289_phylum,final_ERR599006_phylum,final_ERR599022_phylum,final_ERR594340_phylum,final_ERR594332_phylum,final_ERR594411_phylum,
                    final_ERR599042_phylum,final_ERR599079_phylum,final_ERR599071_phylum,final_ERR599085_phylum,final_ERR599093_phylum,final_ERR599120_phylum,final_ERR598961_phylum,final_ERR599086_phylum,
                    final_ERR599077_phylum,final_ERR598957_phylum,final_ERR599072_phylum,final_ERR598954_phylum)
list_class <- list(final_ERR594324_class,final_ERR598972_class,final_ERR599023_class,final_ERR599025_class,final_ERR594385_class,final_ERR599021_class,final_ERR599164_class,final_ERR598970_class,
                   final_ERR599088_class,final_ERR599150_class,final_ERR594392_class,final_ERR594291_class,final_ERR598990_class,final_ERR599018_class,final_ERR599110_class,final_ERR594382_class,
                   final_ERR594414_class,final_ERR598960_class,final_ERR599034_class,final_ERR594320_class,final_ERR598979_class,final_ERR599146_class,final_ERR594359_class,final_ERR594361_class,
                   final_ERR599017_class,final_ERR599056_class,final_ERR599103_class,final_ERR594294_class,final_ERR594348_class,final_ERR594415_class,final_ERR598947_class,final_ERR599131_class,
                   final_ERR594302_class,final_ERR599129_class,final_ERR599171_class,final_ERR599174_class,final_ERR594318_class,final_ERR594297_class,final_ERR594391_class,final_ERR599040_class,
                   final_ERR599148_class,final_ERR594321_class,final_ERR594298_class,final_ERR594355_class,final_ERR599000_class,final_ERR599154_class,final_ERR594333_class,final_ERR599010_class,
                   final_ERR599126_class,final_ERR594310_class,final_ERR594286_class,final_ERR594354_class,final_ERR599046_class,final_ERR599101_class,final_ERR594336_class,final_ERR594303_class,
                   final_ERR599124_class,final_ERR599159_class,final_ERR594289_class,final_ERR599006_class,final_ERR599022_class,final_ERR594340_class,final_ERR594332_class,final_ERR594411_class,
                   final_ERR599042_class,final_ERR599079_class,final_ERR599071_class,final_ERR599085_class,final_ERR599093_class,final_ERR599120_class,final_ERR598961_class,final_ERR599086_class,
                   final_ERR599077_class,final_ERR598957_class,final_ERR599072_class,final_ERR598954_class)
list_order <- list(final_ERR594324_order,final_ERR598972_order,final_ERR599023_order,final_ERR599025_order,final_ERR594385_order,final_ERR599021_order,final_ERR599164_order,final_ERR598970_order,
                   final_ERR599088_order,final_ERR599150_order,final_ERR594392_order,final_ERR594291_order,final_ERR598990_order,final_ERR599018_order,final_ERR599110_order,final_ERR594382_order,
                   final_ERR594414_order,final_ERR598960_order,final_ERR599034_order,final_ERR594320_order,final_ERR598979_order,final_ERR599146_order,final_ERR594359_order,final_ERR594361_order,
                   final_ERR599017_order,final_ERR599056_order,final_ERR599103_order,final_ERR594294_order,final_ERR594348_order,final_ERR594415_order,final_ERR598947_order,final_ERR599131_order,
                   final_ERR594302_order,final_ERR599129_order,final_ERR599171_order,final_ERR599174_order,final_ERR594318_order,final_ERR594297_order,final_ERR594391_order,final_ERR599040_order,
                   final_ERR599148_order,final_ERR594321_order,final_ERR594298_order,final_ERR594355_order,final_ERR599000_order,final_ERR599154_order,final_ERR594333_order,final_ERR599010_order,
                   final_ERR599126_order,final_ERR594310_order,final_ERR594286_order,final_ERR594354_order,final_ERR599046_order,final_ERR599101_order,final_ERR594336_order,final_ERR594303_order,
                   final_ERR599124_order,final_ERR599159_order,final_ERR594289_order,final_ERR599006_order,final_ERR599022_order,final_ERR594340_order,final_ERR594332_order,final_ERR594411_order,
                   final_ERR599042_order,final_ERR599079_order,final_ERR599071_order,final_ERR599085_order,final_ERR599093_order,final_ERR599120_order,final_ERR598961_order,final_ERR599086_order,
                   final_ERR599077_order,final_ERR598957_order,final_ERR599072_order,final_ERR598954_order)
list_family <- list(final_ERR594324_family,final_ERR598972_family,final_ERR599023_family,final_ERR599025_family,final_ERR594385_family,final_ERR599021_family,final_ERR599164_family,final_ERR598970_family,
                    final_ERR599088_family,final_ERR599150_family,final_ERR594392_family,final_ERR594291_family,final_ERR598990_family,final_ERR599018_family,final_ERR599110_family,final_ERR594382_family,
                    final_ERR594414_family,final_ERR598960_family,final_ERR599034_family,final_ERR594320_family,final_ERR598979_family,final_ERR599146_family,final_ERR594359_family,final_ERR594361_family,
                    final_ERR599017_family,final_ERR599056_family,final_ERR599103_family,final_ERR594294_family,final_ERR594348_family,final_ERR594415_family,final_ERR598947_family,final_ERR599131_family,
                    final_ERR594302_family,final_ERR599129_family,final_ERR599171_family,final_ERR599174_family,final_ERR594318_family,final_ERR594297_family,final_ERR594391_family,final_ERR599040_family,
                    final_ERR599148_family,final_ERR594321_family,final_ERR594298_family,final_ERR594355_family,final_ERR599000_family,final_ERR599154_family,final_ERR594333_family,final_ERR599010_family,
                    final_ERR599126_family,final_ERR594310_family,final_ERR594286_family,final_ERR594354_family,final_ERR599046_family,final_ERR599101_family,final_ERR594336_family,final_ERR594303_family,
                    final_ERR599124_family,final_ERR599159_family,final_ERR594289_family,final_ERR599006_family,final_ERR599022_family,final_ERR594340_family,final_ERR594332_family,final_ERR594411_family,
                    final_ERR599042_family,final_ERR599079_family,final_ERR599071_family,final_ERR599085_family,final_ERR599093_family,final_ERR599120_family,final_ERR598961_family,final_ERR599086_family,
                    final_ERR599077_family,final_ERR598957_family,final_ERR599072_family,final_ERR598954_family)
list_genus <- list(final_ERR594324_genus,final_ERR598972_genus,final_ERR599023_genus,final_ERR599025_genus,final_ERR594385_genus,final_ERR599021_genus,final_ERR599164_genus,final_ERR598970_genus,
                   final_ERR599088_genus,final_ERR599150_genus,final_ERR594392_genus,final_ERR594291_genus,final_ERR598990_genus,final_ERR599018_genus,final_ERR599110_genus,final_ERR594382_genus,
                   final_ERR594414_genus,final_ERR598960_genus,final_ERR599034_genus,final_ERR594320_genus,final_ERR598979_genus,final_ERR599146_genus,final_ERR594359_genus,final_ERR594361_genus,
                   final_ERR599017_genus,final_ERR599056_genus,final_ERR599103_genus,final_ERR594294_genus,final_ERR594348_genus,final_ERR594415_genus,final_ERR598947_genus,final_ERR599131_genus,
                   final_ERR594302_genus,final_ERR599129_genus,final_ERR599171_genus,final_ERR599174_genus,final_ERR594318_genus,final_ERR594297_genus,final_ERR594391_genus,final_ERR599040_genus,
                   final_ERR599148_genus,final_ERR594321_genus,final_ERR594298_genus,final_ERR594355_genus,final_ERR599000_genus,final_ERR599154_genus,final_ERR594333_genus,final_ERR599010_genus,
                   final_ERR599126_genus,final_ERR594310_genus,final_ERR594286_genus,final_ERR594354_genus,final_ERR599046_genus,final_ERR599101_genus,final_ERR594336_genus,final_ERR594303_genus,
                   final_ERR599124_genus,final_ERR599159_genus,final_ERR594289_genus,final_ERR599006_genus,final_ERR599022_genus,final_ERR594340_genus,final_ERR594332_genus,final_ERR594411_genus,
                   final_ERR599042_genus,final_ERR599079_genus,final_ERR599071_genus,final_ERR599085_genus,final_ERR599093_genus,final_ERR599120_genus,final_ERR598961_genus,final_ERR599086_genus,
                   final_ERR599077_genus,final_ERR598957_genus,final_ERR599072_genus,final_ERR598954_genus)
list_species <- list(final_ERR594324_species,final_ERR598972_species,final_ERR599023_species,final_ERR599025_species,final_ERR594385_species,final_ERR599021_species,final_ERR599164_species,final_ERR598970_species,
                     final_ERR599088_species,final_ERR599150_species,final_ERR594392_species,final_ERR594291_species,final_ERR598990_species,final_ERR599018_species,final_ERR599110_species,final_ERR594382_species,
                     final_ERR594414_species,final_ERR598960_species,final_ERR599034_species,final_ERR594320_species,final_ERR598979_species,final_ERR599146_species,final_ERR594359_species,final_ERR594361_species,
                     final_ERR599017_species,final_ERR599056_species,final_ERR599103_species,final_ERR594294_species,final_ERR594348_species,final_ERR594415_species,final_ERR598947_species,final_ERR599131_species,
                     final_ERR594302_species,final_ERR599129_species,final_ERR599171_species,final_ERR599174_species,final_ERR594318_species,final_ERR594297_species,final_ERR594391_species,final_ERR599040_species,
                     final_ERR599148_species,final_ERR594321_species,final_ERR594298_species,final_ERR594355_species,final_ERR599000_species,final_ERR599154_species,final_ERR594333_species,final_ERR599010_species,
                     final_ERR599126_species,final_ERR594310_species,final_ERR594286_species,final_ERR594354_species,final_ERR599046_species,final_ERR599101_species,final_ERR594336_species,final_ERR594303_species,
                     final_ERR599124_species,final_ERR599159_species,final_ERR594289_species,final_ERR599006_species,final_ERR599022_species,final_ERR594340_species,final_ERR594332_species,final_ERR594411_species,
                     final_ERR599042_species,final_ERR599079_species,final_ERR599071_species,final_ERR599085_species,final_ERR599093_species,final_ERR599120_species,final_ERR598961_species,final_ERR599086_species,
                     final_ERR599077_species,final_ERR598957_species,final_ERR599072_species,final_ERR598954_species)


for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("final_",run,"_",taxon))
    vari_name <- paste0("data_final_",taxon)
    list_name <- get(paste0("list_",taxon))
    assign(vari_name, data.frame(list_name))
    rm(data_name, vari_name,list_name)
  }
  rm(run, taxon)
}  

###################################################################### RENAMING COLUMNS ######################################################################

### KINGDOM
names(data_final_kingdom)[1:152] <- c("kingdom_ERR594324", "n", "kingdom_ERR598972", "n", "kingdom_ERR599023", "n", "kingdom_ERR599025", "n",
                                      "kingdom_ERR594385", "n", "kingdom_ERR599021", "n", "kingdom_ERR599164", "n", "kingdom_ERR598970", "n",
                                      "kingdom_ERR599088", "n", "kingdom_ERR599150", "n", "kingdom_ERR594392", "n", "kingdom_ERR594291", "n",
                                      "kingdom_ERR598990", "n", "kingdom_ERR599018", "n", "kingdom_ERR599110", "n", "kingdom_ERR594382", "n",
                                      "kingdom_ERR594414", "n", "kingdom_ERR598960", "n", "kingdom_ERR599034", "n", "kingdom_ERR594320", "n",
                                      "kingdom_ERR598979", "n", "kingdom_ERR599146", "n", "kingdom_ERR594359", "n", "kingdom_ERR594361", "n",
                                      "kingdom_ERR599017", "n", "kingdom_ERR599056", "n", "kingdom_ERR599103", "n", "kingdom_ERR594294", "n",
                                      "kingdom_ERR594348", "n", "kingdom_ERR594415", "n", "kingdom_ERR598947", "n", "kingdom_ERR599131", "n",
                                      "kingdom_ERR594302", "n", "kingdom_ERR599129", "n", "kingdom_ERR599171", "n", "kingdom_ERR599174", "n",
                                      "kingdom_ERR594318", "n", "kingdom_ERR594297", "n", "kingdom_ERR594391", "n", "kingdom_ERR599040", "n",
                                      "kingdom_ERR599148", "n", "kingdom_ERR594321", "n", "kingdom_ERR594298", "n", "kingdom_ERR594355", "n",
                                      "kingdom_ERR599000", "n", "kingdom_ERR599154", "n", "kingdom_ERR594333", "n", "kingdom_ERR599010", "n",
                                      "kingdom_ERR599126", "n", "kingdom_ERR594310", "n", "kingdom_ERR594286", "n", "kingdom_ERR594354", "n",
                                      "kingdom_ERR599046", "n", "kingdom_ERR599101", "n", "kingdom_ERR594336", "n", "kingdom_ERR594303", "n",
                                      "kingdom_ERR599124", "n", "kingdom_ERR599159", "n", "kingdom_ERR594289", "n", "kingdom_ERR599006", "n",
                                      "kingdom_ERR599022", "n", "kingdom_ERR594340", "n", "kingdom_ERR594332", "n", "kingdom_ERR594411", "n",
                                      "kingdom_ERR599042", "n", "kingdom_ERR599079", "n", "kingdom_ERR599071", "n", "kingdom_ERR599085", "n",
                                      "kingdom_ERR599093", "n", "kingdom_ERR599120", "n", "kingdom_ERR598961", "n", "kingdom_ERR599086", "n",
                                      "kingdom_ERR599077", "n", "kingdom_ERR598957", "n", "kingdom_ERR599072", "n", "kingdom_ERR598954", "n")

### PHYLUM
names(data_final_phylum)[1:152] <- c("phylum_ERR594324", "n", "phylum_ERR598972", "n", "phylum_ERR599023", "n", "phylum_ERR599025", "n",
                                     "phylum_ERR594385", "n", "phylum_ERR599021", "n", "phylum_ERR599164", "n", "phylum_ERR598970", "n",
                                     "phylum_ERR599088", "n", "phylum_ERR599150", "n", "phylum_ERR594392", "n", "phylum_ERR594291", "n",
                                     "phylum_ERR598990", "n", "phylum_ERR599018", "n", "phylum_ERR599110", "n", "phylum_ERR594382", "n",
                                     "phylum_ERR594414", "n", "phylum_ERR598960", "n", "phylum_ERR599034", "n", "phylum_ERR594320", "n",
                                     "phylum_ERR598979", "n", "phylum_ERR599146", "n", "phylum_ERR594359", "n", "phylum_ERR594361", "n",
                                     "phylum_ERR599017", "n", "phylum_ERR599056", "n", "phylum_ERR599103", "n", "phylum_ERR594294", "n",
                                     "phylum_ERR594348", "n", "phylum_ERR594415", "n", "phylum_ERR598947", "n", "phylum_ERR599131", "n",
                                     "phylum_ERR594302", "n", "phylum_ERR599129", "n", "phylum_ERR599171", "n", "phylum_ERR599174", "n",
                                     "phylum_ERR594318", "n", "phylum_ERR594297", "n", "phylum_ERR594391", "n", "phylum_ERR599040", "n",
                                     "phylum_ERR599148", "n", "phylum_ERR594321", "n", "phylum_ERR594298", "n", "phylum_ERR594355", "n",
                                     "phylum_ERR599000", "n", "phylum_ERR599154", "n", "phylum_ERR594333", "n", "phylum_ERR599010", "n",
                                     "phylum_ERR599126", "n", "phylum_ERR594310", "n", "phylum_ERR594286", "n", "phylum_ERR594354", "n",
                                     "phylum_ERR599046", "n", "phylum_ERR599101", "n", "phylum_ERR594336", "n", "phylum_ERR594303", "n",
                                     "phylum_ERR599124", "n", "phylum_ERR599159", "n", "phylum_ERR594289", "n", "phylum_ERR599006", "n",
                                     "phylum_ERR599022", "n", "phylum_ERR594340", "n", "phylum_ERR594332", "n", "phylum_ERR594411", "n",
                                     "phylum_ERR599042", "n", "phylum_ERR599079", "n", "phylum_ERR599071", "n", "phylum_ERR599085", "n",
                                     "phylum_ERR599093", "n", "phylum_ERR599120", "n", "phylum_ERR598961", "n", "phylum_ERR599086", "n",
                                     "phylum_ERR599077", "n", "phylum_ERR598957", "n", "phylum_ERR599072", "n", "phylum_ERR598954", "n")

### CLASS
names(data_final_class)[1:152] <- c("class_ERR594324", "n", "class_ERR598972", "n", "class_ERR599023", "n", "class_ERR599025", "n",
                                    "class_ERR594385", "n", "class_ERR599021", "n", "class_ERR599164", "n", "class_ERR598970", "n",
                                    "class_ERR599088", "n", "class_ERR599150", "n", "class_ERR594392", "n", "class_ERR594291", "n",
                                    "class_ERR598990", "n", "class_ERR599018", "n", "class_ERR599110", "n", "class_ERR594382", "n",
                                    "class_ERR594414", "n", "class_ERR598960", "n", "class_ERR599034", "n", "class_ERR594320", "n",
                                    "class_ERR598979", "n", "class_ERR599146", "n", "class_ERR594359", "n", "class_ERR594361", "n",
                                    "class_ERR599017", "n", "class_ERR599056", "n", "class_ERR599103", "n", "class_ERR594294", "n",
                                    "class_ERR594348", "n", "class_ERR594415", "n", "class_ERR598947", "n", "class_ERR599131", "n",
                                    "class_ERR594302", "n", "class_ERR599129", "n", "class_ERR599171", "n", "class_ERR599174", "n",
                                    "class_ERR594318", "n", "class_ERR594297", "n", "class_ERR594391", "n", "class_ERR599040", "n",
                                    "class_ERR599148", "n", "class_ERR594321", "n", "class_ERR594298", "n", "class_ERR594355", "n",
                                    "class_ERR599000", "n", "class_ERR599154", "n", "class_ERR594333", "n", "class_ERR599010", "n",
                                    "class_ERR599126", "n", "class_ERR594310", "n", "class_ERR594286", "n", "class_ERR594354", "n",
                                    "class_ERR599046", "n", "class_ERR599101", "n", "class_ERR594336", "n", "class_ERR594303", "n",
                                    "class_ERR599124", "n", "class_ERR599159", "n", "class_ERR594289", "n", "class_ERR599006", "n",
                                    "class_ERR599022", "n", "class_ERR594340", "n", "class_ERR594332", "n", "class_ERR594411", "n",
                                    "class_ERR599042", "n", "class_ERR599079", "n", "class_ERR599071", "n", "class_ERR599085", "n",
                                    "class_ERR599093", "n", "class_ERR599120", "n", "class_ERR598961", "n", "class_ERR599086", "n",
                                    "class_ERR599077", "n", "class_ERR598957", "n", "class_ERR599072", "n", "class_ERR598954", "n")

### ORDER
names(data_final_order)[1:152] <- c("order_ERR594324", "n", "order_ERR598972", "n", "order_ERR599023", "n", "order_ERR599025", "n",
                                    "order_ERR594385", "n", "order_ERR599021", "n", "order_ERR599164", "n", "order_ERR598970", "n",
                                    "order_ERR599088", "n", "order_ERR599150", "n", "order_ERR594392", "n", "order_ERR594291", "n",
                                    "order_ERR598990", "n", "order_ERR599018", "n", "order_ERR599110", "n", "order_ERR594382", "n",
                                    "order_ERR594414", "n", "order_ERR598960", "n", "order_ERR599034", "n", "order_ERR594320", "n",
                                    "order_ERR598979", "n", "order_ERR599146", "n", "order_ERR594359", "n", "order_ERR594361", "n",
                                    "order_ERR599017", "n", "order_ERR599056", "n", "order_ERR599103", "n", "order_ERR594294", "n",
                                    "order_ERR594348", "n", "order_ERR594415", "n", "order_ERR598947", "n", "order_ERR599131", "n",
                                    "order_ERR594302", "n", "order_ERR599129", "n", "order_ERR599171", "n", "order_ERR599174", "n",
                                    "order_ERR594318", "n", "order_ERR594297", "n", "order_ERR594391", "n", "order_ERR599040", "n",
                                    "order_ERR599148", "n", "order_ERR594321", "n", "order_ERR594298", "n", "order_ERR594355", "n",
                                    "order_ERR599000", "n", "order_ERR599154", "n", "order_ERR594333", "n", "order_ERR599010", "n",
                                    "order_ERR599126", "n", "order_ERR594310", "n", "order_ERR594286", "n", "order_ERR594354", "n",
                                    "order_ERR599046", "n", "order_ERR599101", "n", "order_ERR594336", "n", "order_ERR594303", "n",
                                    "order_ERR599124", "n", "order_ERR599159", "n", "order_ERR594289", "n", "order_ERR599006", "n",
                                    "order_ERR599022", "n", "order_ERR594340", "n", "order_ERR594332", "n", "order_ERR594411", "n",
                                    "order_ERR599042", "n", "order_ERR599079", "n", "order_ERR599071", "n", "order_ERR599085", "n",
                                    "order_ERR599093", "n", "order_ERR599120", "n", "order_ERR598961", "n", "order_ERR599086", "n",
                                    "order_ERR599077", "n", "order_ERR598957", "n", "order_ERR599072", "n", "order_ERR598954", "n")
### FAMILY
names(data_final_family)[1:152] <- c("family_ERR594324", "n", "family_ERR598972", "n", "family_ERR599023", "n", "family_ERR599025", "n",
                                     "family_ERR594385", "n", "family_ERR599021", "n", "family_ERR599164", "n", "family_ERR598970", "n",
                                     "family_ERR599088", "n", "family_ERR599150", "n", "family_ERR594392", "n", "family_ERR594291", "n",
                                     "family_ERR598990", "n", "family_ERR599018", "n", "family_ERR599110", "n", "family_ERR594382", "n",
                                     "family_ERR594414", "n", "family_ERR598960", "n", "family_ERR599034", "n", "family_ERR594320", "n",
                                     "family_ERR598979", "n", "family_ERR599146", "n", "family_ERR594359", "n", "family_ERR594361", "n",
                                     "family_ERR599017", "n", "family_ERR599056", "n", "family_ERR599103", "n", "family_ERR594294", "n",
                                     "family_ERR594348", "n", "family_ERR594415", "n", "family_ERR598947", "n", "family_ERR599131", "n",
                                     "family_ERR594302", "n", "family_ERR599129", "n", "family_ERR599171", "n", "family_ERR599174", "n",
                                     "family_ERR594318", "n", "family_ERR594297", "n", "family_ERR594391", "n", "family_ERR599040", "n",
                                     "family_ERR599148", "n", "family_ERR594321", "n", "family_ERR594298", "n", "family_ERR594355", "n",
                                     "family_ERR599000", "n", "family_ERR599154", "n", "family_ERR594333", "n", "family_ERR599010", "n",
                                     "family_ERR599126", "n", "family_ERR594310", "n", "family_ERR594286", "n", "family_ERR594354", "n",
                                     "family_ERR599046", "n", "family_ERR599101", "n", "family_ERR594336", "n", "family_ERR594303", "n",
                                     "family_ERR599124", "n", "family_ERR599159", "n", "family_ERR594289", "n", "family_ERR599006", "n",
                                     "family_ERR599022", "n", "family_ERR594340", "n", "family_ERR594332", "n", "family_ERR594411", "n",
                                     "family_ERR599042", "n", "family_ERR599079", "n", "family_ERR599071", "n", "family_ERR599085", "n",
                                     "family_ERR599093", "n", "family_ERR599120", "n", "family_ERR598961", "n", "family_ERR599086", "n",
                                     "family_ERR599077", "n", "family_ERR598957", "n", "family_ERR599072", "n", "family_ERR598954", "n")

### GENUS
names(data_final_genus)[1:152] <- c("genus_ERR594324", "n", "genus_ERR598972", "n", "genus_ERR599023", "n", "genus_ERR599025", "n",
                                    "genus_ERR594385", "n", "genus_ERR599021", "n", "genus_ERR599164", "n", "genus_ERR598970", "n",
                                    "genus_ERR599088", "n", "genus_ERR599150", "n", "genus_ERR594392", "n", "genus_ERR594291", "n",
                                    "genus_ERR598990", "n", "genus_ERR599018", "n", "genus_ERR599110", "n", "genus_ERR594382", "n",
                                    "genus_ERR594414", "n", "genus_ERR598960", "n", "genus_ERR599034", "n", "genus_ERR594320", "n",
                                    "genus_ERR598979", "n", "genus_ERR599146", "n", "genus_ERR594359", "n", "genus_ERR594361", "n",
                                    "genus_ERR599017", "n", "genus_ERR599056", "n", "genus_ERR599103", "n", "genus_ERR594294", "n",
                                    "genus_ERR594348", "n", "genus_ERR594415", "n", "genus_ERR598947", "n", "genus_ERR599131", "n",
                                    "genus_ERR594302", "n", "genus_ERR599129", "n", "genus_ERR599171", "n", "genus_ERR599174", "n",
                                    "genus_ERR594318", "n", "genus_ERR594297", "n", "genus_ERR594391", "n", "genus_ERR599040", "n",
                                    "genus_ERR599148", "n", "genus_ERR594321", "n", "genus_ERR594298", "n", "genus_ERR594355", "n",
                                    "genus_ERR599000", "n", "genus_ERR599154", "n", "genus_ERR594333", "n", "genus_ERR599010", "n",
                                    "genus_ERR599126", "n", "genus_ERR594310", "n", "genus_ERR594286", "n", "genus_ERR594354", "n",
                                    "genus_ERR599046", "n", "genus_ERR599101", "n", "genus_ERR594336", "n", "genus_ERR594303", "n",
                                    "genus_ERR599124", "n", "genus_ERR599159", "n", "genus_ERR594289", "n", "genus_ERR599006", "n",
                                    "genus_ERR599022", "n", "genus_ERR594340", "n", "genus_ERR594332", "n", "genus_ERR594411", "n",
                                    "genus_ERR599042", "n", "genus_ERR599079", "n", "genus_ERR599071", "n", "genus_ERR599085", "n",
                                    "genus_ERR599093", "n", "genus_ERR599120", "n", "genus_ERR598961", "n", "genus_ERR599086", "n",
                                    "genus_ERR599077", "n", "genus_ERR598957", "n", "genus_ERR599072", "n", "genus_ERR598954", "n")
### SPECIES
names(data_final_species)[1:152] <- c("species_ERR594324", "n", "species_ERR598972", "n", "species_ERR599023", "n", "species_ERR599025", "n",
                                      "species_ERR594385", "n", "species_ERR599021", "n", "species_ERR599164", "n", "species_ERR598970", "n",
                                      "species_ERR599088", "n", "species_ERR599150", "n", "species_ERR594392", "n", "species_ERR594291", "n",
                                      "species_ERR598990", "n", "species_ERR599018", "n", "species_ERR599110", "n", "species_ERR594382", "n",
                                      "species_ERR594414", "n", "species_ERR598960", "n", "species_ERR599034", "n", "species_ERR594320", "n",
                                      "species_ERR598979", "n", "species_ERR599146", "n", "species_ERR594359", "n", "species_ERR594361", "n",
                                      "species_ERR599017", "n", "species_ERR599056", "n", "species_ERR599103", "n", "species_ERR594294", "n",
                                      "species_ERR594348", "n", "species_ERR594415", "n", "species_ERR598947", "n", "species_ERR599131", "n",
                                      "species_ERR594302", "n", "species_ERR599129", "n", "species_ERR599171", "n", "species_ERR599174", "n",
                                      "species_ERR594318", "n", "species_ERR594297", "n", "species_ERR594391", "n", "species_ERR599040", "n",
                                      "species_ERR599148", "n", "species_ERR594321", "n", "species_ERR594298", "n", "species_ERR594355", "n",
                                      "species_ERR599000", "n", "species_ERR599154", "n", "species_ERR594333", "n", "species_ERR599010", "n",
                                      "species_ERR599126", "n", "species_ERR594310", "n", "species_ERR594286", "n", "species_ERR594354", "n",
                                      "species_ERR599046", "n", "species_ERR599101", "n", "species_ERR594336", "n", "species_ERR594303", "n",
                                      "species_ERR599124", "n", "species_ERR599159", "n", "species_ERR594289", "n", "species_ERR599006", "n",
                                      "species_ERR599022", "n", "species_ERR594340", "n", "species_ERR594332", "n", "species_ERR594411", "n",
                                      "species_ERR599042", "n", "species_ERR599079", "n", "species_ERR599071", "n", "species_ERR599085", "n",
                                      "species_ERR599093", "n", "species_ERR599120", "n", "species_ERR598961", "n", "species_ERR599086", "n",
                                      "species_ERR599077", "n", "species_ERR598957", "n", "species_ERR599072", "n", "species_ERR598954", "n")

###################################################################### PLOTTING GRAPHS ######################################################################

# Conditions 
for (run in runs) {
  for (taxon in taxons){
    data_name <- get(paste0("final_",run,"_",taxon))
    vari_name <- paste0("cdt_",run,"_",taxon)
    if(taxon == "kingdom"){
      assign(vari_name, c(data_name[,1][1:3]))
    } else {
      assign(vari_name, c(data_name[,1][1:10]))
    }
    rm(data_name, vari_name)
  }
  rm(run, taxon)
}

######################### KINGDOM ######################### 

# Assembling the plot dataset
sample_kingdom <- c(rep("01 - DCM - T064 - 594324",3),  rep("02 - DCM - T064 - 594385",3),  rep("03 - DCM - T068 - 594415",3),  rep("04 - DCM - T065 - 594382",3),
                    rep("05 - SRF - T078 - 594411",3),  rep("06 - SRF - T065 - 594359",3),  rep("07 - SRF - T068 - 594391",3),  rep("08 - DCM - T065 - 594414",3),
                    rep("09 - SRF - T065 - 594320",3),  rep("10 - DCM - T065 - 594291",3),  rep("11 - SRF - T065 - 594361",3),  rep("12 - SRF - T064 - 599150",3),
                    rep("13 - DCM - T098 - 599079",3),  rep("14 - SRF - T068 - 599129",3),  rep("15 - DCM - T068 - 599056",3),  rep("16 - SRF - T068 - 599171",3),
                    rep("17 - SRF - T064 - 598970",3),  rep("18 - DCM - T068 - 599103",3),  rep("19 - DCM - T068 - 599017",3),  rep("20 - DCM - T068 - 594348",3),
                    rep("21 - SRF - T098 - 599093",3),  rep("22 - SRF - T064 - 599088",3),  rep("23 - DCM - T112 - 598957",3),  rep("24 - SRF - T068 - 594297",3),
                    rep("25 - SRF - T078 - 599006",3),  rep("26 - DCM - T068 - 594294",3),  rep("27 - SRF - T098 - 599120",3),  rep("28 - SRF - T076 - 594286",3),
                    rep("29 - SRF - T112 - 598954",3),  rep("30 - SRF - T068 - 599174",3),  rep("31 - DCM - T078 - 594336",3),  rep("32 - DCM - T076 - 594321",3),
                    rep("33 - DCM - T068 - 599042",3),  rep("34 - SRF - T078 - 599022",3),  rep("35 - DCM - T111 - 598961",3),  rep("36 - SRF - T064 - 594392",3),
                    rep("37 - DCM - T076 - 594355",3),  rep("38 - SRF - T076 - 594310",3),  rep("39 - SRF - T078 - 594332",3),  rep("40 - SRF - T076 - 594354",3),
                    rep("41 - SRF - T068 - 594318",3),  rep("42 - SRF - T078 - 594340",3),  rep("43 - MES - T076 - 594333",3),  rep("44 - MES - T068 - 598947",3),
                    rep("45 - MES - T068 - 594302",3),  rep("46 - MES - T064 - 599021",3),  rep("47 - MES - T068 - 599131",3),  rep("48 - DCM - T076 - 594298",3),
                    rep("49 - MES - T098 - 599071",3),  rep("50 - MES - T112 - 599072",3),  rep("51 - MES - T098 - 599085",3),  rep("52 - DCM - T076 - 599148",3),
                    rep("53 - MES - T078 - 599159",3),  rep("54 - MES - T111 - 599086",3),  rep("55 - MES - T078 - 599124",3),  rep("56 - MES - T065 - 598960",3),
                    rep("57 - MES - T076 - 599000",3),  rep("58 - MES - T078 - 594289",3),  rep("59 - MES - T076 - 599154",3),  rep("60 - MES - T065 - 599034",3),
                    rep("61 - DCM - T076 - 599040",3),  rep("62 - DCM - T065 - 599018",3),  rep("63 - SRF - T076 - 599010",3),  rep("64 - DCM - T065 - 598990",3),
                    rep("65 - DCM - T065 - 599110",3),  rep("66 - DCM - T064 - 599023",3),  rep("67 - DCM - T078 - 599101",3),  rep("68 - MES - T064 - 599164",3),
                    rep("69 - DCM - T078 - 599046",3),  rep("70 - SRF - T065 - 599146",3),  rep("71 - SRF - T065 - 598979",3),  rep("72 - DCM - T078 - 594303",3),
                    rep("73 - DCM - T064 - 598972",3),  rep("74 - DCM - T064 - 599025",3),  rep("75 - SRF - T076 - 599126",3),  rep("76 - SRF - T111 - 599077",3))

condition_kingdom <- c(cdt_ERR594324_kingdom,cdt_ERR594385_kingdom,cdt_ERR594415_kingdom,cdt_ERR594382_kingdom,
                       cdt_ERR594411_kingdom,cdt_ERR594359_kingdom,cdt_ERR594391_kingdom,cdt_ERR594414_kingdom,
                       cdt_ERR594320_kingdom,cdt_ERR594291_kingdom,cdt_ERR594361_kingdom,cdt_ERR599150_kingdom,
                       cdt_ERR599079_kingdom,cdt_ERR599129_kingdom,cdt_ERR599056_kingdom,cdt_ERR599171_kingdom,
                       cdt_ERR598970_kingdom,cdt_ERR599103_kingdom,cdt_ERR599017_kingdom,cdt_ERR594348_kingdom,
                       cdt_ERR599093_kingdom,cdt_ERR599088_kingdom,cdt_ERR598957_kingdom,cdt_ERR594297_kingdom,
                       cdt_ERR599006_kingdom,cdt_ERR594294_kingdom,cdt_ERR599120_kingdom,cdt_ERR594286_kingdom,
                       cdt_ERR598954_kingdom,cdt_ERR599174_kingdom,cdt_ERR594336_kingdom,cdt_ERR594321_kingdom,
                       cdt_ERR599042_kingdom,cdt_ERR599022_kingdom,cdt_ERR598961_kingdom,cdt_ERR594392_kingdom,
                       cdt_ERR594355_kingdom,cdt_ERR594310_kingdom,cdt_ERR594332_kingdom,cdt_ERR594354_kingdom,
                       cdt_ERR594318_kingdom,cdt_ERR594340_kingdom,cdt_ERR594333_kingdom,cdt_ERR598947_kingdom,
                       cdt_ERR594302_kingdom,cdt_ERR599021_kingdom,cdt_ERR599131_kingdom,cdt_ERR594298_kingdom,
                       cdt_ERR599071_kingdom,cdt_ERR599072_kingdom,cdt_ERR599085_kingdom,cdt_ERR599148_kingdom,
                       cdt_ERR599159_kingdom,cdt_ERR599086_kingdom,cdt_ERR599124_kingdom,cdt_ERR598960_kingdom,
                       cdt_ERR599000_kingdom,cdt_ERR594289_kingdom,cdt_ERR599154_kingdom,cdt_ERR599034_kingdom,
                       cdt_ERR599040_kingdom,cdt_ERR599018_kingdom,cdt_ERR599010_kingdom,cdt_ERR598990_kingdom,
                       cdt_ERR599110_kingdom,cdt_ERR599023_kingdom,cdt_ERR599101_kingdom,cdt_ERR599164_kingdom,
                       cdt_ERR599046_kingdom,cdt_ERR599146_kingdom,cdt_ERR598979_kingdom,cdt_ERR594303_kingdom,
                       cdt_ERR598972_kingdom,cdt_ERR599025_kingdom,cdt_ERR599126_kingdom,cdt_ERR599077_kingdom)

value_kingdom <- c(final_ERR594324_kingdom$n,final_ERR594385_kingdom$n,final_ERR594415_kingdom$n,final_ERR594382_kingdom$n,
                   final_ERR594411_kingdom$n,final_ERR594359_kingdom$n,final_ERR594391_kingdom$n,final_ERR594414_kingdom$n,
                   final_ERR594320_kingdom$n,final_ERR594291_kingdom$n,final_ERR594361_kingdom$n,final_ERR599150_kingdom$n,
                   final_ERR599079_kingdom$n,final_ERR599129_kingdom$n,final_ERR599056_kingdom$n,final_ERR599171_kingdom$n,
                   final_ERR598970_kingdom$n,final_ERR599103_kingdom$n,final_ERR599017_kingdom$n,final_ERR594348_kingdom$n,
                   final_ERR599093_kingdom$n,final_ERR599088_kingdom$n,final_ERR598957_kingdom$n,final_ERR594297_kingdom$n,
                   final_ERR599006_kingdom$n,final_ERR594294_kingdom$n,final_ERR599120_kingdom$n,final_ERR594286_kingdom$n,
                   final_ERR598954_kingdom$n,final_ERR599174_kingdom$n,final_ERR594336_kingdom$n,final_ERR594321_kingdom$n,
                   final_ERR599042_kingdom$n,final_ERR599022_kingdom$n,final_ERR598961_kingdom$n,final_ERR594392_kingdom$n,
                   final_ERR594355_kingdom$n,final_ERR594310_kingdom$n,final_ERR594332_kingdom$n,final_ERR594354_kingdom$n,
                   final_ERR594318_kingdom$n,final_ERR594340_kingdom$n,final_ERR594333_kingdom$n,final_ERR598947_kingdom$n,
                   final_ERR594302_kingdom$n,final_ERR599021_kingdom$n,final_ERR599131_kingdom$n,final_ERR594298_kingdom$n,
                   final_ERR599071_kingdom$n,final_ERR599072_kingdom$n,final_ERR599085_kingdom$n,final_ERR599148_kingdom$n,
                   final_ERR599159_kingdom$n,final_ERR599086_kingdom$n,final_ERR599124_kingdom$n,final_ERR598960_kingdom$n,
                   final_ERR599000_kingdom$n,final_ERR594289_kingdom$n,final_ERR599154_kingdom$n,final_ERR599034_kingdom$n,
                   final_ERR599040_kingdom$n,final_ERR599018_kingdom$n,final_ERR599010_kingdom$n,final_ERR598990_kingdom$n,
                   final_ERR599110_kingdom$n,final_ERR599023_kingdom$n,final_ERR599101_kingdom$n,final_ERR599164_kingdom$n,
                   final_ERR599046_kingdom$n,final_ERR599146_kingdom$n,final_ERR598979_kingdom$n,final_ERR594303_kingdom$n,
                   final_ERR598972_kingdom$n,final_ERR599025_kingdom$n,final_ERR599126_kingdom$n,final_ERR599077_kingdom$n)

dataplot_kingdom <- data.frame(sample_kingdom, condition_kingdom, value_kingdom)

# Plotting
taxo_kingdom <- ggplot(dataplot_kingdom, aes(fill=condition_kingdom, y=value_kingdom, x=sample_kingdom)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal_kgd2, name  = "Domains") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),         
        axis.text.x = element_text(vjust=0.6, angle=90),
        legend.position = "none")
taxo_kingdom

# Plotting (with subtitles)
ggplot(dataplot_kingdom, aes(fill=condition_kingdom, y=value_kingdom, x=sample_kingdom)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal_kgd, name  = "Domains") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),         
        axis.text.x = element_text(vjust=0.6, angle=90))


######################### PHYLUM ######################### 

# Assembling the plot dataset
sample_phylum <- c(rep("01 - DCM - T064 - 594324",10),  rep("02 - DCM - T064 - 594385",10),  rep("03 - DCM - T068 - 594415",10),  rep("04 - DCM - T065 - 594382",10),
                   rep("05 - SRF - T078 - 594411",10),  rep("06 - SRF - T065 - 594359",10),  rep("07 - SRF - T068 - 594391",10),  rep("08 - DCM - T065 - 594414",10),
                   rep("09 - SRF - T065 - 594320",10),  rep("10 - DCM - T065 - 594291",10),  rep("11 - SRF - T065 - 594361",10),  rep("12 - SRF - T064 - 599150",10),
                   rep("13 - DCM - T098 - 599079",10),  rep("14 - SRF - T068 - 599129",10),  rep("15 - DCM - T068 - 599056",10),  rep("16 - SRF - T068 - 599171",10),
                   rep("17 - SRF - T064 - 598970",10),  rep("18 - DCM - T068 - 599103",10),  rep("19 - DCM - T068 - 599017",10),  rep("20 - DCM - T068 - 594348",10),
                   rep("21 - SRF - T098 - 599093",10),  rep("22 - SRF - T064 - 599088",10),  rep("23 - DCM - T112 - 598957",10),  rep("24 - SRF - T068 - 594297",10),
                   rep("25 - SRF - T078 - 599006",10),  rep("26 - DCM - T068 - 594294",10),  rep("27 - SRF - T098 - 599120",10),  rep("28 - SRF - T076 - 594286",10),
                   rep("29 - SRF - T112 - 598954",10),  rep("30 - SRF - T068 - 599174",10),  rep("31 - DCM - T078 - 594336",10),  rep("32 - DCM - T076 - 594321",10),
                   rep("33 - DCM - T068 - 599042",10),  rep("34 - SRF - T078 - 599022",10),  rep("35 - DCM - T111 - 598961",10),  rep("36 - SRF - T064 - 594392",10),
                   rep("37 - DCM - T076 - 594355",10),  rep("38 - SRF - T076 - 594310",10),  rep("39 - SRF - T078 - 594332",10),  rep("40 - SRF - T076 - 594354",10),
                   rep("41 - SRF - T068 - 594318",10),  rep("42 - SRF - T078 - 594340",10),  rep("43 - MES - T076 - 594333",10),  rep("44 - MES - T068 - 598947",10),
                   rep("45 - MES - T068 - 594302",10),  rep("46 - MES - T064 - 599021",10),  rep("47 - MES - T068 - 599131",10),  rep("48 - DCM - T076 - 594298",10),
                   rep("49 - MES - T098 - 599071",10),  rep("50 - MES - T112 - 599072",10),  rep("51 - MES - T098 - 599085",10),  rep("52 - DCM - T076 - 599148",10),
                   rep("53 - MES - T078 - 599159",10),  rep("54 - MES - T111 - 599086",10),  rep("55 - MES - T078 - 599124",10),  rep("56 - MES - T065 - 598960",10),
                   rep("57 - MES - T076 - 599000",10),  rep("58 - MES - T078 - 594289",10),  rep("59 - MES - T076 - 599154",10),  rep("60 - MES - T065 - 599034",10),
                   rep("61 - DCM - T076 - 599040",10),  rep("62 - DCM - T065 - 599018",10),  rep("63 - SRF - T076 - 599010",10),  rep("64 - DCM - T065 - 598990",10),
                   rep("65 - DCM - T065 - 599110",10),  rep("66 - DCM - T064 - 599023",10),  rep("67 - DCM - T078 - 599101",10),  rep("68 - MES - T064 - 599164",10),
                   rep("69 - DCM - T078 - 599046",10),  rep("70 - SRF - T065 - 599146",10),  rep("71 - SRF - T065 - 598979",10),  rep("72 - DCM - T078 - 594303",10),
                   rep("73 - DCM - T064 - 598972",10),  rep("74 - DCM - T064 - 599025",10),  rep("75 - SRF - T076 - 599126",10),  rep("76 - SRF - T111 - 599077",10))

condition_phylum <- c(cdt_ERR594324_phylum,cdt_ERR594385_phylum,cdt_ERR594415_phylum,cdt_ERR594382_phylum,
                      cdt_ERR594411_phylum,cdt_ERR594359_phylum,cdt_ERR594391_phylum,cdt_ERR594414_phylum,
                      cdt_ERR594320_phylum,cdt_ERR594291_phylum,cdt_ERR594361_phylum,cdt_ERR599150_phylum,
                      cdt_ERR599079_phylum,cdt_ERR599129_phylum,cdt_ERR599056_phylum,cdt_ERR599171_phylum,
                      cdt_ERR598970_phylum,cdt_ERR599103_phylum,cdt_ERR599017_phylum,cdt_ERR594348_phylum,
                      cdt_ERR599093_phylum,cdt_ERR599088_phylum,cdt_ERR598957_phylum,cdt_ERR594297_phylum,
                      cdt_ERR599006_phylum,cdt_ERR594294_phylum,cdt_ERR599120_phylum,cdt_ERR594286_phylum,
                      cdt_ERR598954_phylum,cdt_ERR599174_phylum,cdt_ERR594336_phylum,cdt_ERR594321_phylum,
                      cdt_ERR599042_phylum,cdt_ERR599022_phylum,cdt_ERR598961_phylum,cdt_ERR594392_phylum,
                      cdt_ERR594355_phylum,cdt_ERR594310_phylum,cdt_ERR594332_phylum,cdt_ERR594354_phylum,
                      cdt_ERR594318_phylum,cdt_ERR594340_phylum,cdt_ERR594333_phylum,cdt_ERR598947_phylum,
                      cdt_ERR594302_phylum,cdt_ERR599021_phylum,cdt_ERR599131_phylum,cdt_ERR594298_phylum,
                      cdt_ERR599071_phylum,cdt_ERR599072_phylum,cdt_ERR599085_phylum,cdt_ERR599148_phylum,
                      cdt_ERR599159_phylum,cdt_ERR599086_phylum,cdt_ERR599124_phylum,cdt_ERR598960_phylum,
                      cdt_ERR599000_phylum,cdt_ERR594289_phylum,cdt_ERR599154_phylum,cdt_ERR599034_phylum,
                      cdt_ERR599040_phylum,cdt_ERR599018_phylum,cdt_ERR599010_phylum,cdt_ERR598990_phylum,
                      cdt_ERR599110_phylum,cdt_ERR599023_phylum,cdt_ERR599101_phylum,cdt_ERR599164_phylum,
                      cdt_ERR599046_phylum,cdt_ERR599146_phylum,cdt_ERR598979_phylum,cdt_ERR594303_phylum,
                      cdt_ERR598972_phylum,cdt_ERR599025_phylum,cdt_ERR599126_phylum,cdt_ERR599077_phylum)

value_phylum <- c(final_ERR594324_phylum$n,final_ERR594385_phylum$n,final_ERR594415_phylum$n,final_ERR594382_phylum$n,
                  final_ERR594411_phylum$n,final_ERR594359_phylum$n,final_ERR594391_phylum$n,final_ERR594414_phylum$n,
                  final_ERR594320_phylum$n,final_ERR594291_phylum$n,final_ERR594361_phylum$n,final_ERR599150_phylum$n,
                  final_ERR599079_phylum$n,final_ERR599129_phylum$n,final_ERR599056_phylum$n,final_ERR599171_phylum$n,
                  final_ERR598970_phylum$n,final_ERR599103_phylum$n,final_ERR599017_phylum$n,final_ERR594348_phylum$n,
                  final_ERR599093_phylum$n,final_ERR599088_phylum$n,final_ERR598957_phylum$n,final_ERR594297_phylum$n,
                  final_ERR599006_phylum$n,final_ERR594294_phylum$n,final_ERR599120_phylum$n,final_ERR594286_phylum$n,
                  final_ERR598954_phylum$n,final_ERR599174_phylum$n,final_ERR594336_phylum$n,final_ERR594321_phylum$n,
                  final_ERR599042_phylum$n,final_ERR599022_phylum$n,final_ERR598961_phylum$n,final_ERR594392_phylum$n,
                  final_ERR594355_phylum$n,final_ERR594310_phylum$n,final_ERR594332_phylum$n,final_ERR594354_phylum$n,
                  final_ERR594318_phylum$n,final_ERR594340_phylum$n,final_ERR594333_phylum$n,final_ERR598947_phylum$n,
                  final_ERR594302_phylum$n,final_ERR599021_phylum$n,final_ERR599131_phylum$n,final_ERR594298_phylum$n,
                  final_ERR599071_phylum$n,final_ERR599072_phylum$n,final_ERR599085_phylum$n,final_ERR599148_phylum$n,
                  final_ERR599159_phylum$n,final_ERR599086_phylum$n,final_ERR599124_phylum$n,final_ERR598960_phylum$n,
                  final_ERR599000_phylum$n,final_ERR594289_phylum$n,final_ERR599154_phylum$n,final_ERR599034_phylum$n,
                  final_ERR599040_phylum$n,final_ERR599018_phylum$n,final_ERR599010_phylum$n,final_ERR598990_phylum$n,
                  final_ERR599110_phylum$n,final_ERR599023_phylum$n,final_ERR599101_phylum$n,final_ERR599164_phylum$n,
                  final_ERR599046_phylum$n,final_ERR599146_phylum$n,final_ERR598979_phylum$n,final_ERR594303_phylum$n,
                  final_ERR598972_phylum$n,final_ERR599025_phylum$n,final_ERR599126_phylum$n,final_ERR599077_phylum$n)

dataplot_phylum <- data.frame(sample_phylum, condition_phylum, value_phylum)


# Plotting
taxo_phylum <- ggplot(dataplot_phylum, aes(fill=condition_phylum, y=value_phylum, x=sample_phylum)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal, name  = "Phyla") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),         
        axis.text.x = element_text(vjust=0.6, angle=90),
        legend.position = "none")
taxo_phylum


######################### CLASS ######################### 

# Assembling the plot dataset
sample_class <- c(rep("01 - DCM - T064 - 594324",10),  rep("02 - DCM - T064 - 594385",10),  rep("03 - DCM - T068 - 594415",10),  rep("04 - DCM - T065 - 594382",10),
                  rep("05 - SRF - T078 - 594411",10),  rep("06 - SRF - T065 - 594359",10),  rep("07 - SRF - T068 - 594391",10),  rep("08 - DCM - T065 - 594414",10),
                  rep("09 - SRF - T065 - 594320",10),  rep("10 - DCM - T065 - 594291",10),  rep("11 - SRF - T065 - 594361",10),  rep("12 - SRF - T064 - 599150",10),
                  rep("13 - DCM - T098 - 599079",10),  rep("14 - SRF - T068 - 599129",10),  rep("15 - DCM - T068 - 599056",10),  rep("16 - SRF - T068 - 599171",10),
                  rep("17 - SRF - T064 - 598970",10),  rep("18 - DCM - T068 - 599103",10),  rep("19 - DCM - T068 - 599017",10),  rep("20 - DCM - T068 - 594348",10),
                  rep("21 - SRF - T098 - 599093",10),  rep("22 - SRF - T064 - 599088",10),  rep("23 - DCM - T112 - 598957",10),  rep("24 - SRF - T068 - 594297",10),
                  rep("25 - SRF - T078 - 599006",10),  rep("26 - DCM - T068 - 594294",10),  rep("27 - SRF - T098 - 599120",10),  rep("28 - SRF - T076 - 594286",10),
                  rep("29 - SRF - T112 - 598954",10),  rep("30 - SRF - T068 - 599174",10),  rep("31 - DCM - T078 - 594336",10),  rep("32 - DCM - T076 - 594321",10),
                  rep("33 - DCM - T068 - 599042",10),  rep("34 - SRF - T078 - 599022",10),  rep("35 - DCM - T111 - 598961",10),  rep("36 - SRF - T064 - 594392",10),
                  rep("37 - DCM - T076 - 594355",10),  rep("38 - SRF - T076 - 594310",10),  rep("39 - SRF - T078 - 594332",10),  rep("40 - SRF - T076 - 594354",10),
                  rep("41 - SRF - T068 - 594318",10),  rep("42 - SRF - T078 - 594340",10),  rep("43 - MES - T076 - 594333",10),  rep("44 - MES - T068 - 598947",10),
                  rep("45 - MES - T068 - 594302",10),  rep("46 - MES - T064 - 599021",10),  rep("47 - MES - T068 - 599131",10),  rep("48 - DCM - T076 - 594298",10),
                  rep("49 - MES - T098 - 599071",10),  rep("50 - MES - T112 - 599072",10),  rep("51 - MES - T098 - 599085",10),  rep("52 - DCM - T076 - 599148",10),
                  rep("53 - MES - T078 - 599159",10),  rep("54 - MES - T111 - 599086",10),  rep("55 - MES - T078 - 599124",10),  rep("56 - MES - T065 - 598960",10),
                  rep("57 - MES - T076 - 599000",10),  rep("58 - MES - T078 - 594289",10),  rep("59 - MES - T076 - 599154",10),  rep("60 - MES - T065 - 599034",10),
                  rep("61 - DCM - T076 - 599040",10),  rep("62 - DCM - T065 - 599018",10),  rep("63 - SRF - T076 - 599010",10),  rep("64 - DCM - T065 - 598990",10),
                  rep("65 - DCM - T065 - 599110",10),  rep("66 - DCM - T064 - 599023",10),  rep("67 - DCM - T078 - 599101",10),  rep("68 - MES - T064 - 599164",10),
                  rep("69 - DCM - T078 - 599046",10),  rep("70 - SRF - T065 - 599146",10),  rep("71 - SRF - T065 - 598979",10),  rep("72 - DCM - T078 - 594303",10),
                  rep("73 - DCM - T064 - 598972",10),  rep("74 - DCM - T064 - 599025",10),  rep("75 - SRF - T076 - 599126",10),  rep("76 - SRF - T111 - 599077",10))

condition_class <- c(cdt_ERR594324_class,cdt_ERR594385_class,cdt_ERR594415_class,cdt_ERR594382_class,
                     cdt_ERR594411_class,cdt_ERR594359_class,cdt_ERR594391_class,cdt_ERR594414_class,
                     cdt_ERR594320_class,cdt_ERR594291_class,cdt_ERR594361_class,cdt_ERR599150_class,
                     cdt_ERR599079_class,cdt_ERR599129_class,cdt_ERR599056_class,cdt_ERR599171_class,
                     cdt_ERR598970_class,cdt_ERR599103_class,cdt_ERR599017_class,cdt_ERR594348_class,
                     cdt_ERR599093_class,cdt_ERR599088_class,cdt_ERR598957_class,cdt_ERR594297_class,
                     cdt_ERR599006_class,cdt_ERR594294_class,cdt_ERR599120_class,cdt_ERR594286_class,
                     cdt_ERR598954_class,cdt_ERR599174_class,cdt_ERR594336_class,cdt_ERR594321_class,
                     cdt_ERR599042_class,cdt_ERR599022_class,cdt_ERR598961_class,cdt_ERR594392_class,
                     cdt_ERR594355_class,cdt_ERR594310_class,cdt_ERR594332_class,cdt_ERR594354_class,
                     cdt_ERR594318_class,cdt_ERR594340_class,cdt_ERR594333_class,cdt_ERR598947_class,
                     cdt_ERR594302_class,cdt_ERR599021_class,cdt_ERR599131_class,cdt_ERR594298_class,
                     cdt_ERR599071_class,cdt_ERR599072_class,cdt_ERR599085_class,cdt_ERR599148_class,
                     cdt_ERR599159_class,cdt_ERR599086_class,cdt_ERR599124_class,cdt_ERR598960_class,
                     cdt_ERR599000_class,cdt_ERR594289_class,cdt_ERR599154_class,cdt_ERR599034_class,
                     cdt_ERR599040_class,cdt_ERR599018_class,cdt_ERR599010_class,cdt_ERR598990_class,
                     cdt_ERR599110_class,cdt_ERR599023_class,cdt_ERR599101_class,cdt_ERR599164_class,
                     cdt_ERR599046_class,cdt_ERR599146_class,cdt_ERR598979_class,cdt_ERR594303_class,
                     cdt_ERR598972_class,cdt_ERR599025_class,cdt_ERR599126_class,cdt_ERR599077_class)

value_class <- c(final_ERR594324_class$n,final_ERR594385_class$n,final_ERR594415_class$n,final_ERR594382_class$n,
                 final_ERR594411_class$n,final_ERR594359_class$n,final_ERR594391_class$n,final_ERR594414_class$n,
                 final_ERR594320_class$n,final_ERR594291_class$n,final_ERR594361_class$n,final_ERR599150_class$n,
                 final_ERR599079_class$n,final_ERR599129_class$n,final_ERR599056_class$n,final_ERR599171_class$n,
                 final_ERR598970_class$n,final_ERR599103_class$n,final_ERR599017_class$n,final_ERR594348_class$n,
                 final_ERR599093_class$n,final_ERR599088_class$n,final_ERR598957_class$n,final_ERR594297_class$n,
                 final_ERR599006_class$n,final_ERR594294_class$n,final_ERR599120_class$n,final_ERR594286_class$n,
                 final_ERR598954_class$n,final_ERR599174_class$n,final_ERR594336_class$n,final_ERR594321_class$n,
                 final_ERR599042_class$n,final_ERR599022_class$n,final_ERR598961_class$n,final_ERR594392_class$n,
                 final_ERR594355_class$n,final_ERR594310_class$n,final_ERR594332_class$n,final_ERR594354_class$n,
                 final_ERR594318_class$n,final_ERR594340_class$n,final_ERR594333_class$n,final_ERR598947_class$n,
                 final_ERR594302_class$n,final_ERR599021_class$n,final_ERR599131_class$n,final_ERR594298_class$n,
                 final_ERR599071_class$n,final_ERR599072_class$n,final_ERR599085_class$n,final_ERR599148_class$n,
                 final_ERR599159_class$n,final_ERR599086_class$n,final_ERR599124_class$n,final_ERR598960_class$n,
                 final_ERR599000_class$n,final_ERR594289_class$n,final_ERR599154_class$n,final_ERR599034_class$n,
                 final_ERR599040_class$n,final_ERR599018_class$n,final_ERR599010_class$n,final_ERR598990_class$n,
                 final_ERR599110_class$n,final_ERR599023_class$n,final_ERR599101_class$n,final_ERR599164_class$n,
                 final_ERR599046_class$n,final_ERR599146_class$n,final_ERR598979_class$n,final_ERR594303_class$n,
                 final_ERR598972_class$n,final_ERR599025_class$n,final_ERR599126_class$n,final_ERR599077_class$n)

dataplot_class <- data.frame(sample_class, condition_class, value_class)


# Plotting
taxo_class <- ggplot(dataplot_class, aes(fill=condition_class, y=value_class, x=sample_class)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal, name  = "Classes") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),         
        axis.text.x = element_text(vjust=0.6, angle=90),
        legend.position = "none")
taxo_class


######################### ORDER ######################### 

# Assembling the plot dataset
sample_order <- c(rep("01 - DCM - T064 - 594324",10),  rep("02 - DCM - T064 - 594385",10),  rep("03 - DCM - T068 - 594415",10),  rep("04 - DCM - T065 - 594382",10),
                  rep("05 - SRF - T078 - 594411",10),  rep("06 - SRF - T065 - 594359",10),  rep("07 - SRF - T068 - 594391",10),  rep("08 - DCM - T065 - 594414",10),
                  rep("09 - SRF - T065 - 594320",10),  rep("10 - DCM - T065 - 594291",10),  rep("11 - SRF - T065 - 594361",10),  rep("12 - SRF - T064 - 599150",10),
                  rep("13 - DCM - T098 - 599079",10),  rep("14 - SRF - T068 - 599129",10),  rep("15 - DCM - T068 - 599056",10),  rep("16 - SRF - T068 - 599171",10),
                  rep("17 - SRF - T064 - 598970",10),  rep("18 - DCM - T068 - 599103",10),  rep("19 - DCM - T068 - 599017",10),  rep("20 - DCM - T068 - 594348",10),
                  rep("21 - SRF - T098 - 599093",10),  rep("22 - SRF - T064 - 599088",10),  rep("23 - DCM - T112 - 598957",10),  rep("24 - SRF - T068 - 594297",10),
                  rep("25 - SRF - T078 - 599006",10),  rep("26 - DCM - T068 - 594294",10),  rep("27 - SRF - T098 - 599120",10),  rep("28 - SRF - T076 - 594286",10),
                  rep("29 - SRF - T112 - 598954",10),  rep("30 - SRF - T068 - 599174",10),  rep("31 - DCM - T078 - 594336",10),  rep("32 - DCM - T076 - 594321",10),
                  rep("33 - DCM - T068 - 599042",10),  rep("34 - SRF - T078 - 599022",10),  rep("35 - DCM - T111 - 598961",10),  rep("36 - SRF - T064 - 594392",10),
                  rep("37 - DCM - T076 - 594355",10),  rep("38 - SRF - T076 - 594310",10),  rep("39 - SRF - T078 - 594332",10),  rep("40 - SRF - T076 - 594354",10),
                  rep("41 - SRF - T068 - 594318",10),  rep("42 - SRF - T078 - 594340",10),  rep("43 - MES - T076 - 594333",10),  rep("44 - MES - T068 - 598947",10),
                  rep("45 - MES - T068 - 594302",10),  rep("46 - MES - T064 - 599021",10),  rep("47 - MES - T068 - 599131",10),  rep("48 - DCM - T076 - 594298",10),
                  rep("49 - MES - T098 - 599071",10),  rep("50 - MES - T112 - 599072",10),  rep("51 - MES - T098 - 599085",10),  rep("52 - DCM - T076 - 599148",10),
                  rep("53 - MES - T078 - 599159",10),  rep("54 - MES - T111 - 599086",10),  rep("55 - MES - T078 - 599124",10),  rep("56 - MES - T065 - 598960",10),
                  rep("57 - MES - T076 - 599000",10),  rep("58 - MES - T078 - 594289",10),  rep("59 - MES - T076 - 599154",10),  rep("60 - MES - T065 - 599034",10),
                  rep("61 - DCM - T076 - 599040",10),  rep("62 - DCM - T065 - 599018",10),  rep("63 - SRF - T076 - 599010",10),  rep("64 - DCM - T065 - 598990",10),
                  rep("65 - DCM - T065 - 599110",10),  rep("66 - DCM - T064 - 599023",10),  rep("67 - DCM - T078 - 599101",10),  rep("68 - MES - T064 - 599164",10),
                  rep("69 - DCM - T078 - 599046",10),  rep("70 - SRF - T065 - 599146",10),  rep("71 - SRF - T065 - 598979",10),  rep("72 - DCM - T078 - 594303",10),
                  rep("73 - DCM - T064 - 598972",10),  rep("74 - DCM - T064 - 599025",10),  rep("75 - SRF - T076 - 599126",10),  rep("76 - SRF - T111 - 599077",10))

condition_order <- c(cdt_ERR594324_order,cdt_ERR594385_order,cdt_ERR594415_order,cdt_ERR594382_order,
                     cdt_ERR594411_order,cdt_ERR594359_order,cdt_ERR594391_order,cdt_ERR594414_order,
                     cdt_ERR594320_order,cdt_ERR594291_order,cdt_ERR594361_order,cdt_ERR599150_order,
                     cdt_ERR599079_order,cdt_ERR599129_order,cdt_ERR599056_order,cdt_ERR599171_order,
                     cdt_ERR598970_order,cdt_ERR599103_order,cdt_ERR599017_order,cdt_ERR594348_order,
                     cdt_ERR599093_order,cdt_ERR599088_order,cdt_ERR598957_order,cdt_ERR594297_order,
                     cdt_ERR599006_order,cdt_ERR594294_order,cdt_ERR599120_order,cdt_ERR594286_order,
                     cdt_ERR598954_order,cdt_ERR599174_order,cdt_ERR594336_order,cdt_ERR594321_order,
                     cdt_ERR599042_order,cdt_ERR599022_order,cdt_ERR598961_order,cdt_ERR594392_order,
                     cdt_ERR594355_order,cdt_ERR594310_order,cdt_ERR594332_order,cdt_ERR594354_order,
                     cdt_ERR594318_order,cdt_ERR594340_order,cdt_ERR594333_order,cdt_ERR598947_order,
                     cdt_ERR594302_order,cdt_ERR599021_order,cdt_ERR599131_order,cdt_ERR594298_order,
                     cdt_ERR599071_order,cdt_ERR599072_order,cdt_ERR599085_order,cdt_ERR599148_order,
                     cdt_ERR599159_order,cdt_ERR599086_order,cdt_ERR599124_order,cdt_ERR598960_order,
                     cdt_ERR599000_order,cdt_ERR594289_order,cdt_ERR599154_order,cdt_ERR599034_order,
                     cdt_ERR599040_order,cdt_ERR599018_order,cdt_ERR599010_order,cdt_ERR598990_order,
                     cdt_ERR599110_order,cdt_ERR599023_order,cdt_ERR599101_order,cdt_ERR599164_order,
                     cdt_ERR599046_order,cdt_ERR599146_order,cdt_ERR598979_order,cdt_ERR594303_order,
                     cdt_ERR598972_order,cdt_ERR599025_order,cdt_ERR599126_order,cdt_ERR599077_order)

value_order <- c(final_ERR594324_order$n,final_ERR594385_order$n,final_ERR594415_order$n,final_ERR594382_order$n,
                 final_ERR594411_order$n,final_ERR594359_order$n,final_ERR594391_order$n,final_ERR594414_order$n,
                 final_ERR594320_order$n,final_ERR594291_order$n,final_ERR594361_order$n,final_ERR599150_order$n,
                 final_ERR599079_order$n,final_ERR599129_order$n,final_ERR599056_order$n,final_ERR599171_order$n,
                 final_ERR598970_order$n,final_ERR599103_order$n,final_ERR599017_order$n,final_ERR594348_order$n,
                 final_ERR599093_order$n,final_ERR599088_order$n,final_ERR598957_order$n,final_ERR594297_order$n,
                 final_ERR599006_order$n,final_ERR594294_order$n,final_ERR599120_order$n,final_ERR594286_order$n,
                 final_ERR598954_order$n,final_ERR599174_order$n,final_ERR594336_order$n,final_ERR594321_order$n,
                 final_ERR599042_order$n,final_ERR599022_order$n,final_ERR598961_order$n,final_ERR594392_order$n,
                 final_ERR594355_order$n,final_ERR594310_order$n,final_ERR594332_order$n,final_ERR594354_order$n,
                 final_ERR594318_order$n,final_ERR594340_order$n,final_ERR594333_order$n,final_ERR598947_order$n,
                 final_ERR594302_order$n,final_ERR599021_order$n,final_ERR599131_order$n,final_ERR594298_order$n,
                 final_ERR599071_order$n,final_ERR599072_order$n,final_ERR599085_order$n,final_ERR599148_order$n,
                 final_ERR599159_order$n,final_ERR599086_order$n,final_ERR599124_order$n,final_ERR598960_order$n,
                 final_ERR599000_order$n,final_ERR594289_order$n,final_ERR599154_order$n,final_ERR599034_order$n,
                 final_ERR599040_order$n,final_ERR599018_order$n,final_ERR599010_order$n,final_ERR598990_order$n,
                 final_ERR599110_order$n,final_ERR599023_order$n,final_ERR599101_order$n,final_ERR599164_order$n,
                 final_ERR599046_order$n,final_ERR599146_order$n,final_ERR598979_order$n,final_ERR594303_order$n,
                 final_ERR598972_order$n,final_ERR599025_order$n,final_ERR599126_order$n,final_ERR599077_order$n)


dataplot_order <- data.frame(sample_order, condition_order, value_order)


# Plotting
taxo_order <- ggplot(dataplot_order, aes(fill=condition_order, y=value_order, x=sample_order)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal, name  = "Ordens") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),         
        axis.text.x = element_text(vjust=0.6, angle=90),
        legend.position = "none")
taxo_order


######################### FAMILY ######################### 

# Assembling the plot dataset
sample_family <- c(rep("01 - DCM - T064 - 594324",10),  rep("02 - DCM - T064 - 594385",10),  rep("03 - DCM - T068 - 594415",10),  rep("04 - DCM - T065 - 594382",10),
                   rep("05 - SRF - T078 - 594411",10),  rep("06 - SRF - T065 - 594359",10),  rep("07 - SRF - T068 - 594391",10),  rep("08 - DCM - T065 - 594414",10),
                   rep("09 - SRF - T065 - 594320",10),  rep("10 - DCM - T065 - 594291",10),  rep("11 - SRF - T065 - 594361",10),  rep("12 - SRF - T064 - 599150",10),
                   rep("13 - DCM - T098 - 599079",10),  rep("14 - SRF - T068 - 599129",10),  rep("15 - DCM - T068 - 599056",10),  rep("16 - SRF - T068 - 599171",10),
                   rep("17 - SRF - T064 - 598970",10),  rep("18 - DCM - T068 - 599103",10),  rep("19 - DCM - T068 - 599017",10),  rep("20 - DCM - T068 - 594348",10),
                   rep("21 - SRF - T098 - 599093",10),  rep("22 - SRF - T064 - 599088",10),  rep("23 - DCM - T112 - 598957",10),  rep("24 - SRF - T068 - 594297",10),
                   rep("25 - SRF - T078 - 599006",10),  rep("26 - DCM - T068 - 594294",10),  rep("27 - SRF - T098 - 599120",10),  rep("28 - SRF - T076 - 594286",10),
                   rep("29 - SRF - T112 - 598954",10),  rep("30 - SRF - T068 - 599174",10),  rep("31 - DCM - T078 - 594336",10),  rep("32 - DCM - T076 - 594321",10),
                   rep("33 - DCM - T068 - 599042",10),  rep("34 - SRF - T078 - 599022",10),  rep("35 - DCM - T111 - 598961",10),  rep("36 - SRF - T064 - 594392",10),
                   rep("37 - DCM - T076 - 594355",10),  rep("38 - SRF - T076 - 594310",10),  rep("39 - SRF - T078 - 594332",10),  rep("40 - SRF - T076 - 594354",10),
                   rep("41 - SRF - T068 - 594318",10),  rep("42 - SRF - T078 - 594340",10),  rep("43 - MES - T076 - 594333",10),  rep("44 - MES - T068 - 598947",10),
                   rep("45 - MES - T068 - 594302",10),  rep("46 - MES - T064 - 599021",10),  rep("47 - MES - T068 - 599131",10),  rep("48 - DCM - T076 - 594298",10),
                   rep("49 - MES - T098 - 599071",10),  rep("50 - MES - T112 - 599072",10),  rep("51 - MES - T098 - 599085",10),  rep("52 - DCM - T076 - 599148",10),
                   rep("53 - MES - T078 - 599159",10),  rep("54 - MES - T111 - 599086",10),  rep("55 - MES - T078 - 599124",10),  rep("56 - MES - T065 - 598960",10),
                   rep("57 - MES - T076 - 599000",10),  rep("58 - MES - T078 - 594289",10),  rep("59 - MES - T076 - 599154",10),  rep("60 - MES - T065 - 599034",10),
                   rep("61 - DCM - T076 - 599040",10),  rep("62 - DCM - T065 - 599018",10),  rep("63 - SRF - T076 - 599010",10),  rep("64 - DCM - T065 - 598990",10),
                   rep("65 - DCM - T065 - 599110",10),  rep("66 - DCM - T064 - 599023",10),  rep("67 - DCM - T078 - 599101",10),  rep("68 - MES - T064 - 599164",10),
                   rep("69 - DCM - T078 - 599046",10),  rep("70 - SRF - T065 - 599146",10),  rep("71 - SRF - T065 - 598979",10),  rep("72 - DCM - T078 - 594303",10),
                   rep("73 - DCM - T064 - 598972",10),  rep("74 - DCM - T064 - 599025",10),  rep("75 - SRF - T076 - 599126",10),  rep("76 - SRF - T111 - 599077",10))

condition_family <- c(cdt_ERR594324_family,cdt_ERR594385_family,cdt_ERR594415_family,cdt_ERR594382_family,
                      cdt_ERR594411_family,cdt_ERR594359_family,cdt_ERR594391_family,cdt_ERR594414_family,
                      cdt_ERR594320_family,cdt_ERR594291_family,cdt_ERR594361_family,cdt_ERR599150_family,
                      cdt_ERR599079_family,cdt_ERR599129_family,cdt_ERR599056_family,cdt_ERR599171_family,
                      cdt_ERR598970_family,cdt_ERR599103_family,cdt_ERR599017_family,cdt_ERR594348_family,
                      cdt_ERR599093_family,cdt_ERR599088_family,cdt_ERR598957_family,cdt_ERR594297_family,
                      cdt_ERR599006_family,cdt_ERR594294_family,cdt_ERR599120_family,cdt_ERR594286_family,
                      cdt_ERR598954_family,cdt_ERR599174_family,cdt_ERR594336_family,cdt_ERR594321_family,
                      cdt_ERR599042_family,cdt_ERR599022_family,cdt_ERR598961_family,cdt_ERR594392_family,
                      cdt_ERR594355_family,cdt_ERR594310_family,cdt_ERR594332_family,cdt_ERR594354_family,
                      cdt_ERR594318_family,cdt_ERR594340_family,cdt_ERR594333_family,cdt_ERR598947_family,
                      cdt_ERR594302_family,cdt_ERR599021_family,cdt_ERR599131_family,cdt_ERR594298_family,
                      cdt_ERR599071_family,cdt_ERR599072_family,cdt_ERR599085_family,cdt_ERR599148_family,
                      cdt_ERR599159_family,cdt_ERR599086_family,cdt_ERR599124_family,cdt_ERR598960_family,
                      cdt_ERR599000_family,cdt_ERR594289_family,cdt_ERR599154_family,cdt_ERR599034_family,
                      cdt_ERR599040_family,cdt_ERR599018_family,cdt_ERR599010_family,cdt_ERR598990_family,
                      cdt_ERR599110_family,cdt_ERR599023_family,cdt_ERR599101_family,cdt_ERR599164_family,
                      cdt_ERR599046_family,cdt_ERR599146_family,cdt_ERR598979_family,cdt_ERR594303_family,
                      cdt_ERR598972_family,cdt_ERR599025_family,cdt_ERR599126_family,cdt_ERR599077_family)

value_family <- c(final_ERR594324_family$n,final_ERR594385_family$n,final_ERR594415_family$n,final_ERR594382_family$n,
                  final_ERR594411_family$n,final_ERR594359_family$n,final_ERR594391_family$n,final_ERR594414_family$n,
                  final_ERR594320_family$n,final_ERR594291_family$n,final_ERR594361_family$n,final_ERR599150_family$n,
                  final_ERR599079_family$n,final_ERR599129_family$n,final_ERR599056_family$n,final_ERR599171_family$n,
                  final_ERR598970_family$n,final_ERR599103_family$n,final_ERR599017_family$n,final_ERR594348_family$n,
                  final_ERR599093_family$n,final_ERR599088_family$n,final_ERR598957_family$n,final_ERR594297_family$n,
                  final_ERR599006_family$n,final_ERR594294_family$n,final_ERR599120_family$n,final_ERR594286_family$n,
                  final_ERR598954_family$n,final_ERR599174_family$n,final_ERR594336_family$n,final_ERR594321_family$n,
                  final_ERR599042_family$n,final_ERR599022_family$n,final_ERR598961_family$n,final_ERR594392_family$n,
                  final_ERR594355_family$n,final_ERR594310_family$n,final_ERR594332_family$n,final_ERR594354_family$n,
                  final_ERR594318_family$n,final_ERR594340_family$n,final_ERR594333_family$n,final_ERR598947_family$n,
                  final_ERR594302_family$n,final_ERR599021_family$n,final_ERR599131_family$n,final_ERR594298_family$n,
                  final_ERR599071_family$n,final_ERR599072_family$n,final_ERR599085_family$n,final_ERR599148_family$n,
                  final_ERR599159_family$n,final_ERR599086_family$n,final_ERR599124_family$n,final_ERR598960_family$n,
                  final_ERR599000_family$n,final_ERR594289_family$n,final_ERR599154_family$n,final_ERR599034_family$n,
                  final_ERR599040_family$n,final_ERR599018_family$n,final_ERR599010_family$n,final_ERR598990_family$n,
                  final_ERR599110_family$n,final_ERR599023_family$n,final_ERR599101_family$n,final_ERR599164_family$n,
                  final_ERR599046_family$n,final_ERR599146_family$n,final_ERR598979_family$n,final_ERR594303_family$n,
                  final_ERR598972_family$n,final_ERR599025_family$n,final_ERR599126_family$n,final_ERR599077_family$n)


dataplot_family <- data.frame(sample_family, condition_family, value_family)

# Plotting
taxo_family <- ggplot(dataplot_family, aes(fill=condition_family, y=value_family, x=sample_family)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal, name  = "Famílias") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),         
        axis.text.x = element_text(vjust=0.6, angle=90),
        legend.position = "none")
taxo_family


######################### GENUS ######################### 

# Assembling the plot dataset
sample_genus <- c(rep("01 - DCM - T064 - 594324",10),  rep("02 - DCM - T064 - 594385",10),  rep("03 - DCM - T068 - 594415",10),  rep("04 - DCM - T065 - 594382",10),
                  rep("05 - SRF - T078 - 594411",10),  rep("06 - SRF - T065 - 594359",10),  rep("07 - SRF - T068 - 594391",10),  rep("08 - DCM - T065 - 594414",10),
                  rep("09 - SRF - T065 - 594320",10),  rep("10 - DCM - T065 - 594291",10),  rep("11 - SRF - T065 - 594361",10),  rep("12 - SRF - T064 - 599150",10),
                  rep("13 - DCM - T098 - 599079",10),  rep("14 - SRF - T068 - 599129",10),  rep("15 - DCM - T068 - 599056",10),  rep("16 - SRF - T068 - 599171",10),
                  rep("17 - SRF - T064 - 598970",10),  rep("18 - DCM - T068 - 599103",10),  rep("19 - DCM - T068 - 599017",10),  rep("20 - DCM - T068 - 594348",10),
                  rep("21 - SRF - T098 - 599093",10),  rep("22 - SRF - T064 - 599088",10),  rep("23 - DCM - T112 - 598957",10),  rep("24 - SRF - T068 - 594297",10),
                  rep("25 - SRF - T078 - 599006",10),  rep("26 - DCM - T068 - 594294",10),  rep("27 - SRF - T098 - 599120",10),  rep("28 - SRF - T076 - 594286",10),
                  rep("29 - SRF - T112 - 598954",10),  rep("30 - SRF - T068 - 599174",10),  rep("31 - DCM - T078 - 594336",10),  rep("32 - DCM - T076 - 594321",10),
                  rep("33 - DCM - T068 - 599042",10),  rep("34 - SRF - T078 - 599022",10),  rep("35 - DCM - T111 - 598961",10),  rep("36 - SRF - T064 - 594392",10),
                  rep("37 - DCM - T076 - 594355",10),  rep("38 - SRF - T076 - 594310",10),  rep("39 - SRF - T078 - 594332",10),  rep("40 - SRF - T076 - 594354",10),
                  rep("41 - SRF - T068 - 594318",10),  rep("42 - SRF - T078 - 594340",10),  rep("43 - MES - T076 - 594333",10),  rep("44 - MES - T068 - 598947",10),
                  rep("45 - MES - T068 - 594302",10),  rep("46 - MES - T064 - 599021",10),  rep("47 - MES - T068 - 599131",10),  rep("48 - DCM - T076 - 594298",10),
                  rep("49 - MES - T098 - 599071",10),  rep("50 - MES - T112 - 599072",10),  rep("51 - MES - T098 - 599085",10),  rep("52 - DCM - T076 - 599148",10),
                  rep("53 - MES - T078 - 599159",10),  rep("54 - MES - T111 - 599086",10),  rep("55 - MES - T078 - 599124",10),  rep("56 - MES - T065 - 598960",10),
                  rep("57 - MES - T076 - 599000",10),  rep("58 - MES - T078 - 594289",10),  rep("59 - MES - T076 - 599154",10),  rep("60 - MES - T065 - 599034",10),
                  rep("61 - DCM - T076 - 599040",10),  rep("62 - DCM - T065 - 599018",10),  rep("63 - SRF - T076 - 599010",10),  rep("64 - DCM - T065 - 598990",10),
                  rep("65 - DCM - T065 - 599110",10),  rep("66 - DCM - T064 - 599023",10),  rep("67 - DCM - T078 - 599101",10),  rep("68 - MES - T064 - 599164",10),
                  rep("69 - DCM - T078 - 599046",10),  rep("70 - SRF - T065 - 599146",10),  rep("71 - SRF - T065 - 598979",10),  rep("72 - DCM - T078 - 594303",10),
                  rep("73 - DCM - T064 - 598972",10),  rep("74 - DCM - T064 - 599025",10),  rep("75 - SRF - T076 - 599126",10),  rep("76 - SRF - T111 - 599077",10))

condition_genus <- c(cdt_ERR594324_genus,cdt_ERR594385_genus,cdt_ERR594415_genus,cdt_ERR594382_genus,
                     cdt_ERR594411_genus,cdt_ERR594359_genus,cdt_ERR594391_genus,cdt_ERR594414_genus,
                     cdt_ERR594320_genus,cdt_ERR594291_genus,cdt_ERR594361_genus,cdt_ERR599150_genus,
                     cdt_ERR599079_genus,cdt_ERR599129_genus,cdt_ERR599056_genus,cdt_ERR599171_genus,
                     cdt_ERR598970_genus,cdt_ERR599103_genus,cdt_ERR599017_genus,cdt_ERR594348_genus,
                     cdt_ERR599093_genus,cdt_ERR599088_genus,cdt_ERR598957_genus,cdt_ERR594297_genus,
                     cdt_ERR599006_genus,cdt_ERR594294_genus,cdt_ERR599120_genus,cdt_ERR594286_genus,
                     cdt_ERR598954_genus,cdt_ERR599174_genus,cdt_ERR594336_genus,cdt_ERR594321_genus,
                     cdt_ERR599042_genus,cdt_ERR599022_genus,cdt_ERR598961_genus,cdt_ERR594392_genus,
                     cdt_ERR594355_genus,cdt_ERR594310_genus,cdt_ERR594332_genus,cdt_ERR594354_genus,
                     cdt_ERR594318_genus,cdt_ERR594340_genus,cdt_ERR594333_genus,cdt_ERR598947_genus,
                     cdt_ERR594302_genus,cdt_ERR599021_genus,cdt_ERR599131_genus,cdt_ERR594298_genus,
                     cdt_ERR599071_genus,cdt_ERR599072_genus,cdt_ERR599085_genus,cdt_ERR599148_genus,
                     cdt_ERR599159_genus,cdt_ERR599086_genus,cdt_ERR599124_genus,cdt_ERR598960_genus,
                     cdt_ERR599000_genus,cdt_ERR594289_genus,cdt_ERR599154_genus,cdt_ERR599034_genus,
                     cdt_ERR599040_genus,cdt_ERR599018_genus,cdt_ERR599010_genus,cdt_ERR598990_genus,
                     cdt_ERR599110_genus,cdt_ERR599023_genus,cdt_ERR599101_genus,cdt_ERR599164_genus,
                     cdt_ERR599046_genus,cdt_ERR599146_genus,cdt_ERR598979_genus,cdt_ERR594303_genus,
                     cdt_ERR598972_genus,cdt_ERR599025_genus,cdt_ERR599126_genus,cdt_ERR599077_genus)

value_genus <- c(final_ERR594324_genus$n,final_ERR594385_genus$n,final_ERR594415_genus$n,final_ERR594382_genus$n,
                 final_ERR594411_genus$n,final_ERR594359_genus$n,final_ERR594391_genus$n,final_ERR594414_genus$n,
                 final_ERR594320_genus$n,final_ERR594291_genus$n,final_ERR594361_genus$n,final_ERR599150_genus$n,
                 final_ERR599079_genus$n,final_ERR599129_genus$n,final_ERR599056_genus$n,final_ERR599171_genus$n,
                 final_ERR598970_genus$n,final_ERR599103_genus$n,final_ERR599017_genus$n,final_ERR594348_genus$n,
                 final_ERR599093_genus$n,final_ERR599088_genus$n,final_ERR598957_genus$n,final_ERR594297_genus$n,
                 final_ERR599006_genus$n,final_ERR594294_genus$n,final_ERR599120_genus$n,final_ERR594286_genus$n,
                 final_ERR598954_genus$n,final_ERR599174_genus$n,final_ERR594336_genus$n,final_ERR594321_genus$n,
                 final_ERR599042_genus$n,final_ERR599022_genus$n,final_ERR598961_genus$n,final_ERR594392_genus$n,
                 final_ERR594355_genus$n,final_ERR594310_genus$n,final_ERR594332_genus$n,final_ERR594354_genus$n,
                 final_ERR594318_genus$n,final_ERR594340_genus$n,final_ERR594333_genus$n,final_ERR598947_genus$n,
                 final_ERR594302_genus$n,final_ERR599021_genus$n,final_ERR599131_genus$n,final_ERR594298_genus$n,
                 final_ERR599071_genus$n,final_ERR599072_genus$n,final_ERR599085_genus$n,final_ERR599148_genus$n,
                 final_ERR599159_genus$n,final_ERR599086_genus$n,final_ERR599124_genus$n,final_ERR598960_genus$n,
                 final_ERR599000_genus$n,final_ERR594289_genus$n,final_ERR599154_genus$n,final_ERR599034_genus$n,
                 final_ERR599040_genus$n,final_ERR599018_genus$n,final_ERR599010_genus$n,final_ERR598990_genus$n,
                 final_ERR599110_genus$n,final_ERR599023_genus$n,final_ERR599101_genus$n,final_ERR599164_genus$n,
                 final_ERR599046_genus$n,final_ERR599146_genus$n,final_ERR598979_genus$n,final_ERR594303_genus$n,
                 final_ERR598972_genus$n,final_ERR599025_genus$n,final_ERR599126_genus$n,final_ERR599077_genus$n)

dataplot_genus <- data.frame(sample_genus, condition_genus, value_genus)


# Plotting
taxo_genus <- ggplot(dataplot_genus, aes(fill=condition_genus, y=value_genus, x=sample_genus)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal3, name  = "Genera") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),         
        axis.text.x = element_text(vjust=0.6, angle=90),
        legend.position = "none")
taxo_genus


######################### SPECIES ######################### 

# Assembling the plot dataset
sample_species <- c(rep("01 - DCM - T064 - 594324",10),  rep("02 - DCM - T064 - 594385",10),  rep("03 - DCM - T068 - 594415",10),  rep("04 - DCM - T065 - 594382",10),
                    rep("05 - SRF - T078 - 594411",10),  rep("06 - SRF - T065 - 594359",10),  rep("07 - SRF - T068 - 594391",10),  rep("08 - DCM - T065 - 594414",10),
                    rep("09 - SRF - T065 - 594320",10),  rep("10 - DCM - T065 - 594291",10),  rep("11 - SRF - T065 - 594361",10),  rep("12 - SRF - T064 - 599150",10),
                    rep("13 - DCM - T098 - 599079",10),  rep("14 - SRF - T068 - 599129",10),  rep("15 - DCM - T068 - 599056",10),  rep("16 - SRF - T068 - 599171",10),
                    rep("17 - SRF - T064 - 598970",10),  rep("18 - DCM - T068 - 599103",10),  rep("19 - DCM - T068 - 599017",10),  rep("20 - DCM - T068 - 594348",10),
                    rep("21 - SRF - T098 - 599093",10),  rep("22 - SRF - T064 - 599088",10),  rep("23 - DCM - T112 - 598957",10),  rep("24 - SRF - T068 - 594297",10),
                    rep("25 - SRF - T078 - 599006",10),  rep("26 - DCM - T068 - 594294",10),  rep("27 - SRF - T098 - 599120",10),  rep("28 - SRF - T076 - 594286",10),
                    rep("29 - SRF - T112 - 598954",10),  rep("30 - SRF - T068 - 599174",10),  rep("31 - DCM - T078 - 594336",10),  rep("32 - DCM - T076 - 594321",10),
                    rep("33 - DCM - T068 - 599042",10),  rep("34 - SRF - T078 - 599022",10),  rep("35 - DCM - T111 - 598961",10),  rep("36 - SRF - T064 - 594392",10),
                    rep("37 - DCM - T076 - 594355",10),  rep("38 - SRF - T076 - 594310",10),  rep("39 - SRF - T078 - 594332",10),  rep("40 - SRF - T076 - 594354",10),
                    rep("41 - SRF - T068 - 594318",10),  rep("42 - SRF - T078 - 594340",10),  rep("43 - MES - T076 - 594333",10),  rep("44 - MES - T068 - 598947",10),
                    rep("45 - MES - T068 - 594302",10),  rep("46 - MES - T064 - 599021",10),  rep("47 - MES - T068 - 599131",10),  rep("48 - DCM - T076 - 594298",10),
                    rep("49 - MES - T098 - 599071",10),  rep("50 - MES - T112 - 599072",10),  rep("51 - MES - T098 - 599085",10),  rep("52 - DCM - T076 - 599148",10),
                    rep("53 - MES - T078 - 599159",10),  rep("54 - MES - T111 - 599086",10),  rep("55 - MES - T078 - 599124",10),  rep("56 - MES - T065 - 598960",10),
                    rep("57 - MES - T076 - 599000",10),  rep("58 - MES - T078 - 594289",10),  rep("59 - MES - T076 - 599154",10),  rep("60 - MES - T065 - 599034",10),
                    rep("61 - DCM - T076 - 599040",10),  rep("62 - DCM - T065 - 599018",10),  rep("63 - SRF - T076 - 599010",10),  rep("64 - DCM - T065 - 598990",10),
                    rep("65 - DCM - T065 - 599110",10),  rep("66 - DCM - T064 - 599023",10),  rep("67 - DCM - T078 - 599101",10),  rep("68 - MES - T064 - 599164",10),
                    rep("69 - DCM - T078 - 599046",10),  rep("70 - SRF - T065 - 599146",10),  rep("71 - SRF - T065 - 598979",10),  rep("72 - DCM - T078 - 594303",10),
                    rep("73 - DCM - T064 - 598972",10),  rep("74 - DCM - T064 - 599025",10),  rep("75 - SRF - T076 - 599126",10),  rep("76 - SRF - T111 - 599077",10))

condition_species <- c(cdt_ERR594324_species,cdt_ERR594385_species,cdt_ERR594415_species,cdt_ERR594382_species,
                       cdt_ERR594411_species,cdt_ERR594359_species,cdt_ERR594391_species,cdt_ERR594414_species,
                       cdt_ERR594320_species,cdt_ERR594291_species,cdt_ERR594361_species,cdt_ERR599150_species,
                       cdt_ERR599079_species,cdt_ERR599129_species,cdt_ERR599056_species,cdt_ERR599171_species,
                       cdt_ERR598970_species,cdt_ERR599103_species,cdt_ERR599017_species,cdt_ERR594348_species,
                       cdt_ERR599093_species,cdt_ERR599088_species,cdt_ERR598957_species,cdt_ERR594297_species,
                       cdt_ERR599006_species,cdt_ERR594294_species,cdt_ERR599120_species,cdt_ERR594286_species,
                       cdt_ERR598954_species,cdt_ERR599174_species,cdt_ERR594336_species,cdt_ERR594321_species,
                       cdt_ERR599042_species,cdt_ERR599022_species,cdt_ERR598961_species,cdt_ERR594392_species,
                       cdt_ERR594355_species,cdt_ERR594310_species,cdt_ERR594332_species,cdt_ERR594354_species,
                       cdt_ERR594318_species,cdt_ERR594340_species,cdt_ERR594333_species,cdt_ERR598947_species,
                       cdt_ERR594302_species,cdt_ERR599021_species,cdt_ERR599131_species,cdt_ERR594298_species,
                       cdt_ERR599071_species,cdt_ERR599072_species,cdt_ERR599085_species,cdt_ERR599148_species,
                       cdt_ERR599159_species,cdt_ERR599086_species,cdt_ERR599124_species,cdt_ERR598960_species,
                       cdt_ERR599000_species,cdt_ERR594289_species,cdt_ERR599154_species,cdt_ERR599034_species,
                       cdt_ERR599040_species,cdt_ERR599018_species,cdt_ERR599010_species,cdt_ERR598990_species,
                       cdt_ERR599110_species,cdt_ERR599023_species,cdt_ERR599101_species,cdt_ERR599164_species,
                       cdt_ERR599046_species,cdt_ERR599146_species,cdt_ERR598979_species,cdt_ERR594303_species,
                       cdt_ERR598972_species,cdt_ERR599025_species,cdt_ERR599126_species,cdt_ERR599077_species)

value_species <- c(final_ERR594324_species$n,final_ERR594385_species$n,final_ERR594415_species$n,final_ERR594382_species$n,
                   final_ERR594411_species$n,final_ERR594359_species$n,final_ERR594391_species$n,final_ERR594414_species$n,
                   final_ERR594320_species$n,final_ERR594291_species$n,final_ERR594361_species$n,final_ERR599150_species$n,
                   final_ERR599079_species$n,final_ERR599129_species$n,final_ERR599056_species$n,final_ERR599171_species$n,
                   final_ERR598970_species$n,final_ERR599103_species$n,final_ERR599017_species$n,final_ERR594348_species$n,
                   final_ERR599093_species$n,final_ERR599088_species$n,final_ERR598957_species$n,final_ERR594297_species$n,
                   final_ERR599006_species$n,final_ERR594294_species$n,final_ERR599120_species$n,final_ERR594286_species$n,
                   final_ERR598954_species$n,final_ERR599174_species$n,final_ERR594336_species$n,final_ERR594321_species$n,
                   final_ERR599042_species$n,final_ERR599022_species$n,final_ERR598961_species$n,final_ERR594392_species$n,
                   final_ERR594355_species$n,final_ERR594310_species$n,final_ERR594332_species$n,final_ERR594354_species$n,
                   final_ERR594318_species$n,final_ERR594340_species$n,final_ERR594333_species$n,final_ERR598947_species$n,
                   final_ERR594302_species$n,final_ERR599021_species$n,final_ERR599131_species$n,final_ERR594298_species$n,
                   final_ERR599071_species$n,final_ERR599072_species$n,final_ERR599085_species$n,final_ERR599148_species$n,
                   final_ERR599159_species$n,final_ERR599086_species$n,final_ERR599124_species$n,final_ERR598960_species$n,
                   final_ERR599000_species$n,final_ERR594289_species$n,final_ERR599154_species$n,final_ERR599034_species$n,
                   final_ERR599040_species$n,final_ERR599018_species$n,final_ERR599010_species$n,final_ERR598990_species$n,
                   final_ERR599110_species$n,final_ERR599023_species$n,final_ERR599101_species$n,final_ERR599164_species$n,
                   final_ERR599046_species$n,final_ERR599146_species$n,final_ERR598979_species$n,final_ERR594303_species$n,
                   final_ERR598972_species$n,final_ERR599025_species$n,final_ERR599126_species$n,final_ERR599077_species$n)

dataplot_species <- data.frame(sample_species, condition_species, value_species)


# Plotting
taxo_species <- ggplot(dataplot_species, aes(fill=condition_species, y=value_species, x=sample_species)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal3, name  = "Species") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(vjust=0.6, angle=90),
        legend.position = "none")
taxo_species

# Plotting (with subtitles)
ggplot(dataplot_species, aes(fill=condition_species, y=value_species, x=sample_species)) + 
  geom_bar(position="fill", stat="identity") +
  scale_fill_manual(values = mat_pal3, name  = "Species") +
  labs(title = '',
       y = 'Frequency',
       x = 'Samples') +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(vjust=0.6, angle=90))

###################################################################### EXPORTING FILES ######################################################################


### exporting files (PDF)
for (taxon in taxons){
  data_name <- get(paste0("taxo_",taxon))
  vari_name <- paste0("~/meta_taraocean/data/results/output/taxonomic/plots/pdf/taxo_",taxon,".pdf")
  ggsave(filename = vari_name, data_name,
         width = 15, height = 10, dpi = 500, units = "cm", device='pdf')
  rm(data_name, vari_name, taxon)
}

### exporting files (PNG)
for (taxon in taxons){
  data_name <- get(paste0("taxo_",taxon))
  vari_name <- paste0("~/meta_taraocean/data/results/output/taxonomic/plots/png/taxo_",taxon,".png")
  ggsave(filename = vari_name, data_name,
         width = 15, height = 10, dpi = 500, units = "cm", device='png')
  rm(data_name, vari_name, taxon)
}

### exporting files (SVG)
# for (taxon in taxons){
#   vari_name <- paste0("~/meta_taraocean/data/results/output/taxonomic/plots/svg/taxo_",taxon,".svg")
#   data_name <- get(paste0("taxo_",taxon))
#   dev.copy(svg,vari_name,width = 7,height = 5)
#   dev.off()
#   # rm(data_name, vari_name, taxon)
# }

taxo_kingdom
dev.copy(svg, paste0("~/meta_taraocean/data/results/output/taxonomic/plots/svg/taxo_kingdom.svg"), width = 7, height = 5)
dev.off()

taxo_phylum
dev.copy(svg, paste0("~/meta_taraocean/data/results/output/taxonomic/plots/svg/taxo_phylum.svg"), width = 7, height = 5)
dev.off()

taxo_class
dev.copy(svg, paste0("~/meta_taraocean/data/results/output/taxonomic/plots/svg/taxo_class.svg"), width = 7, height = 5)
dev.off()

taxo_order
dev.copy(svg, paste0("~/meta_taraocean/data/results/output/taxonomic/plots/svg/taxo_order.svg"), width = 7, height = 5)
dev.off()

taxo_family
dev.copy(svg, paste0("~/meta_taraocean/data/results/output/taxonomic/plots/svg/taxo_family.svg"), width = 7, height = 5)
dev.off()

taxo_genus
dev.copy(svg, paste0("~/meta_taraocean/data/results/output/taxonomic/plots/svg/taxo_genus.svg"), width = 7, height = 5)
dev.off()

taxo_species
dev.copy(svg, paste0("~/meta_taraocean/data/results/output/taxonomic/plots/svg/taxo_species.svg"), width = 7, height = 5)
dev.off()


###################################################################### PALETTES ######################################################################

stg_colors <- c("#E6E8FA", "#FFCCCC", "#FFCC99", "#FFFFCC", "#CCCCCC", "#FF6666", "#FFCC33", "#FFFF99", "#C0C0C0", "#FF0000",
                "#FF9900", "#FFFF00", "#999999", "#CC0000", "#FF6600", "#FFCC00", "#666666", "#990000", "#CC6600", "#999900",
                "#333333", "#660000", "#993300", "#666600", "#000000", "#330000", "#663300", "#333300", "#99FF99", "#CCFFFF",	
                "#FFCCFF", "#66FF99", "#66FFFF", "#00FFFF", "#FF99FF", "#33FF33", "#33CCFF", "#FF00FF", "#00CC00", "#3366FF",	
                "#CC33CC", "#009900", "#3333FF", "#993366", "#006600", "#000099", "#663366", "#003300", "#000066", "#330033")


stg_colors2 <- c("#363636", "#696969", "#C0C0C0", "#6A5ACD", "#836FFF", "#483D8B", "#000080", "#0000CD", "#6495ED", "#4169E1",
                 "#00BFFF", "#87CEEB", "#4682B4", "#00FFFF", "#00CED1", "#40E0D0", "#008B8B", "#7FFFD4", "#00FA9A", "#98FB98",
                 "#8FBC8F", "#3CB371", "#008000", "#32CD32", "#ADFF2F", "#6B8E23", "#556B2F", "#808000", "#BDB76B", "#DAA520",
                 "#B8860B", "#8B4513", "#A0522D", "#BC8F8F", "#D2691E", "#F4A460", "#FFDEAD", "#DEB887", "#7B68EE", "#9370DB",
                 "#4B0082", "#9400D3", "#BA55D3", "#8B008B", "#FF00FF", "#C71585", "#FF1493", "#FF69B4", "#F08080", "#CD5C5C",
                 "#DC143C", "#8B0000", "#FA8072", "#FF7F50", "#FF6347", "#FF8C00", "#FFD700", "#FFFF00", "#D8BFD8", "#B0E0E6")

mat_pal <- c("#d50000", "#ef5350", "#b71c1c", "#ff5252", "#f06292", "#ad1457", "#880e4f", "#ff80ab", "#ab47bc", "#6a1b9a", 
             "#4a148c", "#ea80fc", "#9575cd", "#673ab7", "#311b92", "#6200ea", "#7986cb", "#5c6bc0", "#1a237e", "#8c9eff", 
             "#64b5f6", "#1565c0", "#0d47a1", "#80d8ff", "#00b0ff", "#80deea", "#006064", "#18ffff", "#26a69a", "#004d40", 
             "#1de9b6", "#66bb6a", "#1b5e20", "#00e676", "#558b2f", "#76ff03", "#9e9d24", "#827717", "#fdd835", "#f57f17", 
             "#ffab00", "#ffb74d", "#ff5722", "#bf360c", "#795548", "#3e2723", "#757575", "#424242", "#78909c", "#455a64")

mat_pal2 <- c("#424242", "#76ff03", "#004d40", "#795548", "#80deea", "#311b92", "#00e676", "#66bb6a", "#0d47a1", "#7986cb", 
              "#5c6bc0", "#78909c", "#455a64", "#bf360c", "#558b2f", "#4a148c", "#9e9d24", "#6a1b9a", "#26a69a", "#757575", 
              "#ea80fc", "#ffab00", "#ad1457", "#f57f17", "#80d8ff", "#ffb74d", "#006064", "#3e2723", "#8c9eff", "#ab47bc", 
              "#64b5f6", "#18ffff", "#9575cd", "#880e4f", "#6200ea", "#1b5e20", "#1a237e", "#1de9b6", "#b71c1c", "#1565c0", 
              "#827717", "#f06292", "#673ab7", "#00b0ff", "#ef5350", "#ff80ab", "#ff5722", "#ff5252", "#e57373", "#fdd835")


mat_pal3 <- c("#800000","#8B0000","#A52A2A","#B22222","#DC143C","#FF0000","#FF6347","#FF7F50",
              "#CD5C5C","#F08080","#E9967A","#FA8072","#FFA07A","#FF4500","#FF8C00","#FFA500",
              "#FFD700","#B8860B","#DAA520","#EEE8AA","#BDB76B","#F0E68C","#808000","#FFFF00",
              "#9ACD32","#556B2F","#6B8E23","#7CFC00","#7FFF00","#ADFF2F","#006400","#008000",
              "#228B22","#00FF00","#32CD32","#90EE90","#98FB98","#8FBC8F","#00FA9A","#00FF7F",
              "#2E8B57","#66CDAA","#3CB371","#20B2AA","#2F4F4F","#008080","#008B8B","#00FFFF",
              "#00FFFF","#E0FFFF","#00CED1","#40E0D0","#48D1CC","#AFEEEE","#7FFFD4","#B0E0E6",
              "#5F9EA0","#4682B4","#6495ED","#00BFFF","#1E90FF","#ADD8E6","#87CEEB","#87CEFA",
              "#191970","#000080","#00008B","#0000CD","#0000FF","#4169E1","#8A2BE2","#4B0082",
              "#483D8B","#6A5ACD","#7B68EE","#9370DB","#8B008B","#9400D3","#9932CC","#BA55D3",
              "#800080","#D8BFD8","#DDA0DD","#EE82EE","#FF00FF","#DA70D6","#C71585","#DB7093",
              "#FF1493","#FF69B4","#FFB6C1","#FFC0CB","#FAEBD7","#F5F5DC","#FFE4C4","#FFEBCD",
              "#F5DEB3","#FFF8DC","#FFFACD","#FAFAD2","#FFFFE0","#8B4513","#A0522D","#D2691E",
              "#CD853F","#F4A460","#DEB887","#D2B48C","#BC8F8F","#FFE4B5","#FFDEAD","#FFDAB9",
              "#FFE4E1","#FFF0F5","#FAF0E6","#FDF5E6","#FFEFD5","#FFF5EE","#F5FFFA","#708090",
                "#778899","#B0C4DE","#E6E6FA","#FFFAF0","#F0F8FF","#F8F8FF","#F0FFF0","#FFFFF0",
              "#F0FFFF","#FFFAFA","#000000","#696969","#808080","#A9A9A9","#C0C0C0","#D3D3D3",
              "#DCDCDC","#F5F5F5","#FFFFFF")

mat_pal_kgd <- c("#40C4FF","#F06292","#FFD600")
