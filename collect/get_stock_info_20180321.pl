#!/usr/bin/perl --

#use strict;
use LWP::UserAgent;
use HTTP::Request::Common;
use Jcode;
#use DBI;
use Net::SMTP;

our @mbodies ="";
our @mbodies2 = "";
our @mbodies3 = "";
our @mbodies4 = "";
our @mbodies5 = "";
our @mbodies6 = "";
our @mbodies7 = "";

&GET_KYOFU;
&GET_NESAGARI;
&GET_KAIRI;
&GET_STOP_PRICE;
&GET_MACD_BUY_SIGNAL;
&GET_MACD_BUY_SIGNAL2;
&GET_NIKKEI_YOSOKU;

&SEND_MAIL;
&LOG_WRITE;

sub GET_NIKKEI_YOSOKU {
# POST準備
my $url7 = "https://nikkeiyosoku.com/";

#my $request = POST( $url, \%postdata );
my $request7 = POST( $url7);

# 送信
my $ua7 = LWP::UserAgent -> new;
my $res7 = $ua7 -> request( $request7 ) -> as_string;

  ## utf8 を sjis に変更している
  ## $str= Jcode::convert( $str , "sjis", "utf8" );
  #$res= Jcode::convert( $res , "utf8", "sjis" );


# 取得データのプリント # TEST
$res7 =~ s/,//g; #"
$res7 =~ s/\<dt\>今日の日経平均予想\<span\>\<a href=\"\/\w+\/\">(\d+月\d+日)\<\/a\>.*\n/今日の日経平均予想:$1,/g; #"
$res7 =~ s/\<a href=\"\/correlations\/\?from-top\"\>\<dd class=\"\w*\"\>(\d*\.*\d*)/$1, /g; #"
$res7 =~ s/\<p class=\"\w*_\w*\s*\w*\"\>//g; #"
$res7 =~ s/\<\/p\>\<\/dd\>\<\/a\>//g; #"

$res7 =~ s/\<p\>日経平均 現在値\<span id=\"\w*_\w*_\w*\"\>(\d*日\s*\d*:\d*).*\n/日経平均 現在値: $1,/g; #"
$res7 =~ s/\<div id=\"\w*_\w*_\w*\"\s*class=\"\w*_\w*_\w*\"\s*data-latest=\"\d*\.\d*\"\>(\d*\.\d*)\<!--\d*\.\d*--\>\<span class=\"\w*\"\>/$1, /g; #"
$res7 =~ s/\<\/span\>\<!--\<span class=\"\w*\"\>([+-]\d*.\d*.*)\<\/div\>/$1/g; #"

#    <h4>NYダウ平均<span>（08日 06:30）</span></h4>
#    <div class="market_chart_wrap">
#    <ul class="number_box">
#    <li id="dow_val">24,893.35</li>
#    <li id="dow_diff" class="fall">-19.42</li>
#    <li id="dow_diff_ratio" class="fall">(-0.08%)</li>
#    </ul>

$res7 =~ s/\<h4\>NYダウ平均\<span\>（(\d*日\s*\d*:\d*)）\<\/span\>\<\/h4\>/NYダウ平均: $1, /g; #"
$res7 =~ s/\<li id=\"\w*_\w*"\>(\d*\.\d*)\<\/li\>/$1, /g; #"
$res7 =~ s/\<li id=\"\w*_\w*"\s*class=\"\w*\"\>([+-]\d*.\d*)\<\/li\>/$1, /g; #"
$res7 =~ s/\<h4\>CME日経平均先物\<span\>.*/CME日経平均先物/g; #"
$res7 =~ s/\<li class=\"clickbox\"\>\<a href=\"\/\w*\/\"\>//g; #"
$res7 =~ s/\<span\>/, /g; #"
$res7 =~ s/\<span class=\"\w*">/, /g; #"
$res7 =~ s/\<\/span\>\<\/a\>\<\/li\>/, /g; #"

$res7 =~ s/\s*//g;
$res7 =~ s/\<\/p\>\<dl\>/\n/g; #"
$res7 =~ s/\<divclass=\"ave_index_wrap\"\>/\n/g; #" 
$res7 =~ s/\<ulclass=\"number_box_type\"\>/\n/g; #"
$res7 =~ s/\<ul\>/\n/g;
$res7 =~ s/\<ahref=\"\/forecast\/daily\"\>/\n/g; #"
$res7 =~ s/<.*>//g; #"

$res7 =~ s/HTTP.*//g; #"
$res7 =~ s/(\s*)毎日7時20分更新//g; #"
$res7 =~ s/\n\n//g; #"
$res7 =~ s/^\n//g; #"

#print "$res7\n";

push(@mbodies7, $res7);
}

sub GET_MACD_BUY_SIGNAL2 {
# POST準備
my $url6 = "http://kabusensor.com/signal/kai/?t_cd=10&s_cd=1";

#my $request = POST( $url, \%postdata );
my $request6 = POST( $url6);

# 送信
my $ua6 = LWP::UserAgent -> new;
my $res6 = $ua6 -> request( $request6 ) -> as_string;

  ## utf8 を sjis に変更している
  ## $str= Jcode::convert( $str , "sjis", "utf8" );
  #$res= Jcode::convert( $res , "utf8", "sjis" );

# 取得データのプリント # TEST
$res6 =~ s/\<span class=\"fs18 fcolor_sd_red1\"\>6//g; #"
$res6 =~ s/\<\/span\>//g; #"
$res6 =~ s/\<div class=\"sgcnt under\d+\">//g; #"
$res6 =~ s/\<ul class=\"mtop\d+ mbtm\d* inline fs\d*\">//g; #"
$res6 =~ s/\<a href=\"#cancel\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"//g; #"
$res6 =~ s/\<\/a\>\<\/h3\>\<\/div\>/,/g; #"
$res6 =~ s/\<\/div\>\n\<\/div\>/,/g; #"
$res6 =~ s/\<div class=\"brnm brnm\d+\"\>\<h3\>\<a href=\"\/brand\/\?code=\d+\"\>//g; #"
$res6 =~ s/\<\/li\>\n\<li class=\"tooltip-demo a\d*\"\>//g; #"
$res6 =~ s/\<span class=\"fs18 fcolor_sd_red1\"\>//g; #"
$res6 =~ s/\<\/a\>//g; #"
$res6 =~ s/\<li>//g; #"
$res6 =~ s/\n//g;
$res6 =~ s/\<\/li\>\<\/ul\>\<\/div\>//g;
$res6 =~ s/\"\>買いシグナル\d*件/\n\n/g; #"
$res6 =~ s/\<div class=\"linh\d*\"\>/\n/g; #"
$res6 =~ s/HTTP.*//g;
$res6 =~ s/\<.*\>//g; #"
$res6 =~ s/\<div class=\"mnhd mbtm\d*//g; #"
$res6 =~ s/数TOP\d*\(\d*\/\d*\)//g; #"
$res6 =~ s/\n\n/\n/g;

push(@mbodies6, $res6);
}

sub GET_MACD_BUY_SIGNAL {
# POST準備
my $url5 = "https://kabutan.jp/tansaku/?mode=2_0440";

#my $request = POST( $url, \%postdata );
my $request5 = POST( $url5);

# 送信
my $ua5 = LWP::UserAgent -> new;
my $res5 = $ua5 -> request( $request5 ) -> as_string;

  ## utf8 を sjis に変更している
  ## $str= Jcode::convert( $str , "sjis", "utf8" );
  #$res= Jcode::convert( $res , "utf8", "sjis" );

# 取得データのプリント # TEST
$res5 =~ s/,//g; #"
$res5 =~ s/\<\/a\>\<\/td\>/,/g; #"
$res5 =~ s/\<\/span\>\<\/td\>/,/g; #"
$res5 =~ s/\<\/td\>/,/g; #"
$res5 =~ s/\<td width=\"\d*\">\<a href=\"\/stock\/\?code=\d*\">\<img src=\"\/images\/cmn\/gaiyou_icon\.jpg\" width=\"\d*\" height=\"\d*\" \/\>,//g; #"
$res5 =~ s/\<td width=\"\d*\">\<a href=\"\/stock\/chart\?code=\d*&ashi=\d*&tech=\d*_\d*_\d*\"\>\<img src=\"\/images\/cmn\/chart_icon\.jpg\"  width=\"\d*\" height=\"\d*\" \/\>,//g; #"

$res5 =~ s/\<td\>\<span class=\"\w*\">//g; #"
$res5 =~ s/\<td\>//g; #"
$res5 =~ s/\<td class=\"\w*\"\>//g; #"
$res5 =~ s/\n//g;
$res5 =~ s/,\<\/tr\>/\n/g;
$res5 =~ s/HTTP.*//g;
$res5 =~ s/\<.*\>//g; #"
$res5 =~ s/足//g;
$res5 =~ s/\n\n//g;

push(@mbodies5, $res5);
}

sub GET_STOP_PRICE {
# POST準備
#my $url3 = "https://kabuoji3.com/stock/$stock_num/$stock_year/";
my $url4 = "http://www.traders.co.jp/domestic_stocks/domestic_market/stop_price/stop_price.asp";

#my $request = POST( $url, \%postdata );
my $request4 = POST( $url4);

# 送信
my $ua4 = LWP::UserAgent -> new;
my $res4 = $ua4 -> request( $request4 ) -> as_string;

  ## utf8 を sjis に変更している
  #$res4= Jcode::convert( $res4 , "sjis", "utf8" );
  $res4= Jcode::convert( $res4 , "utf8", "sjis" );

# 取得データのプリント # TEST
$res4 =~ s/\<td width=\"\d+\" align=\"center\" bgcolor=\"#DBE7FC\" nowrap\> \<font size=\"\d+\" color=\"#444444\"\>\<b\>//g; #"
$res4 =~ s/,//g;
$res4 =~ s/\<\/a\>\<\/font\>/,/g; #"
$res4 =~ s/\<\/b\>\<\/font\>/,/g; #"
$res4 =~ s/\<td id=\"hi_market\d+\" width=\"\d+\" align=\"center\"\>\<font size=\"\d+\"\>//g; #"
$res4 =~ s/\<\/font\>\<\/td\>/,/g;
$res4 =~ s/\<td id=\"hi_name\d+\" width=\"\d+\" style=\"padding:\d+px;\" align=\"left\"\>\<font size=\"\d+\">//g; #"
$res4 =~ s/\<td id=\"hi_rate\d+\" width=\"\d+\" align=\"right\"\>\<font size=\"2\"  color=\"#ff0000\"\>//g; #"
$res4 =~ s/\<td id=\"hi_sector\d+\" width=\"\d+\" align=\"center\"\>\<font size=\"\d+\"\>//g; #"
$res4 =~ s/\<td width=\"\d+\" align=\"right\" bgcolor=\"#ffffcc\"\>\<font size=\"\d+\"\>//g; #"
$res4 =~ s/<td id=\"hi_\w+\d+\" width=\"\d+\" align=\"right\"\>\<font size=\"\d+\"\>//g; #"
$res4 =~ s/\r//g;
$res4 =~ s/\n//g;
$res4 =~ s/\s+//g;
$res4 =~ s/\t+//g;
$res4 =~ s/\<a href=\"\/stocks_info\/individual_list_top.asp\?FLG=0&SC=\d+\"//g; #"
$res4 =~ s/\<\/tr\>/\n/g; #"
$res4 =~ s/\<tr\>\<tdid=\"hi_code\d+\"width=\"40\"style=\"padding:2px;\"align=\"center\"><fontsize=\"2\"\>\<ahref=\"\/stocks_info\/individual_list_top\.asp\?FLG=\d+&SC=\d+\">(\d+),\<\/td\>/$1,/g; #"
$res4 =~ s/\<\/td\>//g; #"
$res4 =~ s/HTTP.*//g;

$res4 =~ s/\<tdwidth=\"\d*\"align=\"center\"style=\"\"\><fontsize=\"\d*\">//g; #"
$res4 =~ s/\<tdwidth=\"\d*\"align=\"right\"style=\"\"\>\<fontsize=\"\d*\"color=\"#0000ff\">//g; #"
$res4 =~ s/\<tdwidth=\"\d*\"align=\"right\"style=\"\"\>\<fontsize=\"\d*\">//g;#"
$res4 =~ s/\<tdwidth=\"\d+\"style=\"padding:\d*px;\"align=\"left\">\<fontsize=\"\d*\">//g;#"

$res4 =~ s/\<.*\>//g;
$res4 =~ s/.*\&nbsp;.*//g;
$res4 =~ s/(\s*)トレーダーズ・プレミアムのホームページに記載されている内容の著作権.*//g;
$res4 =~ s/.*ダーズ・ウェブへ.*//g;
$res4 =~ s/\s*//g;
$res4 =~ s/ニュースランキング.*//g;
$res4 =~ s/(\s*)agesexcnttxt(\s*)　--\>--\>//g;
$res4 =~ s/(\s*)ストップ高安銘柄一覧//g;
$res4 =~ s/ストップ高銘柄,/\nストップ高銘柄\n/g;
$res4 =~ s/ストップ安銘柄,/\n\nストップ安銘柄\n/g;
$res4 =~ s/コード,市場,銘柄名,業種,終値,前日比,売り残（株）,出来高,/コード,市場,銘柄名,業種,終値,前日比,売り残（株）,出来高\n/g;
$res4 =~ s/コード,市場,銘柄名,業種,終値,前日比,買い残（株）,出来高,/コード,市場,銘柄名,業種,終値,前日比,買い残（株）,出来高\n/g;
$res4 =~ s/,(\d{4}),(\w{1}\d{1}),/\n$1,$2,/g;
$res4 =~ s/,(\d{4}),(\w{1}\w{1}),/\n$1,$2,/g;
$res4 =~ s/^\n//g; #"

push(@mbodies4, $res4);
}

#print"@mbodies4";

sub GET_KYOFU {
# POST準備
#my $url3 = "https://kabuoji3.com/stock/$stock_num/$stock_year/";
my $url3 = "https://moneybox.jp/cfd/detail.php?t=%5EVIX";

#my $request = POST( $url, \%postdata );
my $request3 = POST( $url3);

# 送信
my $ua3 = LWP::UserAgent -> new;
my $res3 = $ua3 -> request( $request3 ) -> as_string;

  ## utf8 を sjis に変更している
  ## $str= Jcode::convert( $str , "sjis", "utf8" );
  #$res= Jcode::convert( $res , "utf8", "sjis" );

# 取得データのプリント # TEST

$res3 =~ s/\<span style=\"font-size:(\d+)px;font-weight:bold;padding-left:(\d+)px;\">//g; #"
$res3 =~ s/\<li class=\"cpny_(\d+)_cfd\"\>//g; #"
$res3 =~ s/<\/li>/,/g;
$res3 =~ s/\<\/span\>/\n/g;
$res3 =~ s/\s+//g;
$res3 =~ s/\t+//g;
$res3 =~ s/\<\/div\>\<\/div\>,\<\/ul\>,\<liclass=\"end\"\>\<ul\>\<li\>\<divclass=\"cpny\"style=\"border-bottom:1pxdotted#cdcdcd;padding-bottom:10px;\"\>\<ulclass=\"clearfix\"\>//g; #"
$res3 =~ s/\r//g;
$res3 =~ s/\n//g;
$res3 =~ s/,\<\/ul\>\<\/div\>,/\n/g;
$res3 =~ s/\<ulclass=\"clearfix\"\>/\n/g; #"
$res3 =~ s/\<.*\>//g;
$res3 =~ s/HTTP.*//g;
$res3 =~ s/(\s*)//g;
$res3 =~ s/恐怖指数\(きょうふしすう、VolatilityIndex略称:VIX\).*//g;
$res3 =~ s/^\s*//g;
$res3 =~ s/^\t*//g;

push(@mbodies3, $res3);
}

sub GET_NESAGARI {
# POST準備
#my $url = "https://kabuoji3.com/stock/$stock_num/$stock_year/";
my $url = "https://kabutan.jp/warning/?mode=2_2";


#my $request = POST( $url, \%postdata );
my $request = POST( $url);

# 送信
my $ua = LWP::UserAgent -> new;
my $res = $ua -> request( $request ) -> as_string;

  ## utf8 を sjis に変更している
  ## $str= Jcode::convert( $str , "sjis", "utf8" );
  #$res= Jcode::convert( $res , "utf8", "sjis" );

# 取得データのプリント # TEST

$res =~ s/\<td\>//g;
$res =~ s/,//g;
$res =~ s/\<\/td\>/,/g;
$res =~ s/\<\/span\>//g;
$res =~ s/\<span class=\"down\"\>//g; #"
$res =~ s/\<\/a\>//g; 
$res =~ s/\<td class=\"tac\"\>\<a href=\"\/stock\/\?code=\d+\">//g; #" 
$res =~ s/\<td class=\"tal\"\>//g; #" 
$res =~ s/\<td class=\"tac\"\>//g; #" 
$res =~ s/\<td width=\"\d+\"\>//g; #" 
$res =~ s/\<tr\>//g;
$res =~ s/\<a href=\"\/stock\/\?code=\d+\"\>.*//g; #"
$res =~ s/\<a href=\"\/stock\/chart\?code=\d+">.*//g; #"
$res =~ s/\n//g;
$res =~ s/\r//g;
$res =~ s/\<\/th\>\<\/tr\>\<\/thead\>/\n/g;
$res =~ s/,\<\/tr\>/\n/g;
$res =~ s/\<td class=\"header_shisuu_atai2\" style=\"border-bottom:none;\">//g; #"
$res =~ s/(\<td class=\"header_shisuu_atai2\" style=\"border-bottom:none;\"\>)*<span class=\"up\">//g; #"
$res =~ s/\<.*\>//g;
$res =~ s/HTTP.*//g;
$res =~ s/足\n//g;
$res =~ s/\n\n/\n/g;

#print $res; ### TEST

push(@mbodies, $res);
}

sub GET_KAIRI {
# POST準備
my $url2 = "http://www.kabuka.jp.net/individual-ranking.html";

#my $request = POST( $url, \%postdata );
my $request2 = POST( $url2);

# 送信
my $ua2 = LWP::UserAgent -> new;
my $res2 = $ua2 -> request( $request2 ) -> as_string;

  ## utf8 を sjis に変更している
  ## $str= Jcode::convert( $str , "sjis", "utf8" );
  #$res= Jcode::convert( $res , "utf8", "sjis" );

# 取得データのプリント # TEST

$res2 =~ s/\<td class=\"secondrow\" style=\"width:(\d+)%;\">//g; #"
$res2 =~ s/\<td class=\"secondrow\" style=\"width:(\d+)%; padding-left:(\d+)px; padding-right:(\d*)px;\"\>\<a href=\"\/rating\/(\d+)\.html\"\>//g; #" 
$res2 =~ s/\<td class=\"secondrow\" style=\"width:(\d+)%; (padding-left:(\d*)px;)*\"\>//g; #"
$res2 =~ s/\<td class=\"secondrow\" style=\"width:(\d+)%; padding-left:10px; color:red; white-space:nowrap;\">//g; #"
$res2 =~ s/,//g; #"
$res2 =~ s/\<\/a\>\<\/td\>/,/g; #"
$res2 =~ s/\<\/td\>/,/g; #"
$res2 =~ s/\r//g;
$res2 =~ s/\n//g;
$res2 =~ s/(\s*)//g;
$res2 =~ s/(\t*)//g;
$res2 =~ s/\<\/tr\>\<\/tr\>\<tr\>/\n/g;
$res2 =~ s/\<tr\>\<tr\>/\n/g;
$res2 =~ s/\<.*\>//g;
$res2 =~ s/HTTP.*//g;

push(@mbodies2, $res2);

}

print @mbodies; ### TEST
print @mbodies2; ### TEST
print @mbodies3; ### TEST
print @mbodies4; ### TEST
print @mbodies5; ### TEST
print @mbodies6; ### TEST

sub LOG_WRITE{

($ss, $mn, $hh, $dd, $mm, $yy) = localtime(time);
  $yy += 1900;
  $mm++;
  #$dttm = sprintf("%04d%02d%02d-%02d%02d", $yy, $mm, $dd, $hh, $mn);
  $dttm = sprintf("%04d%02d%02d", $yy, $mm, $dd);

my $log_name = "$dttm"."_stock_info.log";
open (OUT, ">> /mnt/nas/h-iwai/script/log/$log_name") or die("error :$!");

print OUT "@mbodies7\n";

print OUT "【(1) VIX恐怖指数】\n";
print OUT "@mbodies3\n";

print OUT "【(2)ストップ高安銘柄】\n";
print OUT "@mbodies4\n";

print OUT "【(3)(3)MACD 買いシグナル】\n";
print OUT "[株センサー]\n";
print OUT "@mbodies6\n";
print OUT "[(株探)コード,銘柄名,市場,株価,前日比,出来高,MACD,PER,PBR,利回り]\n";
print OUT "@mbodies5\n";

print OUT "【(4)株価下落率】\n";
print OUT "[日経平均, 米ドル円, NYダウ, 上海総合]\n";
print OUT "[コード, 銘柄名, 市場, 株価, 前日比, 出来高, ＰＥＲ, ＰＢＲ, 利回り]\n";
print OUT "@mbodies\n";

print OUT "【(5)株価乖離率】\n";
print OUT "[銘柄, 証券会社, 目標株価, 直近の終値, 乖離率]\n";
print OUT "@mbodies2\n";

close OUT;

}

sub SEND_MAIL {

($ss, $mn, $hh, $dd, $mm, $yy) = localtime(time);
  $yy += 1900;
  $mm++;
  #$dttm = sprintf("%04d%02d%02d-%02d%02d", $yy, $mm, $dd, $hh, $mn);
  $dttm = sprintf("%04d%02d%02d", $yy, $mm, $dd);

#my $server = '74.125.81.109';
my $server = 'smtp2.tbz.t-com.ne.jp';
my $debug = 0;
my $timeout = 5;

#my $sender = 'sj190284-6587@tbz.t-com.ne.jp';
my $sender = 'sj190284-6587@tbz.t-com.ne.jp';
my $to = 'h-iwai0723@i.softbank.jp';

my $smtp = Net::SMTP->new(
        $server,
        Debug => $debug,
        Timeout => $timeout) or die $@;

$smtp->mail($sender);
$smtp->to($to);
$smtp->data();

my $subject = get_subject();
&Jcode::convert(\$subject,'jis');
$subject = jcode($subject)->mime_encode;

my $header = get_header($sender, $to, $subject);

my $body = get_body();
$smtp->datasend($header);
$smtp->datasend("\n");
$smtp->datasend($body);
$smtp->quit;
  ###exit;
sub get_body {
  my $body = <<EOD;
  @mbodies7
【(1) VIX恐怖指数】
@mbodies3

【(2)ストップ高安銘柄】
@mbodies4

【(3)MACD 買いシグナル】
[株センサー]
@mbodies6

[(株探)コード,銘柄名,市場,株価,前日比,出来高,MACD,PER,PBR,利回り]
@mbodies5

【(4)株価下落率】
[日経平均, 米ドル円, NYダウ, 上海総合]
[コード, 銘柄名, 市場, 株価, 前日比, 出来高, ＰＥＲ, ＰＢＲ, 利回り]
@mbodies

【(5)株価乖離率】
[銘柄, 証券会社, 目標株価, 直近の終値, 乖離率]
@mbodies2

EOD
return $body;
}
sub get_subject {
        my $subject = <<EOD;
$dttm-本日の株価情報
EOD
        return $subject;
}
sub get_header {
        my $from = shift;
        my $to = shift;
        my $subject = shift;
        my $header =<<EOD;
From: $from
To: $to
Subject: $subject
EOD
        return $header;
 }
}