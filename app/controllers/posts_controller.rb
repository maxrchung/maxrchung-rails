class PostsController < ApplicationController
  def new
    @post = Post.new
    @attachment = @post.attachments.build
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if params[:attachments]
      params[:attachments]['file'].each do |f|
        @post.attachments.create!(:file => f)
      end
    end

    redirect_to about_path
  end

  def create
    @post = Post.new(post_params)
    @post.save
    if params[:attachments]
      params[:attachments]['file'].each do |f|
        @post.attachments.create!(:file => f)
      end
    end
    redirect_to about_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to about_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, attachments_attributes: [:id, :post_id, :file])
    end
end
