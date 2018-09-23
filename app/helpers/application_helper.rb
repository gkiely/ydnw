module ApplicationHelper
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

  def set_meta_tags_for_post(post)
    set_meta_tags(
      title: post.title,
      description: post.title,
      og: {
        title: post.title,
        description: post.title,
        url: "https://www.youdontneedwp.com/#{post.user.username}/#{post.id}",
        type: "article"
      },
      article: {
        published_time: post.published&.to_time&.iso8601,
        modified_time: post.published&.to_time&.iso8601,
        author: post.user.name
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
        url: "https://www.youdontneedwp.com/#{post.user.username}"
      }
    )
  end
end
