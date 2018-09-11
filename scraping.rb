require 'nokogiri'
require 'open-uri'
require 'csv'

a = File.open('text.txt')
output = []
loop do
  url = a.gets
  break if url.nil?
  url = url.chomp
  charset = 'utf8'

  html = open(url) do |f|
    charset = f.charset
    f.read
  end
  ary = []
  doc = Nokogiri::HTML.parse(html, nil, charset)
  doc.xpath("//div[@class='ingredient_name']").each do |node|
    ary << [node.inner_text.chomp]
  end
  doc.xpath("//div[@class='ingredient_quantity amount']").each_with_index do | node, idx |
    ary[idx] << node.inner_text
  end
  output << ary.map{|a| a.join(":")}.sort
end

File.open("output.txt", "w") do |f|
  f.puts(output)
end
