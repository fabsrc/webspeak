class Word < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  searchkick autocomplete: ['title']
  
  scope :ordered, -> { order('lower(title)').all }
  
  validates_presence_of [:title, :body, :slug]
  validates_length_of :body, :minimum => 20
  validates_uniqueness_of [:title, :slug], :case_sensitive => false
  
  def normalize_friendly_id(string)
    string.gsub("\s", "_")
  end
  
  def should_generate_new_friendly_id?
    title_changed?
  end
end
