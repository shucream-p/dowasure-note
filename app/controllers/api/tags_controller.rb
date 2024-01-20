# frozen_string_literal: true

module API
  class TagsController < ApplicationController
    def search
      query = params[:query]
      @tags = ActsAsTaggableOn::Tag.for_tenant(current_user.id)
                                   .where('name LIKE ?', "#{query}%")
                                   .map(&:name)
      render json: @tags
    end
  end
end
