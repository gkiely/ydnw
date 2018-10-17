# class HtmlParse
#   attr_reader :parsed, :to_parse, :text_of_post, :first_img_path
#
#   def initialize(html)
#     @html = html
#   end
#
#   def parse
#     @parsed = Nokogiri::HTML::DocumentFragment.parse(@html).to_html
#     @to_parse = Nokogiri::HTML(@parsed)
#     @text_of_post = @to_parse.text
#     @first_img_path = @to_parse.xpath('//img')&.first&.attr('src')
#     @parsed
#   end
# end
