# frozen_string_literal: true

class API::Tags::SearchesController < ApplicationController
  def index
    query = params[:query]
    tags = ActsAsTaggableOn::Tag.for_tenant(current_user.id)
                                .where('name LIKE ?', "#{query}%")
                                .map(&:name)
    render json: tags
  end
end
