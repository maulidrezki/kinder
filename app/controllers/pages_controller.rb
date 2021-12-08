class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # redirect_to projects_path if user_signed_in?

    if params[:query].present?
      @query = params[:query]
      @projects = Project.where("title iLike :query OR location iLike :query", query: "%#{params[:query]}%")
    else
      @projects = Project.all.first(5)
    end
  end

  def dashboard
    # My projects as a sponsor
    @my_projects = current_user.projects

    # My projects as a volunteer
    @volunteer_projects = current_user.volunteer_projects

    # My volunteers in a project, to review to accept or reject
    @my_volunteers = []
    @my_project.each do |project|
      @query = project.id
      @my_volunteers = Volunteering.where("project_id = :query", query: @query)
  end

  def profile
    @user = current_user
    @query = @user.id
    @listed = []
    @listed += Project.where("user_id = :query", query: @query)
    @total_listed_projects = @listed.size
    @volunteered = []
    @volunteered += Volunteering.where("user_id = :query", query: @query)
    @total_volunteered = @volunteered.size
  end

end
