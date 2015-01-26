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
