#!/usr/bin/perl
use strict;
use warnings;

print "\n\nStarting script, please be patient, it will take 20 min to install WSPR software !!!\n\n";
print "Update system\n";
update();
print "Add jessie to sources.list\n";




########################################################################################
sub update
	{
		open(my $UPDATE,"apt-get update |") || die "Failed: $!\n";
		while ( <$UPDATE> )
			{
  				print $_;
			}
 
		close($UPDATE);
	}
