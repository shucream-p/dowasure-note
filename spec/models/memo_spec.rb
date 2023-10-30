# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Memo, type: :model do
  describe 'ユーザー単位では重複した名前は許可しないこと' do
    let(:user) { create(:user) }

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
end
