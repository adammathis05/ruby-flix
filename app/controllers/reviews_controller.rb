class ReviewsController < ApplicationController

  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    if @review.save
      redirect_to movie_reviews_path(@movie),
        notice: "Your review has been successfully added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

end

private 

def review_params
  params.require(:review).permit(:name, :comment, :stars)
end

def set_movie
  @movie = Movie.find(params[:movie_id])
end