# frozen_string_literal: true

FactoryBot.define do
  factory :memo do
    name { 'ど忘れしやすい名前' }
    tag_list { %w[タグ1 タグ2] }
    content { 'ど忘れしやすい名前です' }
    user
  end
end
