class ReviewsController < ApplicationController

	before_action :set_movie
	# Todo restrict non-logged in users from writing, editing, or deleting reviews
	
	def index
		@reviews = @movie.reviews
	end

	def new
		@review = @movie.reviews.new
	end

	def create	
		@review = @movie.reviews.new(review_params)
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
			params.require(:review).permit(:name, :stars, :comment)
		end

		def set_movie
			@movie = Movie.find(params[:movie_id])
		end
	
end
