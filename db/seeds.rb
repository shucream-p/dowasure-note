# frozen_string_literal: true

User.create!(email: 'testuser@example.com', password: 'testtest')

Memo.create!(
  [
    {
      name: 'ど忘れしやすい名前',
      content: 'ど忘れしやすい名前です',
      search_count: 2,
      user_id: 1
    },
    {
      name: 'すごくすごくとてもとてもめちゃくちゃに長い名前なので全部は表示できない',
      content: 'すごく長い名前です',
      search_count: 1,
      user_id: 1
    }
  ]
)

28.times do |n|
  Memo.create!(
    name: "名前#{n + 1}",
    user_id: 1
  )
end

ActsAsTaggableOn::Tag.create!([{ name: 'タグ1' }, { name: 'タグ2' }])

ActsAsTaggableOn::Tagging.create!(
  [
    {
      tag_id: 1,
      taggable_type: 'Memo',
      taggable_id: 1,
      context: 'tags',
      tenant: 1
    },
    {
      tag_id: 2,
      taggable_type: 'Memo',
      taggable_id: 1,
      context: 'tags',
      tenant: 1
    },
    {
      tag_id: 1,
      taggable_type: 'Memo',
      taggable_id: 2,
      context: 'tags',
      tenant: 1
    }
  ]
)
