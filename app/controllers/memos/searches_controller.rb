# frozen_string_literal: true

class Memos::SearchesController < ApplicationController
  def index
    memos = current_user.memos
    query = params[:query]
    option = params[:search_option]
    @memos = (query.present? ? memos.search(query, option) : memos).forgetful.page(params[:page])
    @memos.each(&:increase_search_count) if query.present?
  end
end
