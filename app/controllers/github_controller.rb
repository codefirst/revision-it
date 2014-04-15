require 'revision_it/service/github'

class GithubController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :hook
  skip_before_filter :authenticate_user!, only: :hook
  include ErrorHandle
  def index
  end

  def import_all
    import params[:url]
    respond_to do|format|
      format.html { redirect_to github_path, notice: 'ok' }
      format.json { render json: { status: 'ok' } }
    end
  rescue RevisionIt::Service::GithubError => e
    error e.message, 400
  end

  def hook
    payload = JSON.parse(params[:payload]) rescue {}
    url = payload.fetch('repository',{}).fetch('url', '')
    if url.empty? then
      error 'invaild payload', 400
    else
      import url
      render text: 'ok'
    end
  rescue RevisionIt::Service::GithubError => e
    error e.message, 400
  end

  private
  def import(url)
    RevisionIt::Service::Github.commits(url) do|commit|
      rev = Revision.where(hash_code: commit.hash_code).first_or_create!
      rev.update_attributes(commit.to_h)
    end
  end
end
