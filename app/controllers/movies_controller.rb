class MoviesController < ApplicationController
  before_action :set_movie, only: %i[edit update destroy]
  before_action :set_categories, only: %i[index new edit create update]

  def index
    @movies = Movie.includes(:category)
                   .in_category(params[:category_id])
                   .with_priority(params[:priority])
                   .board_order
                   .group_by(&:status)
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      respond_to do |format|
        # From a card on the board (status button): update just that card.
        # From the full edit page: a normal redirect.
        format.turbo_stream if turbo_frame_request?
        format.html { redirect_to movies_path, notice: "Movie updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy!
    respond_to do |format|
      format.turbo_stream # destroy.turbo_stream.erb: remove just this card
      format.html { redirect_to movies_path, notice: "Movie deleted.", status: :see_other }
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def set_categories
    @categories = Category.order(:name)
  end

  def movie_params
    params.require(:movie).permit(:title, :year, :note, :status, :priority, :category_id)
  end
end
