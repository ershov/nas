#!/usr/bin/perl -w
use strict;

use File::Basename 'fileparse';
use File::Copy; # 'syscopy';
use File::Find 'find';
use File::Path 'make_path';

if (@ARGV < 2) {
	print STDERR "Usage: phcp [-cp | -mv | -symlink | -link | -dry] TO FROM [FROM ...]\n";
	exit;
}

my @files;
my %dates;
my $method = "cp";

while (@ARGV && $ARGV[0] =~ /^-/) {
	my $opt = shift @ARGV;
	last if $opt eq '--';
	($opt eq '-cp') && ($method = 'cp') ||
	($opt eq '-mv') && ($method = 'mv') ||
	($opt eq '-symlink') && ($method = 'symlink') ||
	($opt eq '-link') && ($method = 'link') ||
	($opt eq '-dry') && ($method = 'dry') ||
	die "Unknown option: $opt";
}

my ($to, @from) = @ARGV;

#die "$from is not a folder" if !-d $from;
die "$to is not a folder" if !$to || !-d $to;

$|=1;

print "Method: $method. Scaning [@from] -> $to ...\n";
find {
	no_chdir => 1,
	preprocess => sub {sort grep /^[^.\@]/, @_},
	wanted => sub {
		return if !-f $_;
		push @files, [my ($fullpath, $name, $dir, $ext) = ($_, fileparse($_,qr{\.[^.]*}))];
		if (my @d = getdate($_)) {
			$dates{"$dir $name"} = [@d];
		}
	},
}, @from;

my $i = 0;
#$SIG{INFO} = sub { print "$i/".@files."\n"; };
for my $f (@files) {
	if (exists $dates{qq{@{$f}[2,1]}}) {
		#print "@$f : @{$dates{qq{@{$f}[2,1]}}}\n";
		my $d = $dates{qq{@{$f}[2,1]}};
		my $subdir = "$d->[0]/".join("-",@{$d}[0,1,2]);
		my $file = join("-",@{$d}[0,1,2])."_".join("",@{$d}[3,4,5])."__$f->[1]$f->[3]";
		substr($file, 0, 17) eq substr($f->[1], 0, 17) and $file = "$f->[1]$f->[3]";  # already prefixed
		my $srcf = $f->[0];
		print "$srcf -> $to/$subdir/$file ";
		make_path "$to/$subdir" if !-d "$to/$subdir";
		if (-f "$to/$subdir/$file" && -s $srcf == -s "$to/$subdir/$file") {
			print "exists";
			if ($method eq 'mv') {
				print " del ";
				unlink $srcf or print "$!";
			}
		} else {
			if ($method eq 'cp') {
				File::Copy::syscopy $srcf, "$to/$subdir/$file" or print "$!";
			} elsif ($method eq 'mv') {
				rename $srcf, "$to/$subdir/$file" or print "$!";
			} elsif ($method eq 'symlink') {
				use Path::Class 'file';
				my $relpath = file($srcf)->relative("$to/$subdir");
				print "$relpath ";
				symlink $relpath, "$to/$subdir/$file" or print "$!";
			} elsif ($method eq 'link') {
				link $srcf, "$to/$subdir/$file" or print "$!";
			} elsif ($method eq 'dry') {
				print "copy";
			} else {
				die "Internal error: unknown method $method";
			}
		}
		print "\n";
	} else {
		print "$f->[0] skip\n";
	}
	$i++;
}

sub getdate
{
	my @ret;
	(@ret = &getdate1) ? @ret : (@ret = &getdate2) ? @ret : (@ret = &getdate3) ? @ret : ();
}

sub getdate0
{
	open F, "<$_[0]" or return undef;
	my $txt = "";
	sysread F, $txt, 4096;
	close F;
	my @ret;
	@ret = ($txt =~ /(\d{4}):(\d\d):(\d\d) (\d\d):(\d\d):(\d\d)/) and return @ret;
	@ret = ($_[0] =~ /(\d{4})(\d\d)(\d\d)_(\d\d)(\d\d)(\d\d)\.mp4$/i) and return @ret;
	return ();
}

sub getdate1
{
	open F, "<$_[0]" or return undef;
	my $txt = "";
	sysread F, $txt, 4096;
	close F;
	my @ret = ($txt =~ /(\d{4}):(\d\d):(\d\d) (\d\d):(\d\d):(\d\d)/);
	return @ret;
}

sub getdate2
{
	return () if $_[0] =~ /\.mp4/;  # mp4 doesn't have a date in it.
	open F, "<$_[0]" or return undef;
	my $txt = "";
	sysread F, $txt, 8*1024*1024;
	close F;
	my @ret = ($txt =~ m{(\d{4})[:/](\d\d)[:/](\d\d) (\d\d):(\d\d):(\d\d)});
	return @ret;
}

sub getdate3
{
	my @ret;
	@ret = ($_[0] =~ /(\d{4})(\d\d)(\d\d)_(\d\d)(\d\d)(\d\d).*?\.(?:mp4|jpg|jpeg|png|mov)$/i) and return @ret;
	@ret = ($_[0] =~ /(\d{4})-(\d\d)-(\d\d)_(\d\d)(\d\d)(\d\d).*?\.(?:mp4|jpg|jpeg|png|mov)$/i) and return @ret;
	@ret = ($_[0] =~ /\.(?:mp4|jpg|jpeg|png|mov)$/i) and return qw/0000 00 00 00 00 00/;
	return ();
}

