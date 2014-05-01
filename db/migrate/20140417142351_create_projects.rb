class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :owner
      t.string :repos

      t.timestamps
    end
  end
end
