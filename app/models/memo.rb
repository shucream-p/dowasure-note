# frozen_string_literal: true

class Memo < ApplicationRecord
  belongs_to :user

  acts_as_taggable

  validates :name, presence: true, uniqueness: { scope: :user_id }

  class << self
    def search(query, option)
      case option
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
