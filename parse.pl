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
		my $location = &getline;
		&skipline(1);
		my $group = &getline;
		my $team = &getline;
		my $number = &getline;
		my $name = &getline;
		my $fromdate = &getline;
		my $fromtime = &getline;
		my $enddate = &getline;
		my $endtime = &getline;
		my $totaldays = &getline;
		my $totalhours = &getline;
		my $category = &getline;
		&skipline(2);
		my $state = &getline;

		print "Group: ", $group, "\n";
		print "Team: ", $team, "\n";
		print "Number: ", $number, "\n";
		print "Name: ", $name, "\n";
		print "From date: ", $fromdate, "\n";
		print "From time: ", $fromtime, "\n";
		print "End date: ", $enddate, "\n";
		print "End time: ", $endtime, "\n";
		print "Total days: ", $totaldays, "\n";
		print "Total hours: ", $totalhours, "\n";
		print "Category: ", $category, "\n";
		print "State: ", $state, "\n";

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
#			&parse_item2();
		}
	}
}
