# frozen_string_literal: true

class MemosController < ApplicationController
  before_action :set_memo, only: %i[show edit update]

  def index
    @memos = Memo.all
  end

  def show; end

  def new
    @memo = Memo.new
  end

  def edit; end

  def create
    @memo = current_user.memos.build(memo_params)

    if @memo.save
      redirect_to root_url, notice: 'Memo was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @memo.update(memo_params)
      redirect_to root_url, notice: 'Memo was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_memo
    @memo = Memo.find(params[:id])
  end

  def memo_params
    params.require(:memo).permit(:name, :content, :tag_list)
  end
end
