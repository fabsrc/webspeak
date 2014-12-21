class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :title
      t.text :body
      t.string :slug

      t.timestamps
    end
    add_index :words, :slug, unique: true
  end
end
