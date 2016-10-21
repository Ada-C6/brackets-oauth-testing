class PagesController < ApplicationController
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
    @page = find_page
  end

  def edit
    @page = find_page
  end

  def update
    @page = find_page
    @page.assign_attributes(page_params)
    if @page.save
      redirect_to page_path(@page)
    else
      render :edit
    end
  end

  def destroy
    @page = find_page
  end

private
    def page_params
      params.require(:page).permit(:title, :content)
    end

    # Could be a model method, but because it's got the render
    # I think it fits better here.
    def find_page
      begin
        return Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render file: "public/404", status: :not_found
      end
    end
end
