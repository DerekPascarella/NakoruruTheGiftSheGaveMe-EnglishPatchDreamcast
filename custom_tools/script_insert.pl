#!/usr/bin/perl
#
# script_insert.pl
# Insert English text into script files from "Nakoruru: The Gift She Gave Me".
#
# Written by Derek Pascarella (ateam)

# Include necessary modules.
use strict;
use Text::Fold;
use HTML::Entities;
use Text::Unidecode;
use String::HexConvert ':all';
use Spreadsheet::Read qw(ReadData);

# Initialize/declare initial variables.
my $script_file = $ARGV[0];
my $input_path = "xls/";
my $original_script_path = "txt/";
my $output_path = "txt_new/";
my($script_file_out) = $script_file =~ /\((\w+)\)/;
my $line_count_orig = 0;
my $line_count_english = 0;
my %english_replacements;
my $full_file_hex;
my @textfile_lines;

# Read and store spreadsheet.
my $spreadsheet = ReadData($input_path . $script_file . ".xlsx");
my @spreadsheet_rows = Spreadsheet::Read::rows($spreadsheet->[1]);

# Status message.
print "Processing script file \"$script_file\"...\n";

# Iterate through each row of spreadsheet, storing English text from 4th row in "english_replacements" hash.
for(my $i = 1; $i < scalar(@spreadsheet_rows); $i ++)
{
	my $line_number_spreadsheet = int($spreadsheet_rows[$i][0]);
	my $english_text = decode_entities($spreadsheet_rows[$i][3]);
	$english_replacements{$line_number_spreadsheet} = $english_text;
}

# Open original script file corresponding to spreadsheet input.
open(FH, '<', $original_script_path . $script_file . ".txt");

# Iterate through each line of text.
while(<FH>)
{
	# Truncate newline.
	chomp;

	# Replace "large font" occurrences with regular type.
	$_ =~ s/mrn la/mrn no/g;

	# Append line of text to "textfile_lines" array.
	push(@textfile_lines, $_);
}

# Close original script file.
close(FH);

# Iterate through each line of original script text stored in "textfile_lines" array.
for(my $j = 0; $j < scalar(@textfile_lines); $j ++)
{
	# If current line of script file exists in the "english_replacements" hash and is not empty, proceed
	# with processing it.
	if(exists($english_replacements{$j + 1}) && $english_replacements{$j + 1} ne "")
	{
		# Declare variable to store English text hex representation.
		my $temp_hex;

		# If processing any line of script file after the first one, append "0A" (newline) hex value to it.
		if($j > 0)
		{
			$temp_hex .= "0A";
		}

		# If English text represents spoken dialog (e.g. "[Speaker] This is my line."), is a player-selectable
		# response for an in-game question, or is part of a minigame script file (e.g. "scd_rs01_h0119_(825)"),
		# automatically use the default font.
		if(substr($english_replacements{$j + 1}, 0, 1) eq "["
			|| $textfile_lines[$j + 1] =~ /^mit/ || $textfile_lines[$j + 1] =~ /^mtt/
			|| $textfile_lines[$j + 2] =~ /^mit/ || $textfile_lines[$j + 2] =~ /^mtt/
			|| $textfile_lines[$j + 3] =~ /^mit/ || $textfile_lines[$j + 3] =~ /^mtt/
			|| $script_file =~ /^scd_rs0[0-9]_h/)
		{
			$temp_hex .= &generate_hex("chars.txt", $english_replacements{$j + 1});
		}
		# Otherwise, English text is inner-monologue and so use the italic font.
		else
		{
			$temp_hex .= &generate_hex("chars_italic.txt", $english_replacements{$j + 1});
		}

		# If English text is multi-line and original script file contained sound clip playback after the original
		# Japanese text was rendered (i.e. "wpv" control code), apply special processing in order to correctly
		# shift sound clip playback back up to the appropriate spot.
		if((($english_replacements{$j + 2} eq "" && $english_replacements{$j + 3} eq "" && $textfile_lines[$j + 3] =~ /^wpv/)
			|| ($english_replacements{$j + 2} eq "" && $textfile_lines[$j + 2] =~ /^wpv/)
			|| ($textfile_lines[$j + 1] =~ /^wpv/))
			&& $temp_hex =~ /0D0A6D6968203030300D0A6D726E206E6F0D0A/)
		{
			# Increase original line count by one.
			$line_count_orig ++;

			# Split hex representation of English text at each "new textbox" control code ([CRLF] "mih 000"
			# [CRLF] "mrs no" [CRLF]) and store each slice in "temp_hex_split" array.
			my @temp_hex_split = split(/0D0A6D6968203030300D0A6D726E206E6F0D0A/, $temp_hex);
			
			# Clear "temp_hex" variable.
			$temp_hex = "";
			
			# Iterate through each element of temp_hex_split" array.
			for(my $k = 0; $k < scalar(@temp_hex_split); $k ++)
			{
				# Append current element to "temp_hex" variable.
				$temp_hex .= $temp_hex_split[$k];

				# If processing the first line of multi-line English text, make "wpv" control code adjustments.
				if($k == 0)
				{
					# Sound clip playback control code appears after first line of original Japanese text, so
					# shift it up one.
					if($textfile_lines[$j + 1] =~ /^wpv/)
					{
						$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 1]), 0, -2);
						$textfile_lines[$j + 1] = "";
					}
					# Sound clip playback control code appears after second line of original Japanese text, so
					# shift it up two.
					elsif($textfile_lines[$j + 2] =~ /^wpv/)
					{
						$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 2]), 0, -2);
						$textfile_lines[$j + 2] = "";
					}
					# Sound clip playback control code appears after third line of original Japanese text, so
					# shift it up three.
					elsif($textfile_lines[$j + 3] =~ /^wpv/)
					{
						$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 3]), 0, -2);
						$textfile_lines[$j + 3] = "";
					}
				}

				# If processing last line of multi-line English text, append "new textbox" control code ([CRLF]
				# "mih 000" [CRLF] "mrs no" [CRLF]).
				if($k < scalar(@temp_hex_split) - 1)
				{
					$temp_hex .= "0D0A6D6968203030300D0A6D726E206E6F0D0A";
				}
				# Otherwise, append only newline.
				else
				{
					$temp_hex .= "0D";
				}
			}
		}
		# Otherwise, append newline to "text_hex" and proceed.
		else
		{
			$temp_hex .= "0D";
		}

		# If processing anything but the last line of the script file, add any missing "mih 000" control codes that
		# are responsible for clean generation of new textboxes.
		if($j < scalar(@textfile_lines) - 1)
		{
			# Initialize "l" variable with a value of "j" (current line array element) plus one, used to look ahead
			# one line.
			my $l = $j + 1;

			# Initialize the found-pattern variable to false (0).
			my $mih_pattern_found = 0;

			# While missing control code isn't found and and end of script file not yet reached, continue search for
			# missing control codes.
			while($mih_pattern_found == 0 && $l < scalar(@textfile_lines) - 1)
			{
				# There is no English text stored after the current line "l" of the original script file.
				if($english_replacements{$l + 1} eq "" || !exists($english_replacements{$l + 1}))
				{
					# Current line "l" contains "mih 000" control code.
					if($textfile_lines[$l] =~ /^mih 000/)
					{
						# Control code found, so set found-pattern variable to true (1) to end loop.
						$mih_pattern_found = 1;
					}
					# Otherwise, increase "l" to seek next line.
					else
					{
						# Increase search line "l" by one.
						$l ++;
					}
				}
				# Next set of English text has appeared in seek, so consider control code missing and add it back to
				# script file.
				elsif($l > $j + 1)
				{
					# Append hex representation of "mih 000 [CRLF]" to "temp_hex".
					$temp_hex .= "0A6D6968203030300D";
					
					# Control code added, so set found-pattern variable to true (1) to end loop.
					$mih_pattern_found = 1;

					# Status message.
					print " -> Found a missing \"mih 000\" code: line $l\n";
				}
				# Otherwise, consider the control code present.
				else
				{
					# Control code assumed present, so set found-pattern variable to true (1) to end loop.
					$mih_pattern_found = 1;
				}
			}
		}

		# Append "temp_hex" to "full_file_hex" variable.
		$full_file_hex .= $temp_hex;

		# Increase English line counter by one.
		$line_count_english ++;
	}
	# If current line of script file does not exist in the "english_replacements" hash and is not empty, proceed
	# with processing it.
	elsif(!exists($english_replacements{$j + 1}) && $textfile_lines[$j] ne "")
	{
		# If processing any line of script file after the first one, append "0A" (newline) hex value to it.
		if($j > 0)
		{
			$full_file_hex .= "0A";
		}

		# If timed-response control code "mtt 000 016 xx" is found on current line of script file, replace it
		# with untimed response control code (mit 000).
		if($textfile_lines[$j] =~ /mtt 000 016 05/ && $script_file =~ /quiz/)
		{
			# Status message.
			print " -> Set infinite quiz question timer: line $j\n";

			# Replace control code.
			$textfile_lines[$j] =~ s/mtt 000 016 05/mit 000/g;
		}
		
		# Appent current line of script file to "full_file_hex" variable.
		$full_file_hex .= ascii_to_hex($textfile_lines[$j]);

		# If processing last line of script file, append "0A" (newline) hex value to it.
		if($j == scalar(@textfile_lines) - 1)
		{
			$full_file_hex .= "0A";
		}

		# Increase original Japanese line counter by one.
		$line_count_orig ++;
	}
}

# Store new script file's line count.
my $line_count_total = () = $full_file_hex =~ /0D0A/gi;

# Store each byte from "full_file_hex" into an element of "full_file_hex_array" and then write it all to
# output file.
my @full_file_hex_array = split(//, $full_file_hex);
&write_bytes(\@full_file_hex_array, $output_path . $script_file_out);

# Status message.
print " -> Original line count: $line_count_orig\n";
print " -> New line count: $line_count_total\n";
print " -> English dialog lines processed: $line_count_english\n";

# Subroutine to write array of hex values to a file.
sub write_bytes
{
	# Initialize/declare input parameters.
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

# Subroutine to generate English text hex in the expected format for insertion back into script.
sub generate_hex
{
	# Initialize/declare input parameters.
	my $char_map = $_[0];
	my $input = $_[1];

	# Initialize/declare initial variables.
	my %char_table;
	my $hex_final;

	# Clean input text.
	$input =~ s/^\s+|\s+$//g;
	$input =~ s/ +/ /;
	$input =~ s/\s+/ /g;
	$input =~ s/’/'/g;
	$input =~ s/”/"/g;
	$input =~ s/“/"/g;
	$input =~ s/…/\.\.\./g;
	$input =~ s/\.\.\./#/g;
	$input =~ s/#/##/g;

	# Open specific character map and store it in "mapped_chars" array.
	open my $char_map_handle, '<', $char_map;
	chomp(my @mapped_chars = <$char_map_handle>);
	close $char_map_handle;

	# Iterate through "mapped_chars" array to create "char_table" hash with hex value for each supported
	# character.
	foreach(@mapped_chars)
	{
		my @tmp_char_split = split(/\|/, $_);
		$char_table{$tmp_char_split[1]} = $tmp_char_split[0];
	}

	# Fold input text into separate elements of "folded_text_array" where each line is a maximum of 26
	# characters.
	my $folded_text = fold_text($input, 26, { 'soft_hyphen_threshold' => '0' });
	my @folded_text_array_temp = split("\n", $folded_text);
	my @folded_text_array;

	# Apply special processing to input text if it is spoken dialog (i.e. starts with an open bracket)
	# and is more than three lines long.
	if(scalar(@folded_text_array_temp) > 3 && substr($input, 0, 1) eq "[")
	{
		# Parse speaker's name from input text.
		(my $name) = $input =~ /\[\s*([^]]+)]/x;

		# Continue to process each line of "folded_text_array_temp" until each element has been shifted
		# out of it into "folded_text_array".
		while(scalar(@folded_text_array_temp) > 0)
		{
			# Shift first three elements of "folded_text_array_temp" into "folded_text_array".
			for(1 .. 3)
			{
				push(@folded_text_array, shift(@folded_text_array_temp));
			}

			# Take remainder of text past third line and prepend speaker's name to it, as well as clean
			# it of any unwanted extra whitespace.
			my $folded_text_temp = "[" . $name . "] " . join(" ", @folded_text_array_temp);
			$folded_text_temp =~ s/^\s+|\s+$//g;
			$folded_text_temp =~ s/ +/ /;
			$folded_text_temp =~ s/\s+/ /g;
			$folded_text = fold_text($folded_text_temp, 26, { 'soft_hyphen_threshold' => '0' });
			@folded_text_array_temp = split("\n", $folded_text);

			# If three or fewer lines remain, shift them from "folded_text_array_temp" into
			# "folded_text_array".
			if(scalar(@folded_text_array_temp) <= 3)
			{
				for(1 .. scalar(@folded_text_array_temp))
				{
					push(@folded_text_array, shift(@folded_text_array_temp));
				}
			}
		}
	}
	# Otherwise, simply copy "folded_text_array_temp" into "folded_text_array".
	else
	{
		@folded_text_array = @folded_text_array_temp;
	}

	# Iterate through each line of input text in "folded_text_array".
	for(my $i = 0; $i < scalar(@folded_text_array); $i ++)
	{
		# Clean text.
		$folded_text_array[$i] =~ s/^\s+|\s+$//g;
		(my $temp_text = $folded_text_array[$i]) =~ s/##/#/g;
		
		# Store each character into a separate element of "folded_chars".
		my @folded_chars = split(//, $temp_text);
		my $char_count = 0;

		# Iterate through each element of "folded_chars" array.
		foreach(@folded_chars)
		{
			# Copy hex value from hash "char_table" to "hex_final".
			$hex_final .= $char_table{$_};

			# If current character is "#", increase character count by two, as this is used to
			# represent two periods "..", which are used after a single period to create an ellipses.
			if($_ eq "#")
			{
				$char_count += 2;
			}
			# Otherwise, just increase character count by one.
			else
			{
				$char_count ++;
			}
		}

		# If processing any line of text except the last one, and it contains fewer than the
		# horizontal maximum of 26 characters, artificially pad it to bring it's length to 26.
		if($char_count < 26 && $i < scalar(@folded_text_array) - 1)
		{
			foreach(1 .. (26 - $char_count))
			{
				$hex_final .= "8140";
			}
		}

		# If processing the third, sixth, etc. line of text and more text is still to follow, append 
		# "new textbox" control code ([CRLF] "mih 000" [CRLF] "mrs no" [CRLF]).
		if(($i + 1) % 3 == 0 && $i < scalar(@folded_text_array) - 1)
		{
			$hex_final .= "0D0A6D6968203030300D0A6D726E206E6F0D0A";
		}
	}

	# Return final hex representation of input text.
	return $hex_final;
}