#! /bin/bash

#goal : create a SLURM script to mine full length amplicon in a fastq file (e.g. that contains paired reads merged with FLASH) when we have more than 1000 combinations of fw x rev primers
#full length amplicon is defined as : ForwardPrimer---------ReversePrimer


#usage
#./script listofinputfiles fileWithCombinationOfprimers listofsamples outputsuffix=gene

#create selfexplanatory variable
inputfiles=$1
primerfile=$2
samplefile=$3
outsuffix=$4

echo "the file that lists your input files <=> reads merged with FLASH is: " $inputfiles
echo "the file that contains the possible combination of forward x reversed primers is: " $primerfile
echo "the file that lists your sample codes is: " $samplefile
echo "the suffix <=> gene you want me to use for output files is: "$outsuffix

#create and store grep cmd to variable
mygrep=$(awk '{if(NR==1) {print "grep --no-group-separator -B 1 -i \047^"$1"\.*"$2"\$"} else print "\\\\|^"$1"\.*"$2"\$"} END{print "\047"}' $primerfile |tr '\n' ' ' |sed s/"\$ "/"\$"/g)

#echo $mygrep

#create cmd to grep full length amplicons for all samples, step 1
sed "s/^/$mygrep /" $inputfiles > "tmp_cmdgrepamplicon_"$outsuffix

#create cmd to grep full length amplicons for all samples, step	2
awk -F"'" -v suffix=$outsuffix '{split($3,toto,"."); print $0 " >" toto[1]"_"suffix}' "tmp_cmdgrepamplicon_"$outsuffix > "tmp_tmp_cmdgrepamplicon_"$outsuffix

#create scripts to be embedded in SLURM script
awk '{print $0}' "tmp_tmp_cmdgrepamplicon_"$outsuffix > $outsuffix"_mineamplicon.sh"

#make scripts executable
chmod +x $outsuffix"_mineamplicon.sh"

#cleaning
rm "tmp_cmdgrepamplicon_"$outsuffix
rm "tmp_tmp_cmdgrepamplicon_"$outsuffix

