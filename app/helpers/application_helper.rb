module ApplicationHelper
  def link_to_revision(hash, params={})
    link_to hash, params.merge(controller: 'revisions', action: 'show', hash: hash)
  end

  def link_to_url(url)
    link_to url, url
  end
end
