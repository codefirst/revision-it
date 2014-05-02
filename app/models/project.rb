class Project < ActiveRecord::Base
  has_many :user_projects
  has_many :users, -> { uniq }, through: :user_projects
  has_many :revisions, -> { order(date: :desc) }
  def display_name
    "#{owner}/#{repos}"
  end
end
