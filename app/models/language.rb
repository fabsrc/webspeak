class Language < ActiveRecord::Base
  has_many :words

  validates_presence_of :name, :code
  validates_uniqueness_of :name, :code, :case_sensitive => false
  validates_length_of :code, :is => 2

  def code=(new_code)
    write_attribute(:code, new_code.upcase)
  end
end
