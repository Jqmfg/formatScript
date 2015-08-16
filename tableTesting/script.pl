#!/usr/bin/perl
#use warnings;
use Path::Tiny qw(path);

#TODO: Function for formatting tables
#TODO: Function for parsing tables into strings

#Importing the file
my $filename = 'cp18.md';
my $file = path($filename);
my $data = $file ->slurp_utf8;

#Placing code blocks into an array and replacing them in the file
my @code_block_values;

while($data =~ s/(\n\t*```.*?```\n)/(code_block)/xs) {
	push @code_block_values, $1;
}

#Placing tables into an array and replacing them in the file
my @table_values;

while($data =~ s/(\n([^\n]+\s(\|\s[^\n]+)+)\n(-\s(\|\s-)+)\n([^\n]+\s(\|\s[^\n]+)+\n)+)/(table_block)/xs) {
	push @table_values, $1;
}

#All the replacing stuff goes here
$data =~ s/\n\n\n/\n\n/g;
$data =~ s/\n\n/(double_line)/g;
$data =~ s/\n___/(line_break)/g;
$data =~ s/\n        /(line_quad_tab)/g;
$data =~ s/\n      /(line_triple_tab)/g;
$data =~ s/\n    /(line_double_tab)/g;
$data =~ s/\n  /(line_single_tab)/g;
$data =~ s/  / /g;
$data =~ s/\n```/(line_code_block)/g;
$data =~ s/ \n/ /g;
$data =~ s/\n/ /g;
$data =~ s/\(line_code_block\)/\n```/g;
$data =~ s/\(line_single_tab\)/\n  /g;
$data =~ s/\(line_double_tab\)/\n    /g;
$data =~ s/\(line_triple_tab\)/\n      /g;
$data =~ s/\(line_quad_tab\)/\n        /g;
$data =~ s/\(line_break\)/\n___/g;
$data =~ s/\(double_line\)/\n\n/g;
$data =~ s/\s# /\n# /g;

#Fitting tables
$data =~ s/\(table_block\)/\n(table_block)\n/g;

#TODO: Format the tables better
#Replacing tables
$data =~ s/\(table_block\)/ shift @table_values/xge;

#Formatting tables
$data =~ s/(-\s\|)/-\|/g;
$data =~ s/(\|\s-\n)/\|\-:\n/g;

#Replacing code_blocks
$data =~ s/\(code_block\)/ shift @code_block_values/xge;

#Adding in newlines before and after coe blocks
#$data =~ s/```

$file->spew_utf8( $data );
