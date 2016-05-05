class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
    	t.references :group, index: true
    	t.references :groupable, polymorphic: true, index: true
    	t.timestamps null: false
    end
    add_foreign_key :groupings, :groups
  end
end
