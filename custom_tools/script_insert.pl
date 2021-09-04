#!/usr/bin/perl
#
# script_insert.pl
# Insert English text into script files from "Nakoruru: The Gift She Gave Me".
#
# Written by Derek Pascarella (ateam)

use strict;
use Text::Fold;
use HTML::Entities;
use Text::Unidecode;
use String::HexConvert ':all';
use Spreadsheet::Read qw(ReadData);

my $script_file = $ARGV[0];
my($script_file_out) = $script_file =~ /\((\w+)\)/;
my $spreadsheet = ReadData("xls/" . $script_file . ".xlsx");
my @spreadsheet_rows = Spreadsheet::Read::rows($spreadsheet->[1]);
my %english_replacements;
my $full_file_hex;
my @textfile_lines;
my $line_count_orig = 0;
my $line_count_english = 0;

print "Processing script file \"$script_file\"... ";

for(my $i = 1; $i < scalar(@spreadsheet_rows); $i ++)
{
	my $line_number_spreadsheet = int($spreadsheet_rows[$i][0]);
	my $english_text = decode_entities($spreadsheet_rows[$i][3]);

	$english_replacements{$line_number_spreadsheet} = $english_text;
}

open(FH, '<', "txt/" . $script_file . ".txt") or die $!;

while(<FH>)
{
	chomp;
	$_ =~ s/mrn la/mrn no/g;
	push(@textfile_lines, $_);
}

close(FH);

for(my $j = 0; $j < scalar(@textfile_lines); $j ++)
{
	if(exists($english_replacements{$j + 1}))
	{
		if($english_replacements{$j + 1} ne "")
		{
			my $temp_hex = "0A" . &generate_hex($english_replacements{$j + 1});

			if((($english_replacements{$j + 2} eq "" && $english_replacements{$j + 3} eq "" && $textfile_lines[$j + 3] =~ /^wpv/)
				|| ($english_replacements{$j + 2} eq "" && $textfile_lines[$j + 2] =~ /^wpv/))
				&& $temp_hex =~ /0D0A6D6968203030300D0A6D726E206E6F0D0A/)
			{
				$line_count_orig ++;
				my @temp_hex_split = split(/0D0A6D6968203030300D0A6D726E206E6F0D0A/, $temp_hex);
				$temp_hex = "";

				for(my $k = 0; $k < scalar(@temp_hex_split); $k ++)
				{
					$temp_hex .= $temp_hex_split[$k];

					if($k == 0)
					{
						if($textfile_lines[$j + 2] =~ /^wpv/)
						{
							$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 2]), 0, -2);
							$textfile_lines[$j + 2] = "";
						}
						elsif($textfile_lines[$j + 3] =~ /^wpv/)
						{
							$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 3]), 0, -2);
							$textfile_lines[$j + 3] = "";
						}
					}

					if($k < scalar(@temp_hex_split) - 1)
					{
						$temp_hex .= "0D0A6D6968203030300D0A6D726E206E6F0D0A";
					}
				}
			}
			else
			{
				$temp_hex .= "0D";
			}

			$full_file_hex .= $temp_hex;

			$line_count_english ++;
		}
	}
	else
	{
		if($textfile_lines[$j] ne "")
		{
			if($j > 0)
			{
				$full_file_hex .= "0A";
			}
			
			$full_file_hex .= ascii_to_hex($textfile_lines[$j]);

			if($j == scalar(@textfile_lines) - 1)
			{
				$full_file_hex .= "0A";
			}

			$line_count_orig ++;
		}
	}
}

my @full_file_hex_array = split(//, $full_file_hex);

&write_bytes(\@full_file_hex_array, "txt_new/" . $script_file_out);

print "DONE!\n";
print " -> English dialog line count: $line_count_english\n";
print " -> Total line count: " . ($line_count_orig + $line_count_english) . "\n";

sub write_bytes
{
	my $array_reference = $_[0];
	my $output_file = $_[1];

	open(BIN, ">", $output_file) or die;
	binmode(BIN);

	for(my $o = 0; $o < @$array_reference; $o += 2)
	{
		my($hi, $lo) = @$array_reference[$o, $o + 1];
		
		print BIN pack "H*", $hi . $lo;
	}

	close(BIN);
}

sub generate_hex
{
	my $char_map = "chars.txt";
	my $input_raw = $_[0];
	my $input = $input_raw;
	$input =~ s/^\s+|\s+$//g;
	$input =~ s/ +/ /;
	$input =~ s/\s+/ /g;
	$input =~ s/’/'/g;
	$input =~ s/”/"/g;
	$input =~ s/“/"/g;
	$input =~ s/\.\.\./#/g;
	(my $input_fold = $input) =~ s/#/##/g;
	my %char_table;

	open my $char_map_handle, '<', $char_map;
	chomp(my @mapped_chars = <$char_map_handle>);
	close $char_map_handle;

	foreach(@mapped_chars)
	{
		my @tmp_char_split = split(/\|/, $_);
		$char_table{$tmp_char_split[1]} = $tmp_char_split[0];
	}

	my @input_chars = split(//, $input);

	my $folded_text = fold_text($input_fold, 26, {'soft_hyphen_threshold' => '0'});
	my @folded_text_array = split("\n", $folded_text);
	my $hex_final;

	for(my $i = 0; $i < scalar(@folded_text_array); $i ++)
	{
		$folded_text_array[$i] =~ s/^\s+|\s+$//g;
		(my $display_text = $folded_text_array[$i]) =~ s/##/\.\.\./g;
		(my $temp_text = $folded_text_array[$i]) =~ s/##/#/g;
		my @folded_chars = split(//, $temp_text);
		my $char_count = 0;

		foreach(@folded_chars)
		{
			$hex_final .= $char_table{$_};

			if($_ eq "#")
			{
				$char_count += 2;
			}
			else
			{
				$char_count ++;
			}
		}

		if($char_count < 26 && $i < scalar(@folded_text_array) - 1)
		{
			foreach(1 .. (26 - $char_count))
			{
				$hex_final .= "8140";
			}
		}

		if(($i + 1) % 3 == 0 && $i < scalar(@folded_text_array) - 1)
		{
			$hex_final .= "0D0A6D6968203030300D0A6D726E206E6F0D0A";
		}
	}

	return $hex_final;
}