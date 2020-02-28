class MoviesController < ApplicationController
	def index
		@movies = ["Superman", "Ironman", "Batman", "Spider Man"]
	end
end
