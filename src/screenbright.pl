#!/usr/bin/perl -w

use strict;
use File::Basename;

my %screens;
my %callbacks;
my $screen;
my $brightness;
my $command;
my $verb;

sub increment
{
  my $screen = shift;
  my $current_brightness = shift;

  my $new_value = $current_brightness + 0.1;

  system("xrandr --output $screen --brightness $new_value") unless ($new_value > 1.0);
}

sub decrement {
  my $screen = shift;
  my $current_brightness = shift;

  my $new_value = $current_brightness - 0.1;

  system("xrandr --output $screen --brightness $new_value") unless ($new_value < 0.1);
}

sub clear {
  my $screen = shift;

  system("xrandr --output $screen --brightness 1.0");
}

sub print_usage
{
  my $name = basename($0);
  print "Usage:\n";
  print "\t$name inc\n";
  print "\t$name dec\n";
  print "\t$name clear\n";
}

%callbacks = ( 'inc' => \&increment, 'dec' => \&decrement, 'clear' => \&clear );

$command = shift @ARGV;

unless (exists $callbacks{$command})
{
  print_usage();
  exit 1;
}

open(XRANDR, "xrandr --prop --verbose |");
while(<XRANDR>)
{
  unless (defined $screen)
  {
    $screen = $1 if (/^(\S+) connected/);
  }
  elsif (/^\s+Brightness: (\S+)/)
  {
    $screens{$screen} = $1;
    undef $screen;
  }
}
close(XRANDR);

while (($screen, $brightness) = each (%screens))
{
  $callbacks{$command} -> ($screen, $brightness);
}
