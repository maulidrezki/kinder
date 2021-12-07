class VolunteeringsController < ApplicationController
  def create
    @volunteering = Volunteering.new
    @project = Project.find(params[:project_id])
    @volunteering.user = current_user
    @volunteering.project = @project
    @volunteering.status = "pending"

    if @volunteering.save
      redirect_to dashboard_path
    else
      redirect_to new_usser_session_path
    end
  end

  def update
    @volunteering = Volunteering.find(params[:id])
    if @volunteering.update(status: params[:status])
      redirect_to dashboard_path
    else
      render 'dashboard'
    end
  end
end
