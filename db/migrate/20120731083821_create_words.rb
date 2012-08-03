class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name
      t.string :definition
      t.integer :vset_id
      
      t.timestamps
    end
    
    add_index :words, :vset_id
  end
end
