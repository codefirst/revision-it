class AddProjectToRevisions < ActiveRecord::Migration
  def change
    add_column    :revisions, :project_id, :integer
    remove_column :revisions, :project
  end
end
