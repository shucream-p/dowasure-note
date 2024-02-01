# frozen_string_literal: true

class Memos::SearchesController < ApplicationController
  def index
    memos = current_user.memos
    @memos = if params[:query].present?
               memos.search(params[:query], params[:search_option])
                    .forgetful
                    .page(params[:page])
             else
               memos.forgetful
                    .page(params[:page])
             end

    @memos.each(&:increase_search_count) if params[:query].present?
  end
end
