# frozen_string_literal: true

class MemosController < ApplicationController
  def index; end

  def new
    @memo = Memo.new
  end

  def create
    @memo = current_user.memos.build(memo_params)

    if @memo.save
      redirect_to root_url, notice: 'Memo was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:name, :content, :tag_list)
  end
end
