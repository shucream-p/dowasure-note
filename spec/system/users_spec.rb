# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  it 'アカウント登録できること' do
    visit root_path
    click_button '新規登録', match: :first
    fill_in 'user[email]', with: 'testuser@example.com'
    fill_in 'user[password]', with: 'testtest'
    fill_in 'user[password_confirmation]', with: 'testtest'
    click_button 'アカウント登録'
    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  it 'ログインできること' do
    user
    visit root_path
    click_link 'ログインはこちらから', match: :first
    fill_in 'user[email]', with: 'testuser@example.com'
    fill_in 'user[password]', with: 'testtest'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
  end

  context '未ログインでログイン必須ページにアクセスした場合' do
    it 'ログインページにリダイレクトされること' do
      visit memos_path
      expect(page).to have_current_path '/users/sign_in'
      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
    end
  end

  describe 'ユーザーメニュー' do
    before do
      sign_in user
      visit root_path
      user_icon = find '.fa-user'
      user_icon.click
    end

    it 'アカウント情報を更新できること' do
      click_link 'アカウント設定'
      fill_in 'user[email]', with: 'updateuser@example.com'
      fill_in 'user[current_password]', with: 'testtest'
      click_button '更新'
      expect(page).to have_content 'アカウント情報を変更しました。'
      visit edit_user_registration_path
      expect(page).to have_field 'user[email]', with: 'updateuser@example.com'
    end

    it 'アカウントを削除できること' do
      click_link 'アカウント設定'
      click_button 'アカウントを削除する'
      expect do
        expect(page.accept_confirm).to eq 'アカウントを削除すると、登録しているデータが全て失われます。本当によろしいですか？'
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end.to change(User, :count).by(-1)
    end

    it 'ログアウトできること' do
      click_button 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end

    it 'メニューが閉じること' do
      click_button('×')
      expect(page).to have_no_content 'アカウント設定'
    end
  end
end
