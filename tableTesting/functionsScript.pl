#!/usr/bin/perl
#use warnings;
use Path::Tiny qw(path);

#TODO: Function for formatting tables
#TODO: Function for parsing tables into strings

sub parseTable {
	my @return_array;
	foreach $section (@_) {
		my @column_lengths;
		my @rows = split('\n', $section);
		foreach $item (@rows) {
			my @columns = split(' | ', $item);
			my $column_index = 0;
			foreach $item (@columns) {
				@column_lengths[$column_index] += length $item;
			}
		}
	}
}

#Importing the file
my $filename = 'cp18.md';
my $file = path($filename);
my $data = $file ->slurp_utf8;


#Placing tables into an array and replacing them in the file
my @table_values;

while($data =~ s/(\n([^\n]+\s(\|\s[^\n]+)+)\n(-\s(\|\s-)+)\n([^\n]+\s(\|\s[^\n]+)+\n)+)/(table_block)/xs) {
	push @table_values, $0;
}

#Fitting tables
$data =~ s/\(table_block\)/\n(table_block)\n/g;

#TODO: Format the tables better
#Replacing tables
$data =~ s/\(table_block\)/ shift @table_values/xge;

#Formatting tables
$data =~ s/(-\s\|)/-\|/g;
$data =~ s/(\|\s-\n)/\|\-:\n/g;

$file->spew_utf8( $data );
