class Word < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  searchkick autocomplete: ['title']
  has_paper_trail

  validates_presence_of :title, :body, :slug, :language
  validates_length_of :body, :minimum => 20
  validates_uniqueness_of :title, :slug, :case_sensitive => false

  has_and_belongs_to_many :translations,
    class_name: "Word",
    join_table: "word_translations",
    foreign_key: "word_id",
    association_foreign_key: "translation_id"
  # has_and_belongs_to_many :translation_of,
  #   class_name: "Word",
  #   join_table: "word_translations",
  #   foreign_key: "translation_id",
  #   association_foreign_key: "word_id"
  belongs_to :language

  scope :ordered, -> { order('lower(title)') }
  scope :language, ->(lang) { where(language: Language.find_by_code(lang.upcase)) }

  def normalize_friendly_id(string)
    string.gsub("\s", "_")
  end

  def should_generate_new_friendly_id?
    title_changed?
  end
end