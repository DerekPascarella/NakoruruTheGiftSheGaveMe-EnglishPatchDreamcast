#!/usr/bin/perl
#
# script_gen.pl
# Generate hex values for text script in "Nakoruru: The Gift She Gave Me"
# using a custom character map.
#
# Written by Derek Pascarella (ateam)

use strict;
use Text::Unidecode;
use String::HexConvert ':all';
use Text::Fold;

my $char_map = "chars.txt";
my $input_raw = $ARGV[0];
my $input = $input_raw;
$input = unidecode($input);	
$input =~ s/^\s+|\s+$//g;
$input =~ s/ +/ /;
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

print "RAW:\n[$input_raw]\n\nPROCESSED:\n[$input]\n\n\n";

my @input_chars = split(//, $input);

foreach(@input_chars)
{
	if($_ eq "#")
	{
		print "[...]";
	}
	else
	{
		print "[$_]";
	}

	print " = $char_table{$_}\n";
}

print "\n\n";

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

	print "[$display_text]\n";

	foreach(@folded_chars)
	{
		$hex_final .= $char_table{$_};
		
		print $char_table{$_};
		
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
			
			print "8140";
		}
	}

	print "\n";

	if(($i + 1) % 3 == 0 && $i < scalar(@folded_text_array) - 1)
	{
		$hex_final .= "0D0A6D6968203030300D0A6D726E206E6F0D0A";
		
		print "---- NEW TEXTBOX ----\n";
	}
}

print "\n\nFINAL HEX:\n$hex_final\n";