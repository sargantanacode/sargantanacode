class Admin::DashboardController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

  def index
    @posts = Post.type(:post).status(:published).by_date.limit(5)
    @drafts = Post.type(:post).status(:draft).by_date.limit(5)
    @visits = Post.type(:post).by_views.limit(5)
  end
end
