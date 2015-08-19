#!/usr/bin/perl
#use warnings;
use Path::Tiny qw(path);

#TODO: Function for formatting tables
#TODO: Function for parsing tables into strings

sub parseTable {
	my @return_array;
	foreach $section (@_) {
		my $return_section

		my @table;
		my @columns;
		my @col_lengths;
		my $num_columns;
		my @rows = split('\n', $section);
		foreach $item (@rows) {
			@columns = split(' | ', $item);
			$num_columns = scalar @columns;
			my $column_index = 0;
			foreach $item (@columns) {
				@col_lengths[$column_index] += length $item;
				$column_index++;
			}
			#TODO: Start work here
			@table[scalar @table][scalar @table[]] =
		}
		#Now we have the total column lengths
		for (my $i = 0; $i < scalar @col_lengths; $i++) {
			@col_lengths[$i] = @col_lengths[$i] / $num_columns;
		}
		#Now we have the average column lengths
		#Total of 80 columns
		my $char_cols = 80 - (scalar @columns - 1);
		my $total_col_length = 0;
		for(@col_lengths) {
			$total_col_length += $_;
		}
		for (my $i = 0; $i < scalar @col_lengths; $i++) {
			@col_lengths[$i] = (@col_lengths[$i] / $total_col_length) * 80;
		}


		#Concatenating all strings together
		for(my $i = 0; $i < 80; $i++) {
			$return_section .= "-";
		}
		$return_section .= "\n";

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
