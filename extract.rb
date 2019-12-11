require 'nokogiri'
require 'html2markdown'
require 'md2review'

files = Dir.glob('Downloads/**/*.html')
Dir.mkdir('extracted') unless Dir.exist?('extracted')

render_extensions = {}
render_extensions[:link_in_footnote] = false
parse_extensions = {}
parse_extensions[:tables] = true
parse_extensions[:strikethrough] = true
parse_extensions[:fenced_code_blocks] = true
parse_extensions[:footnotes] = true

review_renderer = MD2ReVIEW::Markdown.new(render_extensions, parse_extensions)

files.each do |file|
  doc = Nokogiri::HTML(File.read(file))
  body = doc.css('article').first.to_xhtml(indent: 2)
  title = doc.css('article h1').first.text.gsub(%r!\s!, '_').delete('編集')
  puts title

  date = %r[(\d{4}-\d{2}-\d{2})].match(title)&.captures&.first
  next unless date

  markdown = HTMLPage.new(contents: body).markdown
  Dir.mkdir("extracted/#{date}") unless Dir.exist?("extracted/#{date}")

  review = review_renderer.render(markdown)

  File.open("extracted/#{date}/#{title}.html", 'w') do |f|
    f.write body
  end

  File.open("extracted/#{date}/#{title}.md", 'w') do |f|
    f.write markdown
  end

  File.open("extracted/#{date}/#{title}.re", 'w') do |f|
    f.write review
  end
end
