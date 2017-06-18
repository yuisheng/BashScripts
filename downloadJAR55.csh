#!/bin/csh
#################################################################
# Csh Script to retrieve 210 online Data files of 'ds628.0',
# total 8.58G. This script uses 'wget' to download data.
#
# Highlight this script by Select All, Copy and Paste it into a file;
# make the file executable and run it on command line.
#
# You need pass in your password as a parameter to execute
# this script; or you can set an environment variable RDAPSWD
# if your Operating System supports it.
#
# Contact davestep@ucar.edu (Dave Stepaniak) for further assistance.
#################################################################

set pswd = $1
if(x$pswd == x && `env | grep RDAPSWD` != '') then
 set pswd = $RDAPSWD
endif
if(x$pswd == x) then
 echo
 echo Usage: $0 YourPassword
 echo
 exit 1
endif
set v = `wget -V |grep 'GNU Wget ' | cut -d ' ' -f 3`
set a = `echo $v | cut -d '.' -f 1`
set b = `echo $v | cut -d '.' -f 2`
if(100 * $a + $b > 109) then
 set opt = 'wget --no-check-certificate'
else
 set opt = 'wget'
endif
set opt1 = '-O Authentication.log --save-cookies auth.rda_ucar_edu --post-data'
set opt2 = "email=yuisheng@gmail.com&passwd=$pswd&action=login"
$opt $opt1="$opt2" https://rda.ucar.edu/cgi-bin/login
set opt1 = "-N --load-cookies auth.rda_ucar_edu"
set opt2 = "$opt $opt1 http://rda.ucar.edu/dsrqst/ZHANG246027/"
set filelist = ( \
  fcst_phy2m125.061_tprat.1980010100_1980123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1981010100_1981123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1982010100_1982123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1983010100_1983123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1984010100_1984123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1985010100_1985123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1986010100_1986123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1987010100_1987123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1988010100_1988123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1989010100_1989123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1990010100_1990123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1991010100_1991123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1992010100_1992123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1993010100_1993123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1994010100_1994123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1995010100_1995123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1996010100_1996123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1997010100_1997123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1998010100_1998123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.1999010100_1999123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2000010100_2000123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2001010100_2001123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2002010100_2002123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2003010100_2003123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2004010100_2004123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2005010100_2005123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2006010100_2006123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2007010100_2007123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2008010100_2008123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2009010100_2009123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2010010100_2010123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2011010100_2011123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2012010100_2012123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2013010100_2013123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014010100_2014013121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014020100_2014022821.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014030100_2014033121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014040100_2014043021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014050100_2014053121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014060100_2014063021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014070100_2014073121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014080100_2014083121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014090100_2014093021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014100100_2014103121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014110100_2014113021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2014120100_2014123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015010100_2015013121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015020100_2015022821.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015030100_2015033121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015040100_2015043021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015050100_2015053121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015060100_2015063021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015070100_2015073121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015080100_2015083121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015090100_2015093021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015100100_2015103121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015110100_2015113021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2015120100_2015123121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016010100_2016013121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016020100_2016022921.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016030100_2016033121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016040100_2016043021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016050100_2016053121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016060100_2016063021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016070100_2016073121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016080100_2016083121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016090100_2016093021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016100100_2016103121.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016110100_2016113021.zhang246027.nc.gz \
  fcst_phy2m125.061_tprat.2016120100_2016123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1980010100_1980123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1981010100_1981123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1982010100_1982123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1983010100_1983123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1984010100_1984123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1985010100_1985123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1986010100_1986123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1987010100_1987123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1988010100_1988123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1989010100_1989123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1990010100_1990123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1991010100_1991123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1992010100_1992123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1993010100_1993123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1994010100_1994123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1995010100_1995123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1996010100_1996123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1997010100_1997123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1998010100_1998123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.1999010100_1999123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2000010100_2000123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2001010100_2001123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2002010100_2002123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2003010100_2003123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2004010100_2004123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2005010100_2005123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2006010100_2006123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2007010100_2007123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2008010100_2008123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2009010100_2009123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2010010100_2010123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2011010100_2011123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2012010100_2012123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2013010100_2013123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014010100_2014013121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014020100_2014022821.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014030100_2014033121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014040100_2014043021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014050100_2014053121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014060100_2014063021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014070100_2014073121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014080100_2014083121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014090100_2014093021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014100100_2014103121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014110100_2014113021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2014120100_2014123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015010100_2015013121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015020100_2015022821.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015030100_2015033121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015040100_2015043021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015050100_2015053121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015060100_2015063021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015070100_2015073121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015080100_2015083121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015090100_2015093021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015100100_2015103121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015110100_2015113021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2015120100_2015123121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016010100_2016013121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016020100_2016022921.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016030100_2016033121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016040100_2016043021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016050100_2016053121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016060100_2016063021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016070100_2016073121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016080100_2016083121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016090100_2016093021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016100100_2016103121.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016110100_2016113021.zhang246027.nc.gz \
  fcst_phy2m125.204_dswrf.2016120100_2016123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1980010100_1980123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1981010100_1981123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1982010100_1982123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1983010100_1983123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1984010100_1984123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1985010100_1985123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1986010100_1986123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1987010100_1987123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1988010100_1988123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1989010100_1989123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1990010100_1990123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1991010100_1991123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1992010100_1992123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1993010100_1993123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1994010100_1994123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1995010100_1995123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1996010100_1996123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1997010100_1997123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1998010100_1998123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.1999010100_1999123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2000010100_2000123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2001010100_2001123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2002010100_2002123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2003010100_2003123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2004010100_2004123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2005010100_2005123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2006010100_2006123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2007010100_2007123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2008010100_2008123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2009010100_2009123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2010010100_2010123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2011010100_2011123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2012010100_2012123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2013010100_2013123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014010100_2014013121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014020100_2014022821.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014030100_2014033121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014040100_2014043021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014050100_2014053121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014060100_2014063021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014070100_2014073121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014080100_2014083121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014090100_2014093021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014100100_2014103121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014110100_2014113021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2014120100_2014123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015010100_2015013121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015020100_2015022821.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015030100_2015033121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015040100_2015043021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015050100_2015053121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015060100_2015063021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015070100_2015073121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015080100_2015083121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015090100_2015093021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015100100_2015103121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015110100_2015113021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2015120100_2015123121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016010100_2016013121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016020100_2016022921.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016030100_2016033121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016040100_2016043021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016050100_2016053121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016060100_2016063021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016070100_2016073121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016080100_2016083121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016090100_2016093021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016100100_2016103121.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016110100_2016113021.zhang246027.nc.gz \
  fcst_phy2m125.205_dlwrf.2016120100_2016123121.zhang246027.nc.gz \
)
while($#filelist > 0)
 set syscmd = "$opt2$filelist[1]"
 echo "$syscmd ..."
 $syscmd
 shift filelist
end

rm -f auth.rda_ucar_edu Authentication.log
exit 0