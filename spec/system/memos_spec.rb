# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Memos', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe '一覧表示' do
    context 'メモの登録がある場合' do
      it '登録したメモが表示されること' do
        create(:memo, name: 'ど忘れしやすい名前', user:)
        visit root_path
        expect(page).to have_content 'ど忘れしやすい名前'
      end

      it '他ユーザーのメモは表示されないこと' do
        other_user = create(:user, email: 'otheruser@test.com')
        create(:memo, name: '他ユーザーのメモ', user: other_user)

        visit root_path
        expect(page).to have_no_content '他ユーザーのメモ'
      end
    end

    context 'メモの登録がない場合' do
      it '「まだメモが登録されていません」と表示されること' do
        visit root_path
        expect(page).to have_content 'まだメモが登録されていません'
      end
    end
  end

  describe '内容表示' do
    it 'メモの内容を表示できること' do
      create(:memo, content: 'ど忘れしやすい名前です', user:)

      visit root_path
      comment_icon = find '.fa-comment-dots'
      comment_icon.click
      expect(page).to have_content 'ど忘れしやすい名前です'
    end
  end

  describe '登録' do
    it 'メモを登録できること' do
      visit root_path
      click_button '登録する'
      fill_in 'memo[name]', with: 'ど忘れしやすい名前'
      tag_input = find '.tagify__input'
      tag_input.set 'タグ1'
      tag_input.send_keys :enter

      # タグが保存用のフォーマットに変換され、セットされているかの確認
      expect(page).to have_field 'memo[tag_list]', with: 'タグ1', visible: false

      fill_in 'memo[content]', with: 'ど忘れしやすい名前です'
      click_button '登録'
      expect(page).to have_content 'メモが作成されました'
      expect(page).to have_content 'ど忘れしやすい名前'

      # スワイプしてリンクを表示させる
      slider = find '.swiper-wrapper'
      execute_script("arguments[0].style.transform = 'translateX(-85.5px)';", slider)

      edit_icon = find '.fa-pen-to-square'
      edit_icon.click
      expect(page).to have_content 'タグ1'
      expect(page).to have_content 'ど忘れしやすい名前です'
    end

    it 'キーワードタグの説明モーダルが表示されること' do
      visit new_memo_path
      question_icon = find '.fa-circle-question'
      question_icon.click
      expect(page).to have_content 'キーワードタグとは？'
      click_button('×')
      expect(page).to have_no_content 'キーワードタグとは？'
    end

    describe 'キーワードタグ入力のサジェスト' do
      it 'キーワードタグのサジェストが表示されること' do
        create(:memo, tag_list: ['登録されているタグ'], user:)
        visit new_memo_path
        tag_input = find '.tagify__input'
        tag_input.set '登録'
        expect(page).to have_content '登録されているタグ'
      end

      it '他ユーザーの登録しているキーワードタグは表示されないこと' do
        other_user = create(:user, email: 'otheruser@test.com')
        create(:memo, tag_list: ['他ユーザーのタグ'], user: other_user)
        visit new_memo_path
        tag_input = find '.tagify__input'
        tag_input.set '他'
        expect(page).to have_no_content '他ユーザーのタグ'
      end
    end
  end

  describe '編集' do
    it 'メモを編集できること' do
      create(:memo, name: 'ど忘れしやすい名前', user:)

      visit root_path

      # スワイプしてリンクを表示させる
      slider = find '.swiper-wrapper'
      execute_script("arguments[0].style.transform = 'translateX(-85.5px)';", slider)

      edit_icon = find '.fa-pen-to-square'
      edit_icon.click
      expect(page).to have_field 'memo[name]', with: 'ど忘れしやすい名前'
      fill_in 'memo[name]', with: '編集した名前'
      click_button '更新'
      expect(page).to have_content 'メモが更新されました'
      expect(page).to have_content '編集した名前'
    end
  end

  describe '削除' do
    it 'メモを削除できること' do
      create(:memo, name: 'ど忘れしやすい名前', user:)

      visit root_path
      expect(page).to have_content 'ど忘れしやすい名前'

      # スワイプしてリンクを表示させる
      slider = find '.swiper-wrapper'
      execute_script("arguments[0].style.transform = 'translateX(-85.5px)';", slider)

      delete_icon = find '.fa-trash-can'
      delete_icon.click
      expect(page.accept_confirm).to eq '本当に削除してよろしいですか？'
      expect(page).to have_content 'メモが削除されました'
      expect(page).to have_content 'まだメモが登録されていません'
    end
  end

  describe '検索' do
    before do
      create(:memo, name: 'ど忘れしやすい名前', tag_list: %w[タグ1 タグ2], user:)
      create(:memo, name: '覚えておきたい名前', tag_list: ['タグ1'], user:)
      visit root_path
    end

    context 'キーワードタグで検索した場合' do
      it '入力したキーワードタグを持つメモのみ表示されること' do
        expect(page).to have_checked_field('キーワードタグ')
        fill_in 'q', with: 'タグ1 タグ2'
        find 'turbo-frame[complete]'
        expect(page).to have_content 'ど忘れしやすい名前'
        expect(page).to have_no_content '覚えておきたい名前'
      end
    end

    context '名前で検索した場合' do
      it '入力したワードを名前に含むメモのみ表示されること' do
        choose '名前'
        fill_in 'q', with: '覚えて'
        find 'turbo-frame[complete]'
        expect(page).to have_content '覚えておきたい名前'
        expect(page).to have_no_content 'ど忘れしやすい名前'
      end
    end

    context '検索ワードを削除した場合' do
      it '全てのメモが表示されること' do
        fill_in 'q', with: 'タグ1 タグ2'
        find 'turbo-frame[complete]'
        expect(page).to have_content 'ど忘れしやすい名前'
        expect(page).to have_no_content '覚えておきたい名前'
        find('input[name="q"]').send_keys([:backspace] * 7)
        find 'turbo-frame[complete]'
        expect(page).to have_content 'ど忘れしやすい名前'
        expect(page).to have_content '覚えておきたい名前'
      end
    end

    context '検索結果なしの場合' do
      it '「見つかりませんでした。」と表示されること' do
        fill_in 'q', with: 'タグ3'
        expect(page).to have_content '見つかりませんでした。'
      end
    end
  end

  describe 'ソート' do
    before do
      create(:memo, name: 'ど忘れしやすい名前', search_count: 1, user:)
      create(:memo, name: '覚えておきたい名前', user:)
      visit root_path
    end

    it '検索した後順番が入れ替わること' do
      expect(first('#name').text).to eq 'ど忘れしやすい名前'
      choose '名前'
      fill_in 'q', with: '覚えて'
      find 'turbo-frame[complete]'
      visit root_path
      expect(first('#name').text).to eq '覚えておきたい名前'
    end

    it 'ソートのリンクが機能すること' do
      expect(first('#name').text).to eq 'ど忘れしやすい名前'
      click_link('更新順')
      find 'turbo-frame[complete]'
      expect(first('#name').text).to eq '覚えておきたい名前'
      click_link('ど忘れが多い順')
      find 'turbo-frame[complete]'
      expect(first('#name').text).to eq 'ど忘れしやすい名前'
    end
  end
end
