class Admin::CommentsController < ApplicationController
  include ApplicationHelper
  before_action :only_admins
  before_action :set_comment_id, only: [:approve]

  def index
    @comments = Comment.by_date
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def approve
    @comment.approve
    flash[:notice] = t('.approved')
    redirect_back(fallback_location: homepage_path)
  end

  private

  def set_comment_id
    @comment = Comment.find(params[:comment_id])
  end
end
