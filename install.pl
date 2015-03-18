#!/usr/bin/perl
use strict;
use warnings;

print "\n\nStarting script, please be patient, it will take 20 min to install WSPR software !!!\n\n";
print "Update system\n";

goto NEXT;

update();
print "Add jessie to sources.list\n";

open ( my $SOURCESREAD,"/etc/apt/sources.list");
my $sourcesWheezy  = <$SOURCESREAD>;
close $SOURCESREAD;




open ( my $SOURCES,"+>/etc/apt/sources.list");
my $sourcesJessie = "deb http://mirrordirector.raspbian.org/raspbian/ jessie main contrib non-free rp";
print $SOURCES $sourcesJessie;
close $SOURCES;

print "Update jessie sources\n";
update();
print "Install python3-pil.imagetk -y\n";
open(my $INSTALLPYTHON,"apt-get install python3-pil.imagetk -y |") || die "Failed: $!\n";
while( <$INSTALLPYTHON> )
	{
		print $_;
	}
close $INSTALLPYTHON;


print "Activate back wheezy source\n";
open ($SOURCES,"+>/etc/apt/sources.list");
print $SOURCES $sourcesWheezy;
close $SOURCES;
print "Update wheezy source\n";

print "Installing audio library\n";
open (my $INSTALLAUDIO,"sudo apt-get install libportaudio2 portaudio19-dev libsamplerate0-dev libfftw3-dev -y |") || die "Failed: $!\n";
while( <$INSTALLAUDIO> )
        {
                print $_;
        }
close $INSTALLAUDIO;

NEXT:

print "Activate back jessy source\n";
open ($SOURCES,"+>/etc/apt/sources.list");
print $SOURCES $sourcesJessie;
close $SOURCES;

print "Update jessie source\n";
update();

print "Install gcc 4.9 ......\n";
open(my $INSTALLGCC,"sudo apt-get install gcc-4.9 g++-4.9 gfortran-4.9  tk8.6-dev tcl8.6-dev python3-pip -y |") || die "Failed: $!\n";
while( <$INSTALLGCC> )
        {
                print $_;
        }
close $INSTALLGCC;


open (my $ADJUST," rm /usr/bin/gcc rm /usr/bin/arm-linux-gnueabihf-gcc  ln -s /usr/bin/gcc-4.9 gcc ln -s /usr/bin/gcc-4.9 arm-linux-gnueabihf-gcc rm /usr/bin/g++ ln -s /usr/bin/g++-4.9 g++ rm /usr/bin/gfortran ln -s /usr/bin/gfortran-4.9 gfortran -y |") || die "Failed: $!\n";
while( <$ADJUST> )
	{
		print $_;
	}
close $ADJUST;


print "Installing Python pillow\n";

open (my $INSTALLPILLOW,"apt-get install --reinstall python3-pillow -y |") || die "Failed: $!\n";
while( <$INSTALLPILLOW> )
        {
                print $_;
        }
close $INSTALLPILLOW;

print "Install pillow 2.5.3\n";
open (my $INSTALLPILLOW2,"pip3 install -I pillow==2.5.3 -y |") || die "Failed: $!\n";
while( <$INSTALLPILLOW2> )
        {
                print $_;
        }
close $INSTALLPILLOW2;

print "Install libjack\n";
open (my $INSTALLLIBJACK,"apt-get install libjack-jackd2-0 portaudio19-dev -y |") || die "Failed: $!\n";
while( <$INSTALLLIBJACK> )
        {
                print $_;
        }
close $INSTALLLIBJACK;

print "Get source from web...\n";

open (my $SVN," svn co svn://svn.code.sf.net/p/wsjt/wsjt/branches/wspr |") || die "Failed: $!\n";
while( <$SVN> )
        {
                print $_;
        }
close $SVN;

print "Create Makefile....\n";
open (my $Makefile,"cd wspr ./autogen.sh |") || die "Failed: $!\n";
while( <$Makefile> )
        {
                print $_;
        }
close $Makefile;









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


