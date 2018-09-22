class Avatar
  def initialize(email)
    @email = email
  end

  def get
    req = RestClient.get("http://picasaweb.google.com/data/entry/api/user/#{@email}?alt=json")

    data = JSON.parse(req)

    data.dig("entry","gphoto$thumbnail","$t")
  end
end
