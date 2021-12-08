class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @projects = Project.all
    if params[:query].present?
      @query = params[:query]
      @projects = @projects.where("title iLike :query OR location iLike :query", query: "%#{params[:query]}%")
    end

    if params[:title].present?
      @query = params[:title]
      @projects = @projects.where("title >= :query", query: @query)
    end

    if params[:location].present?
      @query = params[:location]
      @projects = @projects.where("location <= :query", query: @query)
    end
  end

  def show
    @project = Project.find(params[:id])
    @volunteering = Volunteering.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.status = "open"
    @project.user = current_user
    if @project.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to dashboard_path
  end


  private

  def project_params
    params.require(:project).permit(:title,
                                    :location,
                                    :description,
                                    :contact,
                                    :status,
                                    :instagram_link,
                                    :facebook_link,
                                    :website_link,
                                    :linkedin_link,
                                    :start_date,
                                    :end_date,
                                    :start_tim,
                                    :end_time,
                                    photos: [])
  end
end
