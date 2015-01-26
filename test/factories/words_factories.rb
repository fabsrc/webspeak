FactoryGirl.define do
  factory :word do
    title 'HTML'
    body 'Hypertext markup langauge is a language...'
    association :language, factory: :testlanguage, strategy: :build
  end
  factory :translated_word, class: :word do
    title 'HTAS'
    body 'Hochtextauszeichnungssprache ist eine Sprache...'
    association :language, factory: :german, strategy: :build
  end
end
