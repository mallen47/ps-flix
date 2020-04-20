class ReviewsController < ApplicationController

	before_action :set_movie
	before_action :require_signin, except: [:index]
	# Todo: 
	# Anyone can write or view the list of reviews for a movie, but 
	# only an admin or the user who created a review should be allowed
	# to edit or delete it
	# Implement this by removing the edit and delete buttons on the review#show
	# page except for Admins, and create a link on the user profile page to My 
	# Reviews. Create a new view for the current user's reviews with options to 
	# edit and delete there. 
	
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
			redirect_to @movie, notice: "Thanks for submitting a review!"
		else
			render :new
		end
	end

	def edit
		@review = @movie.reviews.find(params[:id])		
	end

	def update
		@review = @movie.reviews.find(params[:id])
		if @review.update(review_params)
			redirect_to movie_reviews_path, notice: "Review updated successfully"
		else
			render :edit
		end
	end

	def destroy
		@movie.reviews.find(params[:id]).destroy
		redirect_to request.referer || root_url

	# Movie.find(params[:id]).destroy
  # redirect_to movies_url, alert: "Movie deleted successfully."
	end

	private

		def review_params
			params.require(:review).permit(:stars, :comment)
		end

		def set_movie			
			@movie = Movie.find_by!(slug: params[:movie_id])
		end
	
end
