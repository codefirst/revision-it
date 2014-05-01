class User < ActiveRecord::Base
  devise :omniauthable
  has_many :user_projects
  has_many :projects, -> { order(:owner, :repos) }, through: :user_projects
end
