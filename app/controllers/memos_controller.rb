# frozen_string_literal: true

class MemosController < ApplicationController
  before_action :set_memo, only: %i[show edit update destroy]

  def index
    memos = current_user.memos
    @memos = params[:latest] ? memos.latest.page(params[:page]) : memos.forgetful.page(params[:page])
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

    flash.now.notice = t('notice.delete')
  end

  def search
    memos = current_user.memos
    @memos = if params[:q].present?
               memos.search(params[:q], params[:search_option])
                    .page(params[:page])
             else
               memos.page(params[:page])
             end

    @memos.each(&:increase_search_count) if params[:q].present?
  end

  private

  def set_memo
    @memo = Memo.find(params[:id])
  end

  def memo_params
    params.require(:memo).permit(:name, :content, :tag_list)
  end
end
