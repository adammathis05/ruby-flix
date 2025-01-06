class ReviewsController < ApplicationController

  before_action :require_signin
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_reviews_path(@movie),
        notice: "Your review has been successfully added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @review = @movie.review
  end

  def update
    @review = @movie.review
    if @review.update(review_params)
      redirect_to movie_reviews_path(@movie),
        notice: "Your review has been successfully updated!"
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to movies_url, status: :see_other,
      alert: "Review successfully deleted!"
  end

end

private 

def review_params
  params.require(:review).permit(:comment, :stars)
end

def set_movie
  @movie = Movie.find_by!(slug: params[:movie_id])
end