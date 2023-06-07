#!/bin/bash 

### Declaring variables

local_address="/~/master_degree/taraocean/"
protocol="/~/master_degree/taraocean/pipeProtocol/Protocol/"
db_kaiju="/~/master_degree/dbs/kaiju"

data="/~/master_degree/taraocean/pipeProtocol/Protocol/data"
raw="/~/master_degree/taraocean/pipeProtocol/Protocol/data/raw"
trimmed="/~/master_degree/taraocean/pipeProtocol/Protocol/data/trimmed"
removal="/~/master_degree/taraocean/pipeProtocol/Protocol/data/removal"    
reference="/~/master_degree/taraocean/pipeProtocol/Protocol/data/removal/reference"
index_remo="/~/master_degree/taraocean/pipeProtocol/Protocol/data/removal/index/host"
assembled="/~/master_degree/taraocean/pipeProtocol/Protocol/data/assembled"
collapsed="/~/master_degree/taraocean/pipeProtocol/Protocol/data/collapsed"

alignment="/~/master_degree/taraocean/pipeProtocol/Protocol/alignment"
db_alig="/~/master_degree/taraocean/pipeProtocol/Protocol/alignment/db"
index_alig="/~/master_degree/taraocean/pipeProtocol/Protocol/alignment/index/nr"

taxonomic="/~/master_degree/taraocean/pipeProtocol/Protocol/taxonomic"
reduced="/~/master_degree/taraocean/pipeProtocol/Protocol/taxonomic/reduced"

functional="/~/master_degree/taraocean/pipeProtocol/Protocol/functional"
db_func="/~/master_degree/taraocean/pipeProtocol/Protocol/functional/db"

url="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/"
slash="/"
one="_1.fastq.gz"
two="_2.fastq.gz"

runs="ERR594324
ERR598972
ERR599023
ERR599025
ERR594385
ERR599021
ERR599164
ERR598970
ERR599088
ERR599150
ERR594392
ERR594291
ERR598990
ERR599018
ERR599110
ERR594382
ERR594414
ERR598960
ERR599034
ERR594320
ERR598979
ERR599146
ERR594359
ERR594361
ERR599040
ERR599148
ERR594321
ERR594298
ERR594355
ERR599000
ERR599154
ERR594333
ERR599010
ERR599126
ERR594310
ERR594286
ERR594354
ERR599046
ERR599101
ERR594336
ERR594303
ERR599124
ERR599159
ERR594289
ERR599006
ERR599022
ERR594340
ERR594332
ERR594411
ERR599042
ERR599079
ERR599071
ERR599085
ERR599093
ERR599120
ERR598961
ERR599086
ERR599077"

