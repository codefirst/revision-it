class AddSomeFieldsToRevision < ActiveRecord::Migration
  def change
    add_column :revisions, :source, :string
    add_column :revisions, :project,:string
    add_column :revisions, :author, :string
    add_column :revisions, :date, :timestamp
  end
end
