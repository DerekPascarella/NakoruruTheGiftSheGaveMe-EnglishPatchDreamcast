#!/usr/bin/perl
#
# script_insert.pl
# Insert English text into script files from "Nakoruru: The Gift She Gave Me".
#
# Written by Derek Pascarella (ateam)

# Include necessary modules.
use strict;
use Text::Fold;
use Text::Unidecode;
use HTML::Entities;
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
	# If current line of script file exists in the "english_replacements" hash and is not empty, proceed with
	# processing it.
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
		# response for an in-game question, is a game over/retry prompt (e.g. "scd_51_dgo_(966)"), is the
		# game over text from one of the endings (e.g. "scd_27_i_dc_(972)"), or is part of a minigame
		# score-result script file (e.g. "scd_rs01_h0119_(825)"), automatically use the default font.
		if(substr($english_replacements{$j + 1}, 0, 1) eq "["
			|| $textfile_lines[$j + 1] =~ /^mit/ || $textfile_lines[$j + 1] =~ /^mtt/
			|| $textfile_lines[$j + 2] =~ /^mit/ || $textfile_lines[$j + 2] =~ /^mtt/
			|| $textfile_lines[$j + 3] =~ /^mit/ || $textfile_lines[$j + 3] =~ /^mtt/
			|| $script_file =~ /^scd_rs0[0-9]_h/
			|| $script_file =~ /go_/
			|| $script_file =~ /yn_/
			|| ($script_file =~ /i_[d|p]c/ && $english_replacements{$j + 1} =~ /GAME OVER/))
		{
			# If processing a line for a player-selectable response only, pass "response" as a third parameter
			# to the "generate_hex" subroutine so that it won't receive artificial padding.
			if($textfile_lines[$j + 1] =~ /^mit/ || $textfile_lines[$j + 1] =~ /^mtt/
				|| $textfile_lines[$j + 2] =~ /^mit/ || $textfile_lines[$j + 2] =~ /^mtt/
				|| $textfile_lines[$j + 3] =~ /^mit/ || $textfile_lines[$j + 3] =~ /^mtt/)
			{
				$temp_hex .= &generate_hex("chars.txt", $english_replacements{$j + 1}, "response");
			}
			# If processing a line for a minigame result, pass "result" as a third parameter to the
			# "generate_hex" subroutine so that dummy audio clip playback is not appended to text.
			elsif($script_file =~ /^scd_rs0[0-9]_h/)
			{
				$temp_hex .= &generate_hex("chars.txt", $english_replacements{$j + 1}, "result");
			}
			# If processing a line of spoken dialog that isn't accompanied by an audio clip, add dummy audio
			# clip playback to ensure previous clip is stopped as intended.
			elsif(substr($english_replacements{$j + 1}, 0, 1) eq "["
					&& ($textfile_lines[$j + 1] !~ /^wpv/ && $textfile_lines[$j + 2] !~ /^wpv/ && $textfile_lines[$j + 3] !~ /^wpv/))
			{

				$temp_hex .= &generate_hex("chars.txt", $english_replacements{$j + 1}, "no_voice");
			}
			# Otherwise, process line normally.
			else
			{
				$temp_hex .= &generate_hex("chars.txt", $english_replacements{$j + 1});
			}
		}
		# Otherwise, English text is inner-monologue and so use the italic font.
		else
		{
			$temp_hex .= &generate_hex("chars_italic.txt", $english_replacements{$j + 1});
		}

		# If English text is multi-line and original script file contained voice clip playback after the
		# original Japanese text was rendered (i.e. "wpv" control code), apply special processing in order to
		# correctly shift sound clip playback back up to the appropriate spot.
		if((($english_replacements{$j + 2} eq "" && $english_replacements{$j + 3} eq "" && $textfile_lines[$j + 3] =~ /^wpv/)
			|| ($english_replacements{$j + 2} eq "" && $textfile_lines[$j + 2] =~ /^wpv/)
			|| ($textfile_lines[$j + 1] =~ /^wpv/))
			&& $temp_hex =~ /0D0A6D6968203030300D0A6D726E206E6F0D0A/i)
		{
			# Increase original line count by one.
			$line_count_orig ++;

			# Split hex representation of English text at each "new textbox" control code ([CRLF] "mih 000"
			# [CRLF] "mrn no" [CRLF]) and store each slice in "temp_hex_split" array.
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

						# If audio plays and won't be stopped by another textbox right away (e.g. background/
						# foreground texture transitions or other effects), insert dummy audio playback to halt
						# it.
						if($textfile_lines[$j + 2] =~ /^mih 000/ && $textfile_lines[$j + 3] !~ /^mrn no/)
						{
							$textfile_lines[$j + 2] .= "\nwpv p 4-e/xxxxxx //dummy audio to stop voice\r";

							# Status message.
							print " -> Inserted scene-transition voice cutoff: line " . ($j + 2) . "\n";
						}

						# Clear original "wpv" control code.
						$textfile_lines[$j + 1] = "";
					}
					# Sound clip playback control code appears after second line of original Japanese text, so
					# shift it up two.
					elsif($textfile_lines[$j + 2] =~ /^wpv/)
					{
						$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 2]), 0, -2);

						# If audio plays and won't be stopped by another textbox right away (e.g. background/
						# foreground texture transitions or other effects), insert dummy audio playback to halt
						# it.
						if($textfile_lines[$j + 3] =~ /^mih 000/ && $textfile_lines[$j + 4] !~ /^mrn no/)
						{
							$textfile_lines[$j + 3] .= "\nwpv p 4-e/xxxxxx //dummy audio to stop voice\r";

							# Status message.
							print " -> Inserted scene-transition voice cutoff: line " . ($j + 3) . "\n";
						}

						# Clear original "wpv" control code.
						$textfile_lines[$j + 2] = "";
					}
					# Sound clip playback control code appears after third line of original Japanese text, so
					# shift it up three.
					elsif($textfile_lines[$j + 3] =~ /^wpv/)
					{
						$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 3]), 0, -2);

						# If audio plays and won't be stopped by another textbox right away (e.g. background/
						# foreground texture transitions or other effects), insert dummy audio playback to halt
						# it.
						if($textfile_lines[$j + 4] =~ /^mih 000/ && $textfile_lines[$j + 5] !~ /^mrn no/)
						{
							$textfile_lines[$j + 4] .= "\nwpv p 4-e/xxxxxx //dummy audio to stop voice\r";

							# Status message.
							print " -> Inserted scene-transition voice cutoff: line " . ($j + 4) . "\n";
						}

						# Clear original "wpv" control code.
						$textfile_lines[$j + 3] = "";
					}
				}

				# If processing last line of multi-line English text, append "new textbox" control code ([CRLF]
				# "mih 000" [CRLF] "mrn no" [CRLF]).
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
		# If original script contains voice clip playback (i.e. "wpv" control code) but is not multi-line, apply
		# special processing to those which happen before a scene transition and require being cut off using
		# dummy voice clip playback.
		elsif((($english_replacements{$j + 2} eq "" && $english_replacements{$j + 3} eq "" && $textfile_lines[$j + 3] =~ /^wpv/)
			|| ($english_replacements{$j + 2} eq "" && $textfile_lines[$j + 2] =~ /^wpv/)
			|| ($textfile_lines[$j + 1] =~ /^wpv/)))
		{
			# Sound clip playback control code appears after first line of original Japanese text, so
			# shift it up one.
			if($textfile_lines[$j + 1] =~ /^wpv/)
			{
				$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 1]), 0, -2);

				# If audio plays and won't be stopped by another textbox right away (e.g. background/
				# foreground texture transitions or other effects), insert dummy audio playback to halt
				# it.
				if($textfile_lines[$j + 2] =~ /^mih 000/ && $textfile_lines[$j + 3] !~ /^mrn no/)
				{
					$textfile_lines[$j + 2] .= "\nwpv p 4-e/xxxxxx //dummy audio to stop voice\r";

					# Status message.
					print " -> Inserted scene-transition voice cutoff: line " . ($j + 2) . "\n";
				}

				# Clear original "wpv" control code.
				$textfile_lines[$j + 1] = "";
			}
			# Sound clip playback control code appears after second line of original Japanese text, so
			# shift it up two.
			elsif($textfile_lines[$j + 2] =~ /^wpv/)
			{
				$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 2]), 0, -2);

				# If audio plays and won't be stopped by another textbox right away (e.g. background/
				# foreground texture transitions or other effects), insert dummy audio playback to halt
				# it.
				if($textfile_lines[$j + 3] =~ /^mih 000/ && $textfile_lines[$j + 4] !~ /^mrn no/)
				{
					$textfile_lines[$j + 3] .= "\nwpv p 4-e/xxxxxx //dummy audio to stop voice\r";

					# Status message.
					print " -> Inserted scene-transition voice cutoff: line " . ($j + 3) . "\n";
				}

				# Clear original "wpv" control code.
				$textfile_lines[$j + 2] = "";
			}
			# Sound clip playback control code appears after third line of original Japanese text, so
			# shift it up three.
			elsif($textfile_lines[$j + 3] =~ /^wpv/)
			{
				$temp_hex .= "0D0A" . substr(ascii_to_hex($textfile_lines[$j + 3]), 0, -2);

				# If audio plays and won't be stopped by another textbox right away (e.g. background/
				# foreground texture transitions or other effects), insert dummy audio playback to halt
				# it.
				if($textfile_lines[$j + 4] =~ /^mih 000/ && $textfile_lines[$j + 5] !~ /^mrn no/)
				{
					$textfile_lines[$j + 4] .= "\nwpv p 4-e/xxxxxx //dummy audio to stop voice\r";

					# Status message.
					print " -> Inserted scene-transition voice cutoff: line " . ($j + 4) . "\n";
				}

				# Clear original "wpv" control code.
				$textfile_lines[$j + 3] = "";
			}
		}
		# Otherwise, append newline to "text_hex" and proceed.
		else
		{
			$temp_hex .= "0D";
		}

		# If processing anything but the last line of the script file, add any missing "mih 000" control codes
		# that are responsible for clean generation of new textboxes.
		if($j < scalar(@textfile_lines) - 1)
		{
			# Initialize "l" variable with a value of "j" (current line array element) plus one, used to look
			# ahead one line.
			my $l = $j + 1;

			# Initialize the found-pattern variable to false (0).
			my $mih_pattern_found = 0;

			# While missing control code isn't found and and end of script file not yet reached, continue
			# search for missing control codes.
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
				# Next set of English text has appeared in seek, so consider control code missing and add it
				# back to script file, unless current text is part of a player-response selection.
				elsif($l > $j + 1 && @textfile_lines[$j + 1] !~ /^mit 000/ && @textfile_lines[$j + 1] !~ /^mtt 000 016 05/)
				{
					# Append hex representation of "[CR] mih 000 [LF]" to "temp_hex".
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
	# If current line of script file does not exist in the "english_replacements" hash and is not empty,
	# proceed with processing it.
	elsif(!exists($english_replacements{$j + 1}) && $textfile_lines[$j] ne "")
	{
		# If processing any line of script file after the first one, append "0A" (newline) hex value to it.
		if($j > 0)
		{
			$full_file_hex .= "0A";
		}

		# If timed-response control code "mtt 000 016 05" is found on current line of script file, replace it
		# with untimed response control code (mit 000).
		if($textfile_lines[$j] =~ /^mtt 000 016 05/ && $script_file =~ /quiz/)
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

# If processing a minigame result script (e.g. "scd_rs01_h0119_(825)"), use colored font for "RESULTS" text.
if($script_file =~ /^scd_rs0[0-9]_h/)
{
	$full_file_hex =~ s/0D0A82B082BD82CC82CE82C582CD82CC8141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181410D0A/0D0A8AE88ACF8AE98AEC8ADC8AEB8AE98141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181418141814181410D0A/gi;
}

# Replace Nakoruru's mysterious prayer text placeholder with hex for actual characters from row 23 in
# scd_25_b_(119).
$full_file_hex =~ s/82AE82B0829F82B782A382B082B282A382B682B282D882D6/8260826182638264826582668267826982D882D6/gi;

# Store new script file's line count.
my $line_count_total = () = $full_file_hex =~ /0D0A/gi;

# Write contents of "full_file_hex" to output file.
&write_bytes($output_path . $script_file_out, $full_file_hex);

# Status message.
print " -> Original line count: $line_count_orig\n";
print " -> New line count: $line_count_total\n";
print " -> English dialog lines processed: $line_count_english\n";

# Subroutine to write sequence of hex values to a file.
sub write_bytes
{
	# Initialize/declare input parameters.
	my $output_file = $_[0];
	(my $hex_data = $_[1]) =~ s/\s+//g;
	my @hex_data_array = split(//, $hex_data);

	# Open output file for writing binary data.
	open my $filehandle, '>', $output_file or die $!;
	binmode $filehandle;

	# Iterate through "hex_data_array" and write bytes to target file.
	for(my $i = 0; $i < @hex_data_array; $i += 2)
	{
		my($high, $low) = @hex_data_array[$i, $i + 1];
		print $filehandle pack "H*", $high . $low;
	}

	# Close output file.
	close $filehandle;
}

# Subroutine to generate hash containing character map of hex values.
sub generate_character_map_hash
{
	# Store specified character map's filename and declare hash.
	my $character_map_file = $_[0];
	my %character_table;

	# Open specific character map and store it in "mapped_characters" array.
	open my $filehandle, '<', $character_map_file or die $!;
	chomp(my @mapped_characters = <$filehandle>);
	close $filehandle;

	# Iterate through "mapped_characters" array to create "char_table" hash with hex value for each
	# supported character.
	foreach(@mapped_characters)
	{
		$character_table{(split /\|/, $_)[1]} = (split /\|/, $_)[0];
	}

	# Return hash containing character map.
	return %character_table;
}

# Subroutine to generate English text hex in the expected format for insertion back into script.
sub generate_hex
{
	# Initialize/declare input parameters.
	my $char_map = $_[0];
	my $input = $_[1];
	my $special = $_[2];

	# Initialize/declare initial variables.
	my %colored_char_table = &generate_character_map_hash("chars_colored.txt");
	my %char_table = &generate_character_map_hash($char_map);
	my $name_dialog = 0;
	my $name_length;
	my $pre_name_fix;
	my $hex_final;
	my $pad_count;

	# Clean input text.
	$input =~ s/^\s+|\s+$//g;
	$input =~ s/ +/ /;
	$input =~ s/\s+/ /g;
	$input =~ s/’/'/g;
	$input =~ s/”/"/g;
	$input =~ s/“/"/g;
	$input =~ s/\.\.\.\.\.\./\.\.\./g;
	$input =~ s/\.\.\.\.\./\.\.\./g;
	$input =~ s/\.\.\.\./\.\.\./g;
	$input =~ s/…/\.\.\./g;
	$input =~ s/\.\.\.\?/^/g;
	$input =~ s/\^/^^/g;
	$input =~ s/\.\.\.\!/&/g;
	$input =~ s/&/&&/g;
	$input =~ s/\.\.\./#/g;
	$input =~ s/#/##/g;

	# Fold input text into separate elements of "folded_text_array" where each line is a maximum of 52
	# characters.
	my $folded_text = fold_text($input, 52, { 'soft_hyphen_threshold' => '0' });
	my @folded_text_array = split("\n", $folded_text);
	my @folded_text_array_temp;

	# Apply special processing to input text if it is spoken dialog (i.e. starts with an open bracket).
	if(substr($input, 0, 1) eq "[")
	{
		# Set "name_dialog" flag to "1" to represent fact that script line is spoken by a character and is not
		# inner-monologue.
		$name_dialog = 1;

		# Parse speaker's name from input text and remove any commas or extraneous whitespace from it.
		(my $name) = $input =~ /\[\s*([^]]+)]/x;
		$name =~ s/,//g;
		$name =~ s/^\s+|\s+$//g;

		# Store original, unmodified version of speaker's name parsed from input text, which is necessary to
		# handle multi-speaker lines (e.g. [Ubaba, Mibaba, Hibaba] Hey!).
		(my $name_original) = $input =~ /\[\s*([^]]+)]/x;
		
		# Remove speaker's name and brackets from input text.
		$input =~ s/\[\Q$name\E\]//g;
		$input =~ s/\[\Q$name_original\E\]//g;

		# Fix commonly misspelled names, ignoring names with spaces (e.g. Man's Voice, Villager 1, etc.).
		if($name =~ /Mik(?!ato)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Mikato";
		}
		elsif($name =~ /Yant(?!amu)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Yantamu";
		}
		elsif($name =~ /Nak(?!oruru)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Nakoruru";
		}
		elsif($name =~ /Out(?!ada)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Outada";
		}
		elsif($name =~ /Man(?!ari)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Manari";
		}
		elsif($name =~ /Rim(?!ururu)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Rimururu";
		}
		elsif($name =~ /Hok(?!ute)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Hokute";
		}
		elsif($name =~ /H(?!ok).*ute/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Hokute";
		}
		elsif($name =~ /Re(?!ra)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Rera";
		}
		elsif($name =~ /Ub(?!aba)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Ubaba";
		}
		elsif($name =~ /Hib(?!aba)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Hibaba";
		}
		elsif($name =~ /Mib(?!aba)/ && $name !~ / /)
		{
			$pre_name_fix = $name;
			$name = "Mibaba";
		}

		# Display status message if a name fix took place.
		if($pre_name_fix ne "")
		{
			print " -> Found and fixed misspelled name: $pre_name_fix ($name)\n";
		}

		# Convert "name" to uppercase.
		$name = uc($name);

		# Store character count for speaker's name.
		$name_length = length($name);

		# Prepend converted "name" to "input".
		$input = $name . " " . $input;

		# Remove extraneous whitespace from input.
		$input =~ s/^\s+|\s+$//g;
		$input =~ s/ +/ /;
		$input =~ s/\s+/ /g;

		# Fold input text into separate elements of "folded_text_array" where each line is a maximum of 52
		# characters.
		$folded_text = fold_text($input, 52, { 'soft_hyphen_threshold' => '0' });
		@folded_text_array = split("\n", $folded_text);

		# If dialog exceeds three lines in length, apply special processing.
		if(scalar(@folded_text_array) > 3)
		{
			# Copy "folded_text_array" into "folded_text_array_temp", as the latter will be processed
			# element-by-element, and clear all elements from "folded_text_array".
			@folded_text_array_temp = @folded_text_array;
			@folded_text_array = ();

			# Continue to process each line of "folded_text_array_temp" until each element has been shifted out
			# of it into "folded_text_array".
			while(scalar(@folded_text_array_temp) > 0)
			{
				# Shift first three elements of "folded_text_array_temp" into "folded_text_array".
				for(1 .. 3)
				{
					push(@folded_text_array, shift(@folded_text_array_temp));
				}

				# Take remainder of text past third line and prepend speaker's name to it, as well as clean it
				# of any unwanted extra whitespace.
				my $folded_text_temp = $name . " " . join(" ", @folded_text_array_temp);
				$folded_text_temp =~ s/^\s+|\s+$//g;
				$folded_text_temp =~ s/ +/ /;
				$folded_text_temp =~ s/\s+/ /g;
				$folded_text = fold_text($folded_text_temp, 52, { 'soft_hyphen_threshold' => '0' });
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
	}

	# Iterate through each line of input text in "folded_text_array".
	for(my $i = 0; $i < scalar(@folded_text_array); $i ++)
	{
		# Clean text.
		$folded_text_array[$i] =~ s/^\s+|\s+$//g;
		(my $temp_text = $folded_text_array[$i]) =~ s/##/#/g;
		$temp_text =~ s/\^\^/^/g;
		$temp_text =~ s/&&/&/g;
		
		# Store each character into a separate element of "folded_chars".
		my @folded_chars = split(//, $temp_text);
		my $char_count = 0;

		# Iterate through each element of "folded_chars" array to set hex value for each character.
		for(my $m = 0; $m < scalar(@folded_chars); $m ++)
		{
			# If processing a speaker's name and the current character is one from said name, and the current
			# line is the first in a three-line textbox (e.g. line 1, 4, 7, 10, etc.), copy hex value from hash
			# "colored_char_table" to "hex_final".
			if($name_dialog == 1 && $m < $name_length && ($i + 3) % 3 == 0)
			{
				$hex_final .= $colored_char_table{$folded_chars[$m]};
			}
			# Otherwise, copy hex value from hash "char_table" to "hex_final".
			else
			{
				$hex_final .= $char_table{$folded_chars[$m]};
			}

			# If current character is "#", "^", or "&", increase character count by two, as this is used to
			# represent "...", "...?", and "...!", respectively, which are all used for tidier font tiles.
			if($folded_chars[$m] eq "#" || $folded_chars[$m] eq "^" || $folded_chars[$m] eq "&")
			{
				$char_count += 2;
			}
			# Otherwise, just increase character count by one.
			else
			{
				$char_count ++;
			}
		}

		# If processing a line of dialog and it contains fewer than the horizontal maximum of 52 character,
		# artificially pad it to bring its length to 52.
		if($char_count < 52 && $special ne "response")
		{
			foreach(1 .. (52 - $char_count))
			{
				$hex_final .= "8141";
			}
		}

		# If processing the last line of an instance of dialog fewer than 3 lines long, artifically pad
		# it to consume 3 full lines of empty space.
		if($i == scalar(@folded_text_array) - 1 && scalar(@folded_text_array) % 3 != 0 && $special ne "response" && $special ne "result")
		{
			# Ensure dialog instance fills 3 lines (1 box).
			if(scalar(@folded_text_array) < 3)
			{
				$pad_count = 3;
			}
			# Ensure dialog instance fills 6 lines (2 boxes).
			elsif(scalar(@folded_text_array) > 3 && scalar(@folded_text_array) < 6)
			{
				$pad_count = 6;
			}
			# Ensure dialog instance fills 9 lines (3 boxes).
			elsif(scalar(@folded_text_array) > 6 && scalar(@folded_text_array) < 9)
			{
				$pad_count = 9;
			}

			# Iterate through each missing line.
			foreach(1 .. ($pad_count - scalar(@folded_text_array)))
			{
				# Append 52 padding spaces.
				foreach(1 .. 52)
				{
					$hex_final .= "8141";
				}
			}
		}

		# If processing the third, sixth, etc. line of text for a non-voiced line of dialog (i.e. Mikato), or a
		# voiced line with no audio clip, append dummy audio clip playback in order to stop any previous voice
		# playback ("wpv p 4-e/xxxxxx //dummy audio to stop voice").
		if($special ne "response" && $special ne "result"
			&& ((($i + 1) % 3 == 0 && $i < scalar(@folded_text_array) - 1) || $i == scalar(@folded_text_array) - 1)
			&& ($special eq "no_voice" || $name_dialog == 0 || ($name_dialog == 1 && substr($input, 0, 6) eq "MIKATO")))
		{
			$hex_final .= "0D0A777076207020342D652F787878787878202F2F64756D6D7920617564696F20746F2073746F7020766F696365";
		}

		# If processing the third, sixth, etc. line of text and more text is still to follow, append "new
		# textbox" control code ([CRLF] "mih 000" [CRLF] "mrn no" [CRLF]).
		if(($i + 1) % 3 == 0 && $i < scalar(@folded_text_array) - 1)
		{
			$hex_final .= "0D0A6D6968203030300D0A6D726E206E6F0D0A";
		}
	}

	# Return final hex representation of input text.
	return $hex_final;
}