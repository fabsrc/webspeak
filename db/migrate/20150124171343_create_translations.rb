class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :word_id
      t.integer :translation_id
    end
  end
end
