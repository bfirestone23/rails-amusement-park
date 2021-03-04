class SessionsController < ApplicationController

    def new
        @users = User.all
    end

    def create
        @user = User.find_by(name: params[:user_name])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url
    end

end