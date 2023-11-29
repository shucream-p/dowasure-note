# frozen_string_literal: true

module API
  class TagsController < ApplicationController
    def search
      query = params[:query]
      @tags = ActsAsTaggableOn::Tag.where('name LIKE ?', "#{query}%").pluck(:name)
      render json: @tags
    end
  end
end
