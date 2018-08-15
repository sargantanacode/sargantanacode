class Admin::DashboardController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

  def index
    @posts = Post.type(:post).status(:published).by_date.limit(5)
    @drafts = Post.type(:post).status(:draft).by_date.limit(5)
    @max_visits = Post.type(:post).by_views.limit(5)
    @max_comments = Post.type(:post).more_commented(5)
    @comments = Comment.approved.by_date.limit(5)
    @spam_comments = Comment.pending.by_date
  end
end
