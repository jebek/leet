class CreateVsets < ActiveRecord::Migration
  def change
    create_table :vsets do |t|
      t.string 'title'
      t.string 'description'

      t.timestamps
    end
  end
end
