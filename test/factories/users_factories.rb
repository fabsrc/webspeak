FactoryGirl.define do
  factory :user do
    name 'Mikeee Test'
    email 'mike@email.com'
    password 'password'
    password_confirmation 'password'
    role 1
  end

  factory :other_user, class: :user do
    name 'Archerrr fdfTest'
    email 'archer@email.com'
    password 'password'
    password_confirmation 'password'
    role 0
  end
end
