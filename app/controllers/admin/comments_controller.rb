class Admin::CommentsController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

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
    
  end
end
