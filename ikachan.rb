#!/usr/bin/env ruby
require 'net/http'
require 'uri'

join_url   = ENV['join_url']
notice_url = ENV['notice_url']
channel    = ENV['channel']
job        = ENV['job']
url        = ENV['url']

http = Net::HTTP.new(URI(join_url).host, URI(join_url).port)
req = Net::HTTP::Post.new(URI(join_url).path)
req.form_data = { 'channel' => channel }
http.request(req)

http = Net::HTTP.new(URI(url).host, URI(url).port)
req = Net::HTTP::Get.new(URI(url).path + 'api/xml')
res = http.request(req)
xml = res.body

result = xml.match(/<result>(.+?)</)[1]
code = case result
       when 'ABORTED'; 8
       when 'SUCCESS'; 3
       when 'FAILURE'; 4
       else          ; nil
       end
result = if code.nil?
           result
         else
           "\x02\x0301,%02d%s\x0f" % [code, result]
         end

message = "Jenkins (%s): %s - %s" % [job, result, url]
http = Net::HTTP.new(URI(notice_url).host, URI(notice_url).port)
req = Net::HTTP::Post.new(URI(notice_url).path)
req.form_data = { 'channel' => channel, 'message' => message }
http.request(req)
