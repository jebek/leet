class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :word_id
      t.integer :user_id
      t.integer :correct
      t.integer :total
      t.integer :score

      t.timestamps
    end
    
    add_index :results, :word_id
    add_index :results, :user_id
    add_index :results, [:word_id, :user_id], unique: true
  end
end
