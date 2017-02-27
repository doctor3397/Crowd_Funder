class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)
    @search_results = []

    @projects.each do |project|
      if params[:project_title] && project.title.downcase.include?(params[:project_title].downcase)
        @search_results << project
      elsif params[:project_categoy] && project.category == params[:project_categoy]
        @search_results << project
      end
      @search_results
    end

    if request.xhr?
      respond_to do |format|
        format.json {
          render json: @search_results
        }
      end
    end

  end

  def show
    @project = Project.find(params[:id])
    @backers = @project.backers
    @pledges = @project.pledges
    @comment = Comment.new
  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new(project_params)
    @project.owner_id = current_user.id
    if @project.save
      UserMailer.create_project_email(current_user).deliver_now
      redirect_to projects_url
    else
      render :new
    end
   end

  private
  def project_params
    params.require(:project).permit(:title, :description, :goal, :start_date, :end_date, :image, :category, :photo, rewards_attributes: [:dollar_amount, :description, :_destroy])
  end
end
