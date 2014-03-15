require 'uri'
require 'github_api'

class GithubController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :hook
  include ErrorHandle
  def index
  end

  def import_all
    import_github params[:url]

    respond_to do|format|
      format.html { redirect_to github_path, notice: 'ok' }
      format.json { render json: { status: 'ok' } }
    end
 end

  def hook
    payload = JSON.parse(params[:payload])
    import_github payload['repository']['url']
    render text: 'ok'
  end

  private
  def import_github(url)
    url = URI.parse url

    raise "not valid url" unless url.host == 'github.com'
    raise "not valid url" unless url.path =~ %r!\A/([^/]*)/([^/]*)!

    user = $1
    repos = $2
    Github.repos.commits.all(user, repos).each do|commit|
      Revision.where(hash_code: commit.sha).first_or_create! do |rev|
        rev.url = commit.html_url
        rev.log = commit.commit.message
      end
    end
  end
end
