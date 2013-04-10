#!/bin/sh

set -x

curl -s -F channel=\\$channel $join_url >/dev/null 2>&1
result=`curl -s ${url}api/xml | perl -le \'$_=<>;/<result>(.+?)</;printf "\x02\x0301,%02d%s\x0f",{A=>8,S=>3,F=>4}->{substr $1,0,1},$1\'`
curl -s -F channel=\\$channel -F message="Jenkins ($job): $result - $url" $notice_url
