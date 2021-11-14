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

print "Processing script file \"$script_file\"...\n";

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
	if(exists($english_replacements{$j + 1}) && $english_replacements{$j + 1} ne "")
	{
		my $temp_hex;

		if($j > 0)
		{
			$temp_hex .= "0A";
		}

		$temp_hex .= &generate_hex($english_replacements{$j + 1});

		if((($english_replacements{$j + 2} eq "" && $english_replacements{$j + 3} eq "" && $textfile_lines[$j + 3] =~ /^wpv/)
			|| ($english_replacements{$j + 2} eq "" && $textfile_lines[$j + 2] =~ /^wpv/)
			|| ($textfile_lines[$j + 1] =~ /^wpv/))
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
					if($textfile_lines[$j + 1] =~ /^wpv/)
					{
						$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 1]), 0, -2);
						$textfile_lines[$j + 1] = "";
					}
					elsif($textfile_lines[$j + 2] =~ /^wpv/)
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
				else
				{
					$temp_hex .= "0D";
				}
			}
		}
		else
		{
			$temp_hex .= "0D";
		}

		if($j < scalar(@textfile_lines) - 1)
		{
			my $l = $j + 1;
			my $mih_pattern_found = 0;

			while($mih_pattern_found == 0 && $l < scalar(@textfile_lines) - 1)
			{
				if($english_replacements{$l + 1} eq "" || !exists($english_replacements{$l + 1}))
				{
					if($textfile_lines[$l] =~ /^mih 000/)
					{
						$mih_pattern_found = 1;
					}
					else
					{
						$l ++;
					}
				}
				elsif($l > $j + 1)
				{
					$temp_hex .= "0A6D6968203030300D";
					$mih_pattern_found = 1;

					print " -> Found a missing \"mih 000\" code: line $l\n";
				}
				else
				{
					$mih_pattern_found = 1;
				}
			}
		}

		$full_file_hex .= $temp_hex;
		$line_count_english ++;
	}
	elsif(!exists($english_replacements{$j + 1}) && $textfile_lines[$j] ne "")
	{
		if($j > 0)
		{
			$full_file_hex .= "0A";
		}

		if($textfile_lines[$j] =~ /mtt 000 016 05/ && $script_file =~ /quiz/)
		{
			print " -> Set infinite quiz question timer: line $j\n";

			$textfile_lines[$j] =~ s/mtt 000 016 05/mit 000/g;
		}
		
		$full_file_hex .= ascii_to_hex($textfile_lines[$j]);

		if($j == scalar(@textfile_lines) - 1)
		{
			$full_file_hex .= "0A";
		}

		$line_count_orig ++;
	}
}

my $line_count_total = () = $full_file_hex =~ /0D0A/gi;
my @full_file_hex_array = split(//, $full_file_hex);
&write_bytes(\@full_file_hex_array, "txt_new/" . $script_file_out);

print " -> Original line count: $line_count_orig\n";
print " -> New line count: $line_count_total\n";
print " -> English dialog lines processed: $line_count_english\n";

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
	my $input = $_[0];
	$input =~ s/^\s+|\s+$//g;
	$input =~ s/ +/ /;
	$input =~ s/\s+/ /g;
	$input =~ s/’/'/g;
	$input =~ s/”/"/g;
	$input =~ s/“/"/g;
	$input =~ s/…/\.\.\./g;
	$input =~ s/\.\.\./#/g;
	$input =~ s/#/##/g;
	my %char_table;

	open my $char_map_handle, '<', $char_map;
	chomp(my @mapped_chars = <$char_map_handle>);
	close $char_map_handle;

	foreach(@mapped_chars)
	{
		my @tmp_char_split = split(/\|/, $_);
		$char_table{$tmp_char_split[1]} = $tmp_char_split[0];
	}

	my $hex_final;
	my $folded_text = fold_text($input, 26, {'soft_hyphen_threshold' => '0'});
	my @folded_text_array_temp = split("\n", $folded_text);
	my @folded_text_array;

	if(scalar(@folded_text_array_temp) > 3 && substr($input, 0, 1) eq "[")
	{
		my $folded_text_temp;
		(my $name) = $input =~ /\[\s*([^]]+)]/x;

		for(1 .. 3)
		{
			push(@folded_text_array, shift(@folded_text_array_temp));
		}

		ADD_NAME_LABEL:

		$folded_text_temp = "[" . $name . "] " . join(" ", @folded_text_array_temp);
		$folded_text_temp =~ s/^\s+|\s+$//g;
		$folded_text_temp =~ s/ +/ /;
		$folded_text_temp =~ s/\s+/ /g;
		$folded_text = fold_text($folded_text_temp, 26, {'soft_hyphen_threshold' => '0'});
		@folded_text_array_temp = split("\n", $folded_text);

		if(scalar(@folded_text_array_temp) <= 3)
		{
			for(1 .. scalar(@folded_text_array_temp))
			{
				push(@folded_text_array, shift(@folded_text_array_temp));
			}
		}
		elsif(scalar(@folded_text_array_temp) > 3)
		{
			for(1 .. 3)
			{
				push(@folded_text_array, shift(@folded_text_array_temp));
			}

			goto ADD_NAME_LABEL;
		}
	}
	else
	{
		@folded_text_array = @folded_text_array_temp;
	}

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