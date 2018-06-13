#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'json'

def download_page(username, i)
  url = "https://www.discogs.com/wantlist?sort=artist&sort_order=asc&limit=250&page=#{i}&user=#{username}"

  file = open(url)

  File.read(file)
end

def process_page(page)
  html = Nokogiri::HTML page

  tables = html.css('table.release_list_table')
  rows = tables.css('tr')

  results = []
  rows.shift
  rows.each do |row|
    columns = row.css('td')
    one = columns[2].css('a')

    results.push(band: one[0].text, album: one[1].text, format: columns[3].text)
  end

  results
end

if ARGV.length != 1
  puts '[usage] bundle exec discogs.rb USERNAME'
  exit
end

username = ARGV[0]
puts "downloading discography want list for user #{username}"

results = []
print "Page "

i = 1
loop do
  print i, "  "
  $stdout.flush

  page = download_page username, i

  page_results = process_page page
  results += page_results

  if page_results.length < 250
    puts
    break
  end

  # be kind to their server
  sleep 30

  i += 1
end

File.open("#{username}.json", 'w') { |f| f.write results.to_json.to_s }
