# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Memo, type: :model do
  describe 'ユーザー単位では重複した名前は許可しないこと' do
    let(:user) { create(:user, email: 'testuser@example.com') }

    context '同じユーザーの場合' do
      it '登録失敗すること' do
        create(:memo, user:, name: 'ど忘れしやすい名前')

        memo = build(:memo, user:, name: 'ど忘れしやすい名前')
        memo.valid?
        expect(memo.errors[:name]).to include('はすでに存在します')
      end
    end

    context '異なるユーザーの場合' do
      it '登録成功すること' do
        other_user = create(:user, email: 'otheruser@test.com')

        create(:memo, user:, name: 'ど忘れしやすい名前')

        memo = build(:memo, user: other_user, name: 'ど忘れしやすい名前')
        expect(memo).to be_valid
      end
    end
  end

  describe '.search' do
    let(:memo) { create(:memo, name: 'ど忘れしやすい名前', tag_list: %w[タグ1 タグ2]) }

    context '引数にタグを渡した場合' do
      it '該当するメモが含まれること' do
        expect(Memo.search('タグ1 タグ2', 'tag')).to include memo
      end
    end

    context '引数に名前を渡した場合' do
      it '該当するメモが含まれること' do
        expect(Memo.search('ど忘れ', 'name')).to include memo
      end
    end
  end

  describe '#increase_search_count' do
    let(:memo) { create(:memo) }

    it 'search_countが1増えること' do
      expect(memo.search_count).to eq 0

      memo.increase_search_count
      expect(memo.search_count).to eq 1
    end

    it 'updated_atが更新されないこと' do
      updated_at = memo.updated_at

      memo.increase_search_count
      expect(memo.updated_at).to eq updated_at
    end
  end
end
