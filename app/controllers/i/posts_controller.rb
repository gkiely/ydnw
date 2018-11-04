class I::PostsController < ApplicationController
  def index
    redirect_to google_drive_authorize_path if current_user && current_user.google_auth_token.nil?
    @user = User.find_by(username: subdomain_or_param)
    return redirect_to root_path unless @user

    if params[:drafts]
      @posts = @user.posts.draft.most_recent_first
    else
      @posts = @user.posts.published.most_recent_first
    end
  end

  def show
    @user = User.find_by(username: subdomain_or_param)
    return redirect_to root_path unless @user

    @post = @user.posts.friendly.find(params[:post_id])
    html = GoogleDrive.new(@user).get_html(@post)
    @parsed = Nokogiri::HTML::DocumentFragment.parse(html).to_html
    to_parse = Nokogiri::HTML(@parsed)
    @parsed = parse_links(to_parse)
    @text_of_post = helpers.truncate(helpers.strip_tags(to_parse.to_s), length: 290)
    @first_img_path = to_parse.xpath('//img')&.first&.attr('src')
  end

  private

  def subdomain_or_param
    (request.subdomain.present? && request.subdomain != "www") ? User::DOMAIN_MAPPING[request.subdomain] : params[:username]
  end

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
