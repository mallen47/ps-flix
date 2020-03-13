class MoviesController < ApplicationController
	def index
		@movies = Movie.released
	end

	def new
		@movie = Movie.new
	end

	def create
		@movie = Movie.new(movie_params)
		if @movie.save
			# redirect and display flash notice in one step
			redirect_to @movie, notice: "Movie created successfully."
			#	redirect_to @movie
			# above line does same as: 
			# redirect_to movie_path(@movie)
		else
			render :new
		end

	end

	def show
		@movie = Movie.find(params[:id])
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update(movie_params)
			# flash[:notice] = "Movie updated successfully."
			# redirect_to @movie
			
			# redirect and display flash notice in one step
			redirect_to @movie, notice: "Movie updated successfully."
		else
			render :edit
		end
	end

  def destroy
  	Movie.find(params[:id]).destroy
  	redirect_to movies_url, alert: "Movie deleted successfully."
  end


	private

		def movie_params
			params.require(:movie).
				permit(:title, :description, :rating, :released_on, :total_gross,
					     :director, :duration, :image_file_name)
		end
end
