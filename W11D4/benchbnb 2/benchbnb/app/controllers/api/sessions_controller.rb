class Api::SessionsController < ApplicationController

    before_action :ensure_logged_in, only: [:destroy]

    def create
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        if @user
            login!(@user)
            render "api/users/show"
        else
            render json: ["Invalid User Credentials"]
        end
    end

    def destroy
        if logged_in? 
            logout!
            render json: {}
        else
            render json: ["No one is signed in"], status: 404

        end
    end
end
