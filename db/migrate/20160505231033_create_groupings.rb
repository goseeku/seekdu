class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
    	t.references :group, index: true
    	t.references :user, index: true
    	t.timestamps null: false
    end
    
    add_foreign_key :groupings, :groups
    add_foreign_key :groupings, :users
  end
end
