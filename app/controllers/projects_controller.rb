class ProjectsController < ApplicationController
  def index
    @current_projects = Project.where(:enddate => nil).order(:startdate => :desc)
    @past_projects = Project.where("enddate is NOT NULL").order(:enddate => :desc)
    @project = Project.new
  end

  def new
    @project = Project.new
    @attachment = @project.attachments.build
  end

  def show
    id = params[:id]
    if id.to_i.to_s == id
      @project = Project.find(params[:id])
    else
      @project = Project.where(["extension = ?", params[:id]]).first
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    if params[:attachments]
      params[:attachments]['file'].each do |f|
        @project.attachments.create!(:file => f)
      end
    end

    redirect_to @project
  end

  def create
    @project = Project.new(project_params)
    @project.save
    if params[:attachments]
      params[:attachments]['file'].each do |f|
        @project.attachments.create!(:file => f)
      end
    end
    redirect_to projects_path
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  private
    def project_params
      params.require(:project).permit(:title, :content, :extension, :description, :startdate, :enddate, :thumbnail, attachments_attributes: [:id, :project_id, :file])
    end
end
