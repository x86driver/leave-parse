#!/usr/bin/perl -w

use strict;

my $F;

sub skipline
{
	my $lines = $_[0] - 1;
	readline ($F) for (0...$lines);
}

sub getline
{
	my $line = readline($F);
	$line =~ s/<[^>]*>//g;
	$line =~ s/^[ \t]*//g;
	$line =~ s/\n//g;
	return $line;
}

sub parse_item1
{
	readline($F) for (0...18);

	while (1) {
		print "Location: ", &getline, "\n";
		&skipline(1);
		print "Group: ", &getline, "\n";
		print "Team: ", &getline, "\n";
		print "Number: ", &getline, "\n";
		print "Name: ", &getline, "\n";
		print "From date: ", &getline, "\n";
		print "From time: ", &getline, "\n";
		print "End date: ", &getline, "\n";
		print "End time: ", &getline, "\n";
		print "Total days: ", &getline, "\n";
		print "Total hours: ", &getline, "\n";
		print "Category: ", &getline, "\n";
		&skipline(2);
		print "State: ", &getline, "\n";

		print "\n\n\n";

		&skipline(3);
		my $line = readline($F);
		if ($line =~ /<\/table>/) {
			print "END of 請假列表\n\n";
			last;
		}
	}
}

sub parse_item2
{
	readline($F) for (0...15);
	while (1) {
		print "Location: ", &getline, "\n";
		print "Group: ", &getline, "\n";
		print "Team: ", &getline, "\n";
		print "Number: ", &getline, "\n";
		print "Name: ", &getline, "\n";
		print "Date: ", &getline, "\n";
		print "From time: ", &getline, "\n";
		print "End time: ", &getline, "\n";
		&skipline(1);
		print "Reason: ", &getline, "\n";
		print "State: ", &getline, "\n";

		print "\n\n\n";

		&skipline(2);
		my $line = readline($F);
		if ($line =~ /<\/table>/) {
			print "End of 公出列表\n\n";
			last;
		}
	}
}

BEGIN
{
	open $F, "all.html";
	my $line = <$F>;
	while (<$F>) {
		if ($_ =~ /請假列表/) {
			&parse_item1();
		}
		if ($_ =~ /公出列表/) {
			&parse_item2();
		}
	}
}
