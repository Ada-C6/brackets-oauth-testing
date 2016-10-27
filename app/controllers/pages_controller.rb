class PagesController < ApplicationController
  before_action :find_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = @current_user.pages.by_date

    puts "Session contents: #{session.to_hash}"

    unless session[:last_page].nil?
      @last_page = @current_user.pages.find(session[:last_page])
    end
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
    session[:last_page] = @page.id

    flash[:experiment] = "this is a test"
  end

  def edit
  end

  def update
    puts ">>>> These are the params"
    params.to_hash.each do |key, value|
      puts "#{key}, #{value}"
    end

    if params[:page][:upvote]
      puts ">>>>> Hey hey, this is upvoted!"
    end


    @page.assign_attributes(page_params)
    if @page.save
      redirect_to page_path(@page)
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path
  end

private
    def page_params
      params.require(:page).permit(:title, :content)
    end

    def find_page
      begin
        @page = @current_user.pages.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render file: "public/404", status: :not_found
      end
    end






















end
