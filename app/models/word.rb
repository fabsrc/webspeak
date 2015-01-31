class Word < ActiveRecord::Base
  acts_as_taggable

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  searchkick autocomplete: [:title]
  has_paper_trail on: [:update, :destroy]

  validates :title, :body, :slug, :language, presence: true
  validates :body, length: { minimum: 20 }
  validates :title, :slug, uniqueness: { case_sensitive: false }

  has_many :translations_association, class_name: 'Translation'
  has_many :translations, through: :translations_association,
                          source: :translation
  has_many :inverse_translations_association, class_name: 'Translation',
                                              foreign_key: 'translation_id'
  has_many :inverse_translations, through: :inverse_translations_association,
                                  source: :word
  belongs_to :language

  scope :ordered_and_grouped, lambda {
    order('lower(title)')
      .group_by { |word| word.title[0].upcase }
  }
  scope :language, ->(lang) { where(language: lang) }

  def normalize_friendly_id(string)
    string.to_s.gsub(/\s/, '_')
  end

  def should_generate_new_friendly_id?
    title_changed? || super
  end
end
