## Read me

This repo contains the bioinformatic pipeline used to analyse COI amplicon data (FC+BR fragments) generated in the following studies :

xxxxxxx

The pipeline with comments is in the **COIFCBR_pipeline.rtf** file

**Example data are provided in the example/ directory :**

- **fastq.gz files** = raw sequence data for 4 samples (mix of strains of <i>Trichogramma</i> wasps); extraction; PCR and empty well (negative) controls (paired end sequencing 2*250 bp Illumina Miseq)

**Scripts and other infiles are provided in the script/ directory :**

- **adapters.fa** = adapters used for sequencing
- **COIFC.txt**  = possible combinations of forward+reverse specific primers for the COI - FC fragment
- **COIBR.txt**  = possible combinations of forward+reverse specific primers for the COI - BR fragment
- **referencedatabase.fas** = COI reference sequences (FC+BR) for the strains used to prepare mixes of strains
- **get_SumCountMeanMedianMinMax.sh** = script to compute some statistiscs after the clustering step
- **mineamplicon_morethan1000.sh** = script to mine amplicon from raw data
- **trimprimer_morethan1000.sh** = script to trim primers from amplicon

**Outfiles are provided in the output/ directory :**

- **allR1_fastqc.html and allR2_fastqc.html** = FastQC outfiles for the 8 samples for reads 1 (R1) and reads2 (R2)
- **final_summary_table** = final statistics for all samples (note that intermediate tables are not provided, see pipeline)
- **COIFC_allseqdefandref.fasta.al** = alignment of all COI-FC sequences retained by the pipeline before post processing + reference sequences 
- **COIBR_allseqdefandref.fasta.al** = alignment of all COI-BR sequences retained by the pipeline before post processing + reference sequences 
- **COIFCBR_allseqandref.fasta.al** = COI (FC+BR) sequences retained for all samples after post-processing (i.e. removal of non coding pseudogenes, contamination, chimeras etc.) 

If you find something useful in there, please cite our paper(s) ! Thanks 👍
