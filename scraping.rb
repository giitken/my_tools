require 'nokogiri'
require 'open-uri'
require 'csv'

url = 'https://cookpad.com/recipe/521403'

charset = nil

html = open(url) do |f|
  charset = f.charset
  f.read
end
ary = []
doc = Nokogiri::HTML.parse(html, nil, charset)
doc.xpath("//div[@class='ingredient_name']").each do |node|
  ary << [node.inner_text.chomp]
end
doc.xpath("//div[@class='ingredient_quantity amount']").each_with_index do |node,idx|
  ary[idx] << node.inner_text
end
ary.map{|a| puts a.join(":")}.sort
