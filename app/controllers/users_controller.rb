class UsersController < ApplicationController

	before_action :require_signin, except: [:new, :create]
	before_action :require_correct_user, only: [:edit, :update]
	before_action :admin_only, only: [:destroy]
	before_action :set_username, only: [:show, :destroy]

	def index
		@users = User.all
	end

	def show		
		@reviews = @user.reviews
		@favorite_movies = @user.favorite_movies
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to @user, notice: "Welcome to Flix #{@user.name}!"
		else 
			render :new
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_path, notice: "Account updated successfully."
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		redirect_to movies_url, alert: "Account deleted successfully."
	end

	private

		def require_correct_user
			#@user = User.find(params[:id])
			@user = set_username
			redirect_to movies_url unless current_user?(@user)
		end

		def admin_only
			require_admin 
		end

		def set_username
			@user = User.find_by!(slug: params[:id])
		end

		def user_params
			params.require(:user).
				permit(:name, :username, :email, :password, :password_confirmation)
		end
end
