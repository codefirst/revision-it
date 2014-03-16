RevisionIt::Application.routes.draw do
  # Main page
  root 'welcome#index'
  match 'dashboard/' => 'dashboard#index', as: 'dashboard', via: ['GET', 'POST']

  # Revision
  get 'revisions/' => 'revisions#index', as: 'revisions'
  get 'revisions/:hash' => 'revisions#show', as: 'revision'

  # Revision's API
  get 'hash/:hash' => 'revisions#via_hash', as: 'hash'

  # Github
  get  "github/" => 'github#index', as: 'github'
  post "github/import_all" => 'github#import_all', as: 'import'
  post "github/hook"

end
