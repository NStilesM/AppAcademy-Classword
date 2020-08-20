class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        render :show
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login_user!(@user)
            render json: @user
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    private 
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
