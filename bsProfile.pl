#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my $header=<>; 
chomp $header; 
my @header=split(/,/, $header);
my $sampleHeader = shift(@header); 
my $numCols=@header; 
my $sampleSize=int($numCols/2);

#$numCols = 4;
#$sampleSize=6;

# These are the random columns with replacement.
# SampleID will be added later.
# Columns will be zero-based and will ignore that the sample column is the first column already.
# In other words, a "0" will indicate the first allele and not the sample column.
my @randomSample = ();
for(1..$sampleSize){
    push @randomSample, int(rand($numCols));
}
@randomSample = sort {$a <=> $b} @randomSample;

# print the header for the random columns
print join(",", $sampleHeader, @header[@randomSample]), "\n";

while(<>){
    chomp;
    my @allAlleles = split(/,/);
    my $sampleID = shift(@allAlleles);
    my @randomAlleles = ();
    foreach my $i (@randomSample){
        push @randomAlleles, $allAlleles[$i];
    }
    print join(",", $sampleID, @randomAlleles), "\n";
}