lang1 = Language.create name: 'German', code: 'DE'
lang2 = Language.create name: 'English', code: 'EN'

words =
  [
    {
      title: 'HTML',
      body: 'Hyper Text Markup Language is a Markup Language...',
      language: lang2 },
    {
      title: 'ÜTAS',
      body: 'Über Text Auszeichnungs Sprache ist eine Auszeichnungssprache...',
      language: lang1
    },
    {
      title: 'Material Design',
      body: 'Material Design is Google new way of...',
      language: lang2
    },
    {
      title: 'Materialgestaltung',
      body: 'Materialgestaltung ist Googles neue Art...',
      language: lang1
    }
  ]

Word.create(words)

User.create!( name: "Example User",
              email: "example@email.com",
              password: "foobar",
              password_confirmation: "foobar",
              role: 1)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@email.com"
  password = "password"
  User.create!( name: name,
                email: email,
                password: password,
                password_confirmation: password)
end
