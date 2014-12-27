class AddLanguageToWord < ActiveRecord::Migration
  def change
    add_reference :words, :language, index: true
  end
end
