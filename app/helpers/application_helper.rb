module ApplicationHelper
  def customized_emoji(user)
    user.favicon.present? ? user.favicon : "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/240/apple/155/writing-hand_270d.png"
  end

  def editable?(user)
    current_user && current_user == user
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

  def set_meta_tags_for_post(post, description, img)
    set_meta_tags(
      title: post.title,
      description: description,
      og: {
        title: post.title,
        description: post.title,
        url: "https://www.youdontneedwp.com/#{post.user.username}/#{post.id}",
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
    set_meta_tags(
      title: "#{user.name} - You Don't Need WordPress",
      description: "Check out posts by #{user.name}",
      og: {
        title: "#{user.name} - You Don't Need WordPress",
        description: "Check out posts by #{user.name}",
        url: "https://www.youdontneedwp.com/#{user.username}"
      }
    )
  end
end
