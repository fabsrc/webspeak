class Language < ActiveRecord::Base
  has_many :words

  before_save :upcase_code

  validates :name, :code, presence: true
  validates :name, :code, uniqueness: { case_sensitive: true }
  validates :code, length: { is: 2 }

  def upcase_code
    code.upcase!
  end

  private :upcase_code
end
