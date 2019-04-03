#!/usr/bin/perl --

#use strict;
use LWP::UserAgent;
use HTTP::Request::Common;
use Jcode;
#use DBI;

# 1332: 日本水産
# 1928: 積水ハウス
# 1802: 大林組
# 2371: カカクコム
# 3333: あさひ
# 3402: 東レ
# 3655: ブレインパット
# 3197: すかいらーく
# 4185: JSR
# 6047: Gunosy
# 6857: アドバンテスト
# 7205: 日野自動車
# 7419: ノジマ
# 7867: タカラトミー
# 8337: 千葉興銀
# 8411: みずほ
# 8934: サンフロンティア
# 9613: NTTデータ

my $stock_num="6047";
my $stock_year="2018";

# POST準備
my $url = "https://kabuoji3.com/stock/$stock_num/$stock_year/";
#my $url = "https://kabuoji3.com/stock/$stock_num/";  #直近300日

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
#$res =~ s/,(\s+)(\d+)-(\d+)-(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+)/$2-$3-$4,$6,$8,$10,$12,$14,$16/g;
$res =~ s/,(\s+)(\d+)-(\d+)-(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+),(\s+)(\d+), */$2-$3-$4,$6,$8,$10,$12,$14,$16/g;

$res =~ s/\<.*\>//g;
$res =~ s/HTTP.*//g;
$res =~ s/^\n//g;

print $res; ### TEST

#open (OUT, ">> //mnt/nas/h-iwai/script/$stock_num.csv") or die("error :$!");
open (OUT, "> //mnt/nas/h-iwai/script/$stock_num.csv") or die("error :$!");

print OUT "$res";

close OUT;
