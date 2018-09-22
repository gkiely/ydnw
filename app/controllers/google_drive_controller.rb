require 'google/apis/drive_v2'

class GoogleDriveController < ApplicationController
  def authorize
    client = OAuth2::Client.new(
               ENV['GOOGLE_CLIENT_ID'],
               ENV['GOOGLE_CLIENT_SECRET'],
               site: 'https://accounts.google.com',
               authorize_url: '/o/oauth2/auth'
             )
    redirect_to client.auth_code.authorize_url(:redirect_uri => callback_url, :scope => 'https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/drive.file https://www.googleapis.com/auth/drive.appdata https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/drive.photos.readonly', :access_type => 'offline')
  end

  def callback
    user = current_user

    client = OAuth2::Client.new(
              ENV['GOOGLE_CLIENT_ID'],
              ENV['GOOGLE_CLIENT_SECRET'],
              :site => 'https://accounts.google.com',
              :response_type => 'code',
              :token_url => '/o/oauth2/token',
              :access_type => 'offline'
            )

    byebug

    token = client.auth_code.get_token(params[:code], :redirect_uri => callback_url)

    user.update!(
      google_auth_token: token.token,
      google_refresh_token: token.refresh_token,
      google_expires_at: Time.now + token.expires_in.to_i.seconds
    )

    create_folder_in_google_drive! if user.folder.nil?

    redirect_to dashboard_path
  end

  def create_folder_in_google_drive!
    drive = ::Google::Apis::DriveV2::DriveService.new
    drive.authorization = current_user.google_auth_token

    resp = drive.insert_file({title: 'you_dont_need_wp', mime_type: 'application/vnd.google-apps.folder'}, fields: 'id')
    current_user.update!(folder: resp.id)
  end
end
