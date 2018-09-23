require 'google/apis/drive_v2'
require 'net/http'

class GoogleDrive
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create_file!
    drive = Google::Apis::DriveV2::DriveService.new
    drive.authorization = get_auth_token

    metadata_fields = {
      title: 'My new blog post',
      mime_type: 'application/vnd.google-apps.document',
      parents: [{ id: @user.folder }]
    }

    metadata = Google::Apis::DriveV2::File.new(metadata_fields)
    metadata = drive.insert_file(metadata)
  end

  def get_html(post)
    # html_from_file = RestClient.get("https://www.googleapis.com/drive/v2/files/#{story.google_doc_id}/export?mimeType=text/html", {:Authorization => "Bearer #{get_auth_token}", :content_type => "application/json" })

    drive = Google::Apis::DriveV2::DriveService.new
    drive.authorization = get_auth_token
    html_string = drive.export_file(post.google_doc, 'text/html')
  end

  private

  def get_auth_token
    return user.google_auth_token unless user.google_expires_at < Time.now
    data = JSON.parse(request_token_from_google.body)
    user.update!(
      google_auth_token: data['access_token'],
      google_expires_at: Time.now + data['expires_in'].to_i.seconds
    )
    user.google_auth_token
  end

  def to_params
    {
      'refresh_token' => user.google_refresh_token,
      'client_id'     => ENV['GOOGLE_CLIENT_ID'],
      'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
      'grant_type'    => 'refresh_token'
    }
  end

  def request_token_from_google
    url = URI("https://accounts.google.com/o/oauth2/token")
    Net::HTTP.post_form(url, to_params)
  end
end
