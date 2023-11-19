# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Memos', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'メモの表示' do
    before do
      create(:memo, name: 'ど忘れしやすい名前', tag_list: %w[タグ1 タグ2], search_count: 1, user:)
      create(:memo, name: '覚えておきたい名前', tag_list: ['タグ1'], user:)
      visit root_path
    end

    it '全てのメモが表示されること' do
      expect(page).to have_content 'ど忘れしやすい名前'
      expect(page).to have_content '覚えておきたい名前'
    end

    describe '検索時の表示' do
      context 'キーワードタグで検索した場合' do
        it '「ど忘れしやすい名前」のみ表示されること' do
          expect(page).to have_checked_field('キーワードタグ')
          fill_in 'q', with: 'タグ1 タグ2'
          wait_for_turbo_frame
          expect(page).to have_content 'ど忘れしやすい名前'
          expect(page).to have_no_content '覚えておきたい名前'
        end
      end

      context '名前で検索した場合' do
        it '「覚えておきたい名前」のみ表示されること' do
          choose '名前'
          fill_in 'q', with: '覚えて'
          wait_for_turbo_frame
          expect(page).to have_content '覚えておきたい名前'
          expect(page).to have_no_content 'ど忘れしやすい名前'
        end
      end

      context '検索ワードを削除した場合' do
        it '全てのメモが表示されること' do
          fill_in 'q', with: 'タグ1 タグ2'
          wait_for_turbo_frame
          expect(page).to have_content 'ど忘れしやすい名前'
          expect(page).to have_no_content '覚えておきたい名前'
          find('input[name="q"]').send_keys([:backspace] * 7)
          wait_for_turbo_frame
          expect(page).to have_content 'ど忘れしやすい名前'
          expect(page).to have_content '覚えておきたい名前'
        end
      end
    end

    describe 'ソート機能' do
      it '検索した後順番が入れ替わること' do
        expect(first('strong').text).to eq 'ど忘れしやすい名前'
        choose '名前'
        fill_in 'q', with: '覚えて'
        wait_for_turbo_frame
        visit root_path
        expect(first('strong').text).to eq '覚えておきたい名前'
      end

      it 'ソートのリンクが機能すること' do
        expect(first('strong').text).to eq 'ど忘れしやすい名前'
        click_link('更新順')
        wait_for_turbo
        expect(first('strong').text).to eq '覚えておきたい名前'
        click_link('ど忘れが多い順')
        wait_for_turbo
        expect(first('strong').text).to eq 'ど忘れしやすい名前'
      end
    end
  end

  it 'メモを登録できること' do
    visit root_path
    click_link '+'
    fill_in 'memo[name]', with: 'ど忘れしやすい名前'
    tag_input = find '.tagify__input'
    tag_input.set 'タグ1'
    tag_input.send_keys :enter

    # タグが保存用のフォーマットに変換され、セットされているかの確認
    expect(page).to have_field 'memo[tag_list]', with: 'タグ1', visible: false

    fill_in 'memo[content]', with: 'ど忘れしやすい名前です'
    click_button '登録'
    expect(page).to have_content 'Memo was successfully created.'
    expect(page).to have_content 'ど忘れしやすい名前'
    click_link '編集'
    expect(page).to have_content 'タグ1'
    expect(page).to have_content 'ど忘れしやすい名前です'
  end

  it 'メモを編集できること' do
    create(:memo, name: 'ど忘れしやすい名前', user:)

    visit root_path
    click_link '編集'
    expect(page).to have_field 'memo[name]', with: 'ど忘れしやすい名前'
    fill_in 'memo[name]', with: '編集した名前'
    click_button '更新'
    expect(page).to have_content 'Memo was successfully updated.'
    expect(page).to have_content '編集した名前'
  end

  it 'メモを削除できること' do
    create(:memo, name: 'ど忘れしやすい名前', user:)

    visit root_path
    expect(page).to have_content 'ど忘れしやすい名前'
    click_link '削除'
    expect(page.accept_confirm).to eq '本当に削除してよろしいですか？'
    expect(page).to have_content 'Memo was successfully destroyed.'
    expect(page).to have_no_content 'ど忘れしやすい名前'
  end
end
