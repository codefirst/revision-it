module ErrorHandle
  def error(text, status)
    respond_to do |format|
      format.html { render text: text, status: status }
      format.json { render json: { status: 'error', reason: text }}
    end
    nil
  end
end
