# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Memos', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it 'メモを登録できること' do
    visit root_path
    click_link '+'

    fill_in 'memo[name]', with: 'ど忘れしやすい名前'
    fill_in 'memo[tag_list]', with: 'タグ1,タグ2'
    fill_in 'memo[content]', with: 'ど忘れしやすい名前です'
    click_button '登録'
    expect(page).to have_content 'Memo was successfully created.'
    expect(page).to have_content 'ど忘れしやすい名前'

    click_link '詳細'
    expect(page).to have_content 'ど忘れしやすい名前です'
  end

  it 'メモを編集できること' do
    Memo.create(user:, name: 'ど忘れしやすい名前')

    visit root_path
    click_link '編集'
    expect(page).to have_field 'memo[name]', with: 'ど忘れしやすい名前'
    fill_in 'memo[name]', with: '編集した名前'
    click_button '更新'
    expect(page).to have_content 'Memo was successfully updated.'
    expect(page).to have_content '編集した名前'
  end

  it 'メモを削除できること' do
    Memo.create(user:, name: 'ど忘れしやすい名前')

    visit root_path
    expect(page).to have_content 'ど忘れしやすい名前'
    click_link '削除'
    expect(page.accept_confirm).to eq '本当に削除してよろしいですか？'
    expect(page).to have_content 'Memo was successfully destroyed.'
    expect(page).to have_no_content 'ど忘れしやすい名前'
  end
end
