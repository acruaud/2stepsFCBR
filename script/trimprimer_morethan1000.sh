#! /bin/bash

#goal : create a SLURM script to trim primers from full length amplicons when we have more than 1000 combinations of fw x rev primers
#full length amplicon is defined as : ForwardPrimer---------ReversePrimer


#usage
#./script listofinputfiles fileWithCombinationOfprimers outputprefixforSLURMscript=gene

#create selfexplanatory variable
inputfiles=$1
primerfile=$2
outprefix=$3

echo "the file that lists your input files <=> reads merged with FLASH is: " $inputfiles
echo "the file that contains the possible combination of forward x reversed primers is: " $primerfile
#echo "the file that lists your sample codes is: " $samplefile
echo "the prefix <=> gene you want me to use for the output SLURM script is: "$outprefix

#create and store grep cmd to variable
mygrep=$(awk 'BEGIN{print "sed -i \047"} {if(NR==1) {print "s\\/^"$1"\\/\\/g;s\\/"$2"\$\\/\\/g"} else print ";s\\/^"$1"\\/\\/g;s\\/"$2"\$\\/\\/g"} END{print "\047"}' $primerfile |tr '\n' ' ' |sed s/"g ;"/"g;"/g |sed "s/' /'/g" |sed "s/g '/g'/g")

#echo $mygrep

#create cmd to grep full length amplicons for all samples, step 1
sed "s/^/$mygrep /" $inputfiles > "tmp_cmdtrimamplicon_"$outprefix


#create scripts to be embedded in SLURM script
awk '{print $0}' "tmp_cmdtrimamplicon_"$outprefix > $outprefix"_trimamplicon.sh"

#make scripts executable
chmod +x $outprefix"_trimamplicon.sh"

#cleaning
rm "tmp_cmdtrimamplicon_"$outprefix
