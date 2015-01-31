lang1 = Language.create! name: 'German', code: 'DE'
lang2 = Language.create! name: 'English', code: 'EN'

word1 = Word.new title: 'HTML',
                 body: 'Hyper Text Markup Language is a markup
                 language for the web',
                 language: lang2,
                 tag_list: %w(acronym markup)

word2 = Word.new title: 'ÜTAS',
                 body: 'Die Übertextauszeichnungssprache ist eine
                 Auszeichnungssprache zur Erstellung von Netzinhalten.',
                 language: lang1,
                 tag_list: %w(acronym markup)

word3 = Word.new title: 'Material Design',
                 body: 'Material Design is Google\'s new way
                 of designing the web.',
                 language: lang2,
                 tag_list: %w(design google)

word4 = Word.new title: 'Materialgestaltung',
                 body: 'Materialgestaltung ist Googles neue Art
                 das Netz zu gestalten.',
                 language: lang1,
                 tag_list: %w(design google)

word1.translations << word2
word2.translations << word1
word3.translations << word4
word4.translations << word3

word1.save!
word2.save!
word3.save!
word4.save!

User.create!(name: 'Example User',
             email: 'example@email.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             role: 1)

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@email.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
