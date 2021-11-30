#!/usr/bin/perl
#
# script_extract_with_machine_translation.pl
# Extract only dialog text from script files in "Nakoruru: The Gift She Gave Me"
# and add machine translation from DeepL.
#
# Written by Derek Pascarella (ateam)

use strict;
use utf8;
use String::HexConvert ':all';
use Encode qw(decode encode);
use Spreadsheet::WriteExcel;
use HTTP::Tiny;
use JSON;
use URI::Encode qw(uri_encode uri_decode);
use Text::Unidecode;
use HTML::Entities;

my $script_folder = "/mnt/z/dc/gdi/new/nakoruru/custom_tools/mltxt/";
my $output_folder = "/mnt/z/dc/gdi/new/nakoruru/custom_tools/mlxls/";
my @script_file_lines = ();
my $script_line = 0;
my $temp_line_group = 0;
my $master_line_count = 0;
my $master_script_count = 0;

opendir(DIR, $script_folder);
my @script_files = grep !/^\.\.?$/, readdir(DIR);
closedir(DIR);

for(my $i = 0; $i < scalar(@script_files); $i ++)
{
	print "-----------------\n";

	open(FH, '<', $script_folder . $script_files[$i]) or die $!;

	while(<FH>)
	{
		$_ = Encode::encode("utf-8", Encode::decode("shiftjis", $_));
		$_ =~ s/\r//g;
		
		$script_line ++;
		
		next if /^\/\//;
		next if /^[a-z]/;
		next if /^[0-9]/;
		
		chomp;

		if($_ =~ /\/\//)
		{
			$_ =~ s/\s.*//;
		}

		push(@script_file_lines, $script_line . "|" . $_);
	}

	close(FH);

	if(scalar(@script_file_lines) > 0)
	{
		$master_script_count ++;

		(my $filename = $script_files[$i]) =~ s/.txt//g;
		my $workbook = Spreadsheet::WriteExcel->new($output_folder . $filename . ".xls");
		my $worksheet = $workbook->add_worksheet();
		my $header_bg_color = $workbook->set_custom_color(40, 191, 191, 191);

		my $header_format = $workbook->add_format();
		$header_format->set_bold();
		$header_format->set_border();
		$header_format->set_bg_color(40);

		my $cell_format = $workbook->add_format();
		$cell_format->set_border();
		$cell_format->set_align('left');
		$cell_format->set_text_wrap();

		$worksheet->set_column('C:C', 60);
		$worksheet->set_column('D:D', 55);
		$worksheet->set_column('E:E', 60);
		$worksheet->set_column('F:F', 60);

		$worksheet->write(0, 0, "Line #", $header_format);
		$worksheet->write(0, 1, "Group", $header_format);
		$worksheet->write(0, 2, "Japanese Text", $header_format);
		$worksheet->write(0, 3, "English Translation", $header_format);
		$worksheet->write(0, 4, "Notes", $header_format);
		$worksheet->write(0, 5, "Machine Translation", $header_format);

		for(my $j = 0; $j < scalar(@script_file_lines); $j ++)
		{
			my @script_text = split(/\|/, $script_file_lines[$j]);
			my $next_line_number = $script_text[0] + 1;
			my $previous_line_number = $script_text[0] - 1;
			my $japanese_text = "";

			$worksheet->write($j + 1, 0, $script_text[0], $cell_format);
			$worksheet->write($j + 1, 5, "", $cell_format);

			print "file $script_files[$i] line $script_text[0] [";

			if($j < scalar(@script_file_lines) - 1 && $script_file_lines[$j + 1] =~ /^$next_line_number\|/)
			{
				if($j > 0 && $script_file_lines[$j - 1] =~ /^$previous_line_number\|/)
				{
					$temp_line_group ++;
				}
				else
				{
					$temp_line_group = 1;
					$master_line_count ++;
				}

				$worksheet->write($j + 1, 1, $temp_line_group, $cell_format);

				print $temp_line_group;
			}
			elsif($j > 0 && $script_file_lines[$j - 1] =~ /^$previous_line_number\|/)
			{
				$temp_line_group ++;
				my $line_count = $j;

				$worksheet->write($j + 1, 1, $temp_line_group, $cell_format);

				print $temp_line_group;

				for(my $k = $temp_line_group; $k > 0; $k --)
				{
					my @script_text_temp = split(/\|/, $script_file_lines[$line_count]);
					$japanese_text = $script_text_temp[1] . $japanese_text;
					$line_count --;
				}

				my $japanese_text = Encode::decode("utf-8", $japanese_text);
				my $http = HTTP::Tiny->new;
				my $post_data = uri_encode("auth_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&target_lang=EN-US&source_lang=JA&text=" . $japanese_text);
				my $response = $http->get("https://api-free.deepl.com/v2/translate?" . $post_data);
				my $english_translation = decode_json($response->{'content'})->{'translations'}->[0]->{'text'};
				
				$worksheet->write($j + (2 - $temp_line_group), 5, $english_translation, $cell_format);
			}
			else
			{
				$temp_line_group = 0;
				$master_line_count ++;

				my $japanese_text_x = Encode::decode("utf-8", $script_text[1]);
				my $http_x = HTTP::Tiny->new;
				my $post_data_x = uri_encode("auth_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&target_lang=EN-US&source_lang=JA&text=" . $japanese_text_x);
				my $response_x = $http_x->get("https://api-free.deepl.com/v2/translate?" . $post_data_x);
				my $english_translation_x = decode_json($response_x->{'content'})->{'translations'}->[0]->{'text'};
				
				$worksheet->write($j + 1, 1, "X", $cell_format);
				$worksheet->write($j + 1, 5, $english_translation_x, $cell_format);

				print "x";
			}

			$worksheet->write_utf16be_string($j + 1, 2, Encode::encode("utf-16", Encode::decode("utf-8", $script_text[1])), $cell_format);
			$worksheet->write($j + 1, 3, "", $cell_format);
			$worksheet->write($j + 1, 4, "", $cell_format);
	
			print "]: $script_text[1]\n";
		}

		$workbook->close();
	}
	else
	{
		print "File $script_files[$i] contains no script text.\n";
	}

	@script_file_lines = ();
	$script_line = 0;

	print "-----------------\n";
}

print "\nTotal script files: $master_script_count\n";
print "Total dialog lines: $master_line_count\n\n";
