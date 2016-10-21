class PagesController < ApplicationController
  before_action :find_page, only: [:show, :edit, :update, :delete]
  def index
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    @page.user_id = session[:user_id]
    if @page.save
      redirect_to page_path(@page)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @page.assign_attributes(page_params)
    if @page.save
      redirect_to page_path(@page)
    else
      render :edit
    end
  end

  def destroy
  end

private
    def page_params
      params.require(:page).permit(:title, :content)
    end

    def find_page
      begin
        @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render file: "public/404", status: :not_found
      end
    end
end
