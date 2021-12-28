class BlogsController < ApplicationController
  def index
    @blogs = Blog.paginate(:page => params[:page], :per_page => 5).order(:created_at => :desc)
    @blog = Blog.new
  end

  def new
    @blog = Blog.new
    @attachment = @blog.attachments.build
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update(blog_params)
    if params[:attachments]
      params[:attachments]['file'].each do |f|
        @blog.attachments.create!(:file => f)
      end
    end
    
    redirect_to @blog
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.save
    if params[:attachments]
      params[:attachments]['file'].each do |f|
        @blog.attachments.create!(:file => f)
      end
    end
    
    redirect_to blogs_path
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, attachments_attributes: [:id, :blog_id, :file])
  end
end
