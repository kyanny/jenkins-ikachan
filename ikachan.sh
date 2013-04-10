#!/bin/sh

set -x

curl -s -F channel=\\$channel $join_url >/dev/null 2>&1
xml=`curl -s ${url}api/xml`
result=`curl -s https://gist.github.com/kyanny/cfe1ba03a72f86a18477/raw/colorize.pl | perl < $xml`
curl -s -F channel=\\$channel -F message="Jenkins ($job): $result - $url $notice_url
