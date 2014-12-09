class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
  	@movies = Movie.order('id DESC').all
  end

  def search
  	@search = params[:q]
  	@movie = Movie.search(@search)
  	@no_results = !@movie
  end

  def new
  	@movie = Movie.new
  end

  def create
  	@movie = current_user.movies.new(parameters)
    if @movie.valid?
    	@movie.save
      flash[:info] = 'New movie created successfully'
      redirect_to root_path and return
    end

    flash[:error] = "You are an idiot!"
  end

	private
	def parameters
		params.require(:movie).permit(:title, :description, :year_released)
	end
end
