#!/bin/bash 
#SBATCH --job-name=environment   #nome do job
#SBATCH --time=20-0:00	#tempo limite de execucao

#SBATCH --nodes=1	#número de nós
#SBATCH --mem=128000	#quantidade total de memoria
#SBATCH --qos=qos2	#tipo de multiplos jobs
#SBATCH --exclusive	#no exclusivo
 
#SBATCH --mail-user=bianca.santiago72@gmail.com
#SBATCH --mail-type=ALL

######################################################################################################################################################################################################

### Importing Variables
source 00-var.sh

### Instalations

#cd $instalers

### Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh
echo "miniconda downloaded"
chmod u+x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

### protocolMeta
#conda install anaconda-client
#conda env create arthurvinx/protocolMeta


### Configuring medusaPipeline
conda activate base
conda install anaconda-client -y
conda env create arthurvinx/medusaPipeline
conda activate medusaPipeline
pip3 install -U plyvel --no-cache-dir --no-deps --force-reinstall

conda activate base
conda install -c conda-forge mamba -y
mamba create -c bioconda -c conda-forge -n snakemake snakemake


### Kaiju
conda install -c bioconda kaiju
conda install -c bioconda/label/cf201901 kaiju


### Create thhe folder structure
mkdir -p ./Protocol/{data/{assembled,collapsed,raw,removal/{index,reference},trimmed},alignment/{db,index},taxonomic,functional}


### Databases

cd $reference
### Download a reference genome from Ensembl
wget ftp://ftp.ensembl.org/pub/release-98/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
echo "downloaded reference genome"
pigz -d Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz -p 8
echo "reference genome extracted"
### Build a bowtie2 index::
bowtie2-build Homo_sapiens.GRCh38.dna.primary_assembly.fa ../index/host --threads 8
echo "reference genome index created"


cd $db
### Download the NCBI non-redundant protein database:
wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nr.gz
echo "downloaded protein database"
pigz -d nr.gz -p 8
echo "extracted protein database"
### Build a DIAMOND index:
diamond makedb --in nr -d ../index/nr
echo "protein database index created"


cd $kaiju
### Creating database (downloading nr)
kaiju-makedb -s nr -t 30

