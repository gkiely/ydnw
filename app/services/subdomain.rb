class Subdomain
  def initialize
    @users = User.all
  end

  def matches?(request)
    byebug
    if request.subdomain.present? && request.subdomain != 'www'
      @users.find(request.subdomain)
    end
  end
end
