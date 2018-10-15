User.where(username: "Gumil_ev").first&.update(username: "Gumilev1")

User.all.each do |user|
  puts "updating #{user.username} to #{user.username.gsub(/[^0-9a-z]/i, "")}"
  new_username = user.username.gsub(/[^0-9a-z]/i, "")

  if new_username.blank?
    user.update!(username: user.email.split("@").first.gsub(/[^0-9a-z]/i, ""))
  else
    user.update!(username: new_username)
  end
end
