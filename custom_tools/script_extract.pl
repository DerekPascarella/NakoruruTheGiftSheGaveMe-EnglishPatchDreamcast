#!/usr/bin/perl
#
# script_extract.pl
# Extract only dialog text from script files in "Nakoruru: The Gift She Gave Me".
#
# Written by Derek Pascarella (ateam)

use strict;
use utf8;
use String::HexConvert ':all';
use Encode qw(decode encode);
use Spreadsheet::WriteExcel;

my $script_folder = "/mnt/z/dc/gdi/new/nakoruru/script/SCD/";
my $output_folder = "/mnt/z/dc/gdi/new/nakoruru/script/SCD_XLS/";
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

		my $workbook = Spreadsheet::WriteExcel->new($output_folder . $script_files[$i] . ".xlsx");
		my $worksheet = $workbook->add_worksheet();
		my $header_bg_color = $workbook->set_custom_color(40, 191, 191, 191);

		my $header_format = $workbook->add_format();
		$header_format->set_bold();
		$header_format->set_border();
		$header_format->set_bg_color(40);

		my $cell_format = $workbook->add_format();
		$cell_format->set_border();
		$cell_format->set_align('left');

		$worksheet->set_column('C:C', 60);
		$worksheet->set_column('D:D', 60);
		$worksheet->set_column('E:E', 60);

		$worksheet->write(0, 0, "Line #", $header_format);
		$worksheet->write(0, 1, "Group", $header_format);
		$worksheet->write(0, 2, "Japanese Text", $header_format);
		$worksheet->write(0, 3, "English Translation", $header_format);
		$worksheet->write(0, 4, "Notes", $header_format);

		for(my $j = 0; $j < scalar(@script_file_lines); $j ++)
		{
			my @script_text = split(/\|/, $script_file_lines[$j]);
			my $next_line_number = $script_text[0] + 1;
			my $previous_line_number = $script_text[0] - 1;
			$worksheet->write($j + 1, 0, $script_text[0], $cell_format);

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
				$worksheet->write($j + 1, 1, $temp_line_group, $cell_format);

				print $temp_line_group;
			}
			else
			{
				$temp_line_group = 0;
				$master_line_count ++;
				$worksheet->write($j + 1, 1, "X", $cell_format);

				print "x";				
			}

			$worksheet->write_utf16be_string($j + 1, 2, Encode::encode("utf-16", Encode::decode("utf-8", $script_text[1])), $cell_format);
			$worksheet->write($j + 1, 3, "", $cell_format);
			$worksheet->write($j + 1, 4, "", $cell_format);

			print "]: $script_text[1]\n";
		}
	}
	else
	{
		print "file $script_files[$i] contains no script text\n";
	}

	@script_file_lines = ();
	$script_line = 0;

	#<>;
}

print "\ntotal script files: $master_script_count\n";
print "total dialog lines: $master_line_count\n\n";
