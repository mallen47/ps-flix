class FavoritesController < ApplicationController

	# before_action :require_signin, only[:create, :destroy]
	before_action :require_signin

	def create
		# @movie = params[:movie]
		@movie = set_movie
		# @favorite = @movie.favorite.new(user: params[:user_id])
		@movie.favorites.create!(user: current_user)

		# the above line can also be done via the associastion like so:
		#@movie.fans << current_user

		redirect_to @movie
	end

	def destroy			
			current_user.favorites.find(params[:id]).destroy
			redirect_to set_movie
	end

	private

		def set_movie
			@movie = Movie.find_by!(slug: params[:movie_id])
		end
end
