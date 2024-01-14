# frozen_string_literal: true

module MetaTagsHelper
  # rubocop:disable Metrics/MethodLength
  def default_meta_tags
    {
      site: 'ど忘れノート',
      reverse: true,
      charset: 'utf-8',
      description: 'ど忘れしやすい名前を似たような名前や関連ワードと一緒に登録すると、インクリメンタルサーチですばやく検索できます。',
      keywords: 'ど忘れ, 名前, 覚えられない, メモ, 検索',
      canonical: 'https://dowasure-note.com',
      separator: '|',
      og: {
        title: :title,
        type: 'website',
        site_name: 'ど忘れノート',
        description: :description,
        image: image_url('ogp.png'),
        url: 'https://dowasure-note.com'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@shucream__p',
        description: :description
      }
    }
  end
  # rubocop:enable Metrics/MethodLength
end
