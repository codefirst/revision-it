class RevisionsController < ApplicationController
  include ErrorHandle
  skip_before_action :authenticate_user!, only: [:show, :via_hash]

  # GET /revisions
  # GET /revisions.json
  def index
    @revisions = Revision.order(date: :desc)
  end

  def show
    if params[:hash].size < 4 then
      error 'ambiguous hash', 400
    else
      @revision = Revision.from_hash(params[:hash])
    end
  end

  def via_hash
    if params[:hash].size < 4 then
      error 'ambiguous hash', 400
    else
      @revision = Revision.from_hash(params[:hash])
      if @revision then
        respond_to do |format|
          format.html { render 'embed', layout: false }
          format.json { render json: { status: 'ok', revision: @revision } }
        end
      else
        error 'No such revision', 404
      end
    end
  end
end
