class Language < ActiveRecord::Base
  has_many :word
  
  validates_presence_of [:name, :code]
  validates_uniqueness_of [:name, :code], :case_sensitive => false
  validates_length_of :code, :is => 2
  
  def code=(s)
    super s.upcase
  end
end
