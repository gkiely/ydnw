class I::PostsController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    return redirect_to root_path unless @user

    @posts = @user.posts.most_recent_first
  end

  def show
    @user = User.find_by(username: params[:username])
    return redirect_to root_path unless @user

    @post = @user.posts.friendly.find(params[:post_id])
    html = GoogleDrive.new(@user).get_html(@post)
    @parsed = Nokogiri::HTML::DocumentFragment.parse(html).to_html
    to_parse = Nokogiri::HTML(@parsed)
    @parsed = parse_links(to_parse)
    @text_of_post = to_parse.text
    @first_img_path = to_parse.xpath('//img')&.first&.attr('src')
  end

  private

  def parse_links(doc)
    doc.css('a').each do |link|
      link['href'] = strip_google_link(link['href'])
    end
    doc.to_s
  end

  def strip_google_link(href)
    return href if href.nil?
    return href if href.include?("mailto")
    return href if !href.include?('url?q=')

    stripped_link = href.split('url?q=')[1].split('&sa=')[0]
  end
end
