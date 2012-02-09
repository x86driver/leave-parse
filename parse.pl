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

sub parse_item
{
	readline($F) for (0...18);

		print "Location: ", &getline, "\n";
		&skipline(1);
		print "AAA: ", &getline, "\n";
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
}

BEGIN
{
	open $F, "all.html";
	my $line = <$F>;
	while (<$F>) {
		if ($_ =~ /請假列表/) {# || $_ =~ /公出列表/) {
			&parse_item();
		}
	}
}
