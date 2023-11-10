# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Memo, type: :model do
  let(:user) { create(:user) }

  describe 'ユーザー単位では重複した名前は許可しないこと' do
    context '同じユーザーの場合' do
      it '登録失敗すること' do
        Memo.create(user:, name: 'ど忘れしやすい名前')

        memo = Memo.new(user:, name: 'ど忘れしやすい名前')
        memo.valid?
        expect(memo.errors[:name]).to include('has already been taken')
      end
    end

    context '異なるユーザーの場合' do
      it '登録成功すること' do
        Memo.create(
          user: create(:user, email: 'testuser1@example.com'),
          name: 'ど忘れしやすい名前'
        )

        memo = Memo.new(
          user: create(:user, email: 'testuser2@example.com'),
          name: 'ど忘れしやすい名前'
        )
        expect(memo).to be_valid
      end
    end
  end

  describe '.search' do
    before do
      @memo = Memo.create(user:, name: 'ど忘れしやすい名前', tag_list: %w[タグ1 タグ2])
    end

    context '引数にタグを渡した場合' do
      it '該当するメモが含まれること' do
        expect(Memo.search('タグ1 タグ2', 'tag')).to include @memo
      end
    end

    context '引数に名前を渡した場合' do
      it '該当するメモが含まれること' do
        expect(Memo.search('ど忘れ', 'name')).to include @memo
      end
    end
  end
end
