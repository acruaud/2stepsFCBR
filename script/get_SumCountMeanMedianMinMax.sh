#!/bin/sh

#modified from source https://unix.stackexchange.com/a/13779
#to include cases of empty files 

#goal : give the sum, data count, minimum datum, maximum datum, mean and median of a single column of numeric data (including negative numbers)

sort -n | awk '
  BEGIN {
    c = 0;
    sum = 0;
  }
  $1 ~ /^(\-)?[0-9]*(\.[0-9]*)?$/ {
    a[c++] = $1;
    sum += $1;
  }
  END {
    if (NR>0){
    ave = sum / c;
    if( (c % 2) == 1 ) {
      median = a[ int(c/2) ];
    } else {
      median = ( a[c/2] + a[c/2-1] ) / 2;
    }
    OFS="\t";
    print sum, c, ave, median, a[0], a[c-1];
    } else print "NA\t0\tNA\tNA\tNA\tNA"
  }
'
