class TeamController < ApplicationController
  def index
    @users = User.only_with_job.by_job
  end
end
