### Ativando o protocolMeta
#set +eu
#PS1=dummy
#. $(conda info --base)/etc/profile.d/conda.sh
#conda activate protocolMeta


############################################################ Download Samples ############################################################
#ENA
#ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR599/ERR599095/ERR599095_1.fastq.gz

#Model: wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR599/ERR599095/ERR599095_1.fastq.gz

############################################################ Extract Samples ############################################################
#Model: pigz -d Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz -p 8	

############################################################ Quality Control ############################################################
#Model: fastp -i SRR579292_1.fastq -I SRR579292_2.fastq -o trimmed/SRR579292_1_trim.fastq -O trimmed/SRR579292_2_trim.fastq -q 20 -w 8 --detect_adapter_for_pe -h trimmed/report.html -j trimmed/fastp.json

############################################################ Alignment With Reference Genome ############################################################
#Model: bowtie2 -x removal/index/host -1 trimmed/SRR579292_1_trim.fastq -2 trimmed/SRR579292_2_trim.fastq -S removal/all.sam -p 8

############################################################ Extract Reads Unaligned ############################################################
#Model:samtools view -bS removal/all.sam > removal/all.bam
#Model: samtools view -b -f 12 -F 256 removal/all.bam > removal/unaligned.bam
#Model: samtools sort -n removal/unaligned.bam -o removal/unaligned_sorted.bam
#Model: samtools bam2fq removal/unaligned_sorted.bam > removal/unaligned.fastq
#Model: cat removal/unaligned.fastq | grep '^@.*/1$' -A 3 --no-group-separator > removal/unaligned_1.fastq
#Model: cat removal/unaligned.fastq | grep '^@.*/2$' -A 3 --no-group-separator > removal/unaligned_2.fastq

############################################################ Merge Paired-End Reads ############################################################
#Model: fastp -i removal/unaligned_1.fastq -I removal/unaligned_2.fastq -o trimmed/unassembled_1.fastq -O trimmed/unassembled_2.fastq -q 20 -w 8 --detect_adapter_for_pe -h trimmed/report2.html -j trimmed/fastp2.json -m --merged_out assembled/SRR579292_assembled.fastq

############################################################ Remove Duplicate Sequences ############################################################
#Model: fastx_collapser -i assembled/SRR579292_assembled.fastq -o collapsed/SRR579292.fasta

############################################################ Alignment ############################################################
#Model: touch unaligned.fasta
#Model: diamond blastx -d index/nr -q ../data/collapsed/SRR579292.fasta -o matches.m8 --top 3 --un unaligned.fasta

############################################################ Taxonomic Classification ############################################################
#Modelo: kaiju -t kaiju/nodes.dmp -f kaiju/kaiju_db_nr.fmi -i benchmark/sim1.fastq -o benchmark/kaiju.out -z 64
#Modelo: kaiju-addTaxonNames -t kaiju/nodes.dmp -n kaiju/names.dmp -r superkingdom,phylum,class,order,family,genus,species -i benchmark/kaiju.out -o benchmark/kaiju.names.out

############################################################ Functional Annotation ############################################################
#Model: annotate idmapping diamond.m8 outputFunctional.txt NR2GO

