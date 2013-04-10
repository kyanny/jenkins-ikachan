#!/bin/sh

set -x

curl -s -F channel=\\$channel $join_url
result=`curl -s ${build_url}api/xml | perl -le '$_=<>;/<result>(.+?)</;printf "\x02\x0301,%02d%s\x0f",{A=>8,S=>3,F=>4}->{substr $1,0,1},$1'`
curl -s -F channel=\\$channel -F message="Jenkins ($job_name): $result - $build_url $notice_url
