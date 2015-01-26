FactoryGirl.define do
  factory :testlanguage, class: :language do
    name 'Testlanguage'
    code 'TL'
  end
  factory :german, class: :language do
    name 'German'
    code 'DE'
  end
end
