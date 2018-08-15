class Admin::CommentsController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_comment_id, only: [:approve, :spam]

  def index
    @comments = Comment.by_date
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = t('.saved')
      redirect_back(fallback_location: admin_dashboard_path)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = t('.destroyed')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  def approve
    @comment.approve
    flash[:notice] = t('.approved')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  def spam
    @comment.spam
    flash[:notice] = t('.spam')
    redirect_back(fallback_location: admin_dashboard_path)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comment_id
    @comment = Comment.find(params[:comment_id])
  end

  def comment_params
    permitted = [:author, :email, :url, :comment, :status]
    params.require(:comment).permit(permitted)
  end
end
