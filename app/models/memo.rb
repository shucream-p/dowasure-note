# frozen_string_literal: true

class Memo < ApplicationRecord
  belongs_to :user

  acts_as_taggable
  acts_as_taggable_tenant :user_id

  validates :name, presence: true, uniqueness: { scope: :user_id }

  scope :latest, -> { order(updated_at: :desc) }
  scope :forgetful, -> { order(search_count: :desc, updated_at: :desc) }

  class << self
    def search(query, target)
      case target
      when 'name'
        where('name LIKE ?', "%#{query}%")
      when 'tag'
        tag_search(query)
      end
    end

    private

    def tag_search(query)
      words = query.split(/[\p{blank}\s]+/).select(&:present?)
      tagged_with(words)
    end
  end

  def increase_search_count
    increment(:search_count, 1)
    save(touch: false)
  end
end
