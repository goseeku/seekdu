class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :group, index: true
      t.references :user, index: true

      t.timestamps null: false
    end

    add_foreign_key :projects, :users
    add_foreign_key :projects, :groups
  end
end
