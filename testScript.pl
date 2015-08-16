#!/usr/bin/perl
#use warnings;
use Path::Tiny qw(path);

#Importing the file
my $filename = 'cp15.md';
my $file = path($filename);
my $data = $file ->slurp_utf8;

#Placing code blocks into an array and replacing them in the file
my @code_block_values;
my $i = 0;
while($i > 50) {
	@code_bock_values[$i] = ($data =~ /\n\t*```[^`]+(```){1}\n/);
	$data =~ s/\n\t*```[^`]+(```){1}\n/(code_block)/;
	$i = $i + 1;
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

#replacing code_blocks
$i = 0;
while($i < 50) {
	$data =~ s/\(code_block\)/$code_block_values[$i]/;
	$i = $i + 1;
}
print $data;

$file->spew_utf8( $data );
