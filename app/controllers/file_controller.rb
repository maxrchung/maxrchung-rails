class FileController < ApplicationController
  def show
    key = params[:id]
    # carrierwave appends uploads to the path
    url = 'https://maxrchung-rails.s3.amazonaws.com/uploads/' + key
    redirect_to url
  end
end
