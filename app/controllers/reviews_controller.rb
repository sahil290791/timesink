class ReviewsController < ApplicationController


  def index
    @reviews = Review.all
  end

  def new

      cookies[:original_referrer] = request.original_url

    if is_logged_in?

    @film = Film.friendly.find(params[:film_id])
    # this is the form for adding a new review
    @review = Review.new

  else
    @film = Film.friendly.find(params[:film_id])
    redirect_to new_session_path
    flash[:error] = "You must be signed in to write a review."
  end
end

def create
  @film = Film.friendly.find(params[:film_id])
  @review = @film.reviews.new(form_params)



  # associate the review with the current user before saving
  @review.user = @current_user

  if @review.save

  flash[:success] = "Your review has been published!"
    # go back to our film show path
    redirect_to film_path(@film)

  else
    render "new"
  end
end

def show
  @film = Film.friendly.find(params[:film_id])
  @review = Review.friendly.find(params[:id])

    cookies[:original_referrer] = request.original_url
end


def destroy

end

def form_params
  params.require(:review).permit(:title, :body, :score)
end


end
