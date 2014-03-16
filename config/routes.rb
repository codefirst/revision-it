RevisionIt::Application.routes.draw do
  root 'welcome#index'
  match 'dashboard/' => 'dashboard#index', as: 'dashboard', via: ['GET', 'POST']

  # Github
  post "github/import_all" => 'github#import_all', as: 'import'
  post "github/hook"
  get "github/" => 'github#index', as: 'github'

  # Revision
  get 'revisions/' => 'revisions#index', as: 'revisions'
  get 'revisions/:hash' => 'revisions#show', as: 'revision'
  get 'hash/:hash' => 'revisions#via_hash', as: 'hash'
end
