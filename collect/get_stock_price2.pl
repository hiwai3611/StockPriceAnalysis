#!/usr/bin/perl --

#use strict;
use LWP::UserAgent;
use HTTP::Request::Common;
use Jcode;
#use DBI;

#my $stock_num="9697";
our $stock_year="2018";
our $stock_num="";
our $line = "";

open(DATAFILE, "< stock_list") or die("error :$!");

while ( $line = <DATAFILE>){
#	print "$line";

	chomp($line);
	$stock_num = $line;
	sleep(3);
	&GET_DATA;

}

sub GET_DATA {
# POST準備

#my $url = "https://kabuoji3.com/stock/$stock_num/$stock_year/";
my $url = "https://kabuoji3.com/stock/$stock_num/";  #直近300日
#print "$url"."\n";	#TEST

# my %postdata = ( 's_date' => "$yesterday", 'e_date' => "$yesterday" ); 
## my %postdata = ( 's_date' => "$two_days_ago", 'e_date' => "$yesterday" ); # ←これだと2日分

#my $request = POST( $url, \%postdata );
my $request = POST( $url);

# 送信
my $ua = LWP::UserAgent -> new;
my $res = $ua -> request( $request ) -> as_string;

  ## utf8 を sjis に変更している
  ## $str= Jcode::convert( $str , "sjis", "utf8" );
  #$res= Jcode::convert( $res , "utf8", "sjis" );

# 取得データのプリント # TEST
#### データのサンプル
#<tbody>
#    <tr>
#    <td>2017-01-04</td>
#    <td>1318</td>
#    <td>1347</td>
#    <td>1312</td>
#    <td>1346</td>
#    <td>963200</td>
#    <td>1346</td>
#    </tr>
#</tbody>

$res =~ s/\<td\>//g;
$res =~ s/\<\/td\>/,/g;
$res =~ s/\<tr\>/,/g;
$res =~ s/\<\/tr\>/,/g;

$res =~ s/\r//g;
$res =~ s/\n//g;
$res =~ s/,\<\/tbody\>(\s*)/\n/g;
$res =~ s/^,(\s*)//g;

#2017-12-22,   901    909,    893,    896,    1338200,    896,
#$res !~ s/,(\s+)(\d+)-(\d+)-(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+)//g;
#$res =~ s/,(\s+)(\d+)-(\d+)-(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s*)/$2-$3-$4,$6,$8,$10,$12,$14,$16/g;

 $res =~ s/,(\s+)(\d+)-(\d+)-(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+), */$2-$3-$4,$6,$8,$10,$12,$14,$16/g;

$res =~ s/\<.*\>//g;
$res =~ s/HTTP.*//g;
$res =~ s/^\n//g;

#print $res; ### TEST

#my $file_name = "$stock_num".".csv";
my $file_name = "$stock_num".".txt";

#open (OUT, ">> //mnt/nas/h-iwai/script/$stock_year/$stock_num") or die("error :$!");

#$stock_yearのfile
#open (OUT, "> /mnt/nas/h-iwai/script/$stock_year/$file_name") or die("error :$!");
#直近の300日
open (OUT, "> /mnt/nas/h-iwai/script/300/$file_name") or die("error :$!");
#open (OUT, "> /trade_simulator/data/$file_name") or die("error :$!");

print OUT "$res";
close OUT;

}

