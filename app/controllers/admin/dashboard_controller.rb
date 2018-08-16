class Admin::DashboardController < ApplicationController
  include ApplicationHelper
  before_action :only_admins

  def index
    @posts = Post.post.published.by_date.limit(5)
    @drafts = Post.post.draft.by_date.limit(5)
    @max_visits = Post.post.by_views.limit(5)
    @max_comments = Post.post.more_commented(5)
    @comments = Comment.approved.by_date.limit(5)
    @pending_comments = Comment.pending.by_date
  end
end
