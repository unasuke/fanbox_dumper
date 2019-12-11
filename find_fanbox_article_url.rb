require 'nokogiri'
require 'json'

doc = Nokogiri::HTML(File.read('~/Downloads/pixivfanbox_allpost.html'))
href = []
doc.css('a').each do |elem|
  href << elem['href'] if elem['href'].match?(%r[https://www\.pixiv\.net/fanbox/creator/\d+/post/\d+])
end

File.open('fanbox_posts_list.json', 'w') do |f|
  f.write href.to_json
end
