#!/bin/sh

set -x

curl -s -F channel=\\$channel $join_url >/dev/null 2>&1
result=`curl -s ${url}api/xml | perl colorize.pl`
curl -s -F channel=\\$channel -F message="Jenkins ($job): $result - $url $notice_url
