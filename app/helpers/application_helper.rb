module ApplicationHelper
  def customized_emoji(user)
    user.favicon.present? ? user.favicon : "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/apple/155/writing-hand_270d.png"
  end

  def post_pathy(post)
    custom_domain? ? "/#{post.slug}" : "/#{post.user.username}/#{post.slug}"
  end

  def editable?(user)
    current_user && current_user == user
  end

  def custom_domain?
    request.host.present? && request.host != "localhost" && request.host != "youdontneedwp.com" && request.host != "www.youdontneedwp.com"
  end

  def set_home_meta_tags
    set_meta_tags(
      title: "You Don't Need WordPress: Create A Blog With Google Docs",
      description: "You Don't Need WordPress: Create A Blog With Google Docs",
      og: {
        title: "You Don't Need WordPress: Create A Blog With Google Docs",
        description: "You Don't Need WordPress: Create A Blog With Google Docs",
        url: "https://www.youdontneedwordpress.com"
      }
    )
  end

  def set_meta_tags_for_post(post, description)
    img = post.meta&.url
    url = custom_domain? ? "https://#{request.host}/#{post.id}" : "https://www.youdontneedwp.com/#{post.user.username}/#{post.id}"

    set_meta_tags(
      title: post.title,
      description: description,
      og: {
        title: post.title,
        description: post.title,
        url: url,
        type: "article",
        image: [{ _: img}]
      },
      article: {
        published_time: post.published&.to_time&.iso8601,
        modified_time: post.published&.to_time&.iso8601,
        author: post.user.name
      },
      twitter: {
        card: "summary_large_image",
        site: post.user.twitter,
        title: post.title,
        description: description.strip,
        creator: post.user.twitter,
        image: [{ _: img}]
      }
    )
  end

  def set_meta_tags_for_index(user)
    title = custom_domain? ? "#{user.name}" : "#{user.name} - You Don't Need WordPress"
    description = user.bio.present? ? user.bio : "Check out posts by #{user.name}"
    url = custom_domain? ? "https://#{request.host}" : "https://www.youdontneedwp.com/#{user.username}"

    set_meta_tags(
      title: title,
      description: description,
      og: {
        title: title,
        description: description,
        url: url
      }
    )
  end
end
