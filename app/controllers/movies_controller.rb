class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def search
    if params[:search].present?
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.all
    end
  end

  # GET /movies
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  def show
    @reviews = @movie.reviews.order("created_at DESC")

    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
    end
  end

  # GET /movies/new
  def new
    @movie = current_user.movies.build
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  def create
    @movie = current_user.movies.build(movie_params)

    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render 'new'
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render 'edit'
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy
      redirect_to movies_url, notice: 'Movie was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :image)
    end
end
