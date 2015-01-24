class Language < ActiveRecord::Base
  has_many :words

  validates :name, :code, presence: true
  validates :name, :code, uniqueness: { case_sensitive: true }
  validates :code, length: { is: 2 }

  def code=(new_code)
    self[:code] = new_code.upcase
  end
end
