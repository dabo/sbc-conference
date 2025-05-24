#!/usr/local/bin/perl

#-------------------------------------------------------------------------
#--	GenProgram.pl - Generate program file from data			--
#--									--
#--	Usage:   perl GenProgram.pl datafile				--
#--									--
#-------------------------------------------------------------------------

use File::Basename;
use POSIX qw(ceil floor);

$StartTime = 9*60;    # Start time = 9am

$datafile   = shift(@ARGV);
($name,$dir,$ext) = fileparse($datafile,'\..*');
$htmlfile = $dir.$name.".html";
$header = "./script/header.php";
$footer = "./script/footer.php";

open(DATA, "$datafile")   || die "Can't open $datafile\n";
open(HEAD, "$header")     || die "Can't open $header";
open(TAIL, "$footer")     || die "Can't open $footer";
open(HTML, ">$htmlfile")  || die "Can't open $htmlfile\n";


print "\n --- Creating file: $htmlfile  \n\n";

$time = $StartTime;
$sessionnum = 0;

#---- Print header file

while (<HEAD>) {
    print HTML;
}
close(HEAD);

#----  Process data file

while(<DATA>) {

    next if (/^%/);	   # Ignore comment lines

    #--------------------------
    if (/<DAY>/i) {
        $day = <DATA>;
        print HTML <<ENDHTML;
<tr><td colspan="2" class="empty"> </td></tr>
<tr>
  <td colspan="2" class="day"> $day </td>
</tr>

ENDHTML

        $time = $StartTime;
        next;
    }

    #----------------------------
    if (/<SESSION>/i) {
        $sessionnum ++;
        $title    = <DATA>;
        $chair    = <DATA>;

        print HTML <<ENDHTML;
<tr>
  <td colspan="2" class="session"> 
      Session $sessionnum: &nbsp; $title 
      <span class="chair">session chair: $chair</span>
  </td>
</tr>

ENDHTML

	next;
    }

    #----------------------------
    if (/<LECTURE>/i) {
        $duration = <DATA>;
        $title    = <DATA>;
        $authors  = <DATA>;
        $speaker  = "";
        $url      = <DATA>;   $url =~ s/\s+$//;

	$timestr = &GetTimeStr($time, $duration);
        $time += $duration;

        print HTML <<ENDHTML;
<tr>
  <td class="time"> $timestr </td>
  <td class="lecture">
    <div class="lectitle">
      $title  
ENDHTML

	if (!($url =~ /NOURL/i)) { 
	    print HTML "      <span class=\"slides\">[<a href=\"$url\" target=\"_blank\">video</a>]</span> &nbsp;\n";
	}
	    
        print HTML <<ENDHTML;
    </div>
    <div class="authors"> 
      $authors    </div>
ENDHTML

	if (!($speaker =~ /^\s*$/)) {
	    print HTML <<ENDHTML;
    <div class="lecturer"> 
      Speaker: $speaker    </div>
ENDHTML
	}

	print HTML <<ENDHTML;
  </td>
</tr>

ENDHTML

	next;
    }

    #----------------------------
    if (/<BREAK>/i) {
        $duration = <DATA>;
        $title    = <DATA>;

	$timestr = &GetTimeStr($time, $duration);
        $time += $duration;

        print HTML <<ENDHTML;
<tr class="break">
  <td class="time"> $timestr </td>
  <td class="lecture"> <div class="lectitle"> $title </div> </td>
</tr>

ENDHTML

	next;
    }

    #----------------------------
    if (/<END>/i) {
	last;
    }
}

#---- Print footer file

while (<TAIL>) {
    print HTML;
}
close(TAIL);

close (HTML);

print "\n ---  $htmlfile  created.\n";

exit;


#------------------------------------------------------

sub GetTimeStr {
    my ($time, $duration) = @_;

    my $sufix = "am";
    if ($time >= 12*60) {$sufix = "pm"};
    if ($time >= 13*60) {$time -= 12*60};

    my $endtime = $time+$duration;

    my $timemin = $time % 60;
    if ($timemin < 10) {$timemin = "0".$timemin};

    my $endmin  = $endtime % 60;
    if ($endmin < 10) {$endmin = "0".$endmin};

    if ($duration > 0) {
      return floor(($time / 60)) . ":" . $timemin . $sufix;
#	         floor(($endtime / 60)) . ":" . $endmin;
    }
    else {
      return floor(($time / 60)) . ":" . $timemin . $sufix;
    }
}

