# frozen_string_literal: true

class MemosController < ApplicationController
  before_action :set_memo, only: %i[show edit update destroy]

  def index
    memos = current_user.memos
    @memos = (params[:latest] ? memos.latest : memos.forgetful).page(params[:page])
  end

  def show; end

  def new
    @memo = Memo.new
  end

  def edit; end

  def create
    @memo = current_user.memos.build(memo_params)

    if @memo.save
      redirect_to root_url, notice: t('notice.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @memo.update(memo_params)
      redirect_to root_url, notice: t('notice.update')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @memo.destroy

    # 削除して登録しているメモが0になったら、Turbo Streamsで登録なしの表示に更新するため
    @count = current_user.memos.count

    flash.now.notice = t('notice.delete')
  end

  private

  def set_memo
    @memo = current_user.memos.find(params[:id])
  end

  def memo_params
    params.require(:memo).permit(:name, :content, :tag_list)
  end
end
