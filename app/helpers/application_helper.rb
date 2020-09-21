module ApplicationHelper
  def avatar_url user
    puts "Image Here"
  # return user.image if user.image
  # gravatar_id = Digest::MD5::hexdigest(user.email).downcase
  "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
  end
end
