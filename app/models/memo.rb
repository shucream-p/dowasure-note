# frozen_string_literal: true

class Memo < ApplicationRecord
  belongs_to :user

  acts_as_taggable

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
