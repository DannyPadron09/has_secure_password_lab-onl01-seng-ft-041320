class SessionsController < ApplicationController

    def new

    end

    def create
        user = User.find_by(name: user_params[:name])
        user = user.try(:authenticate, user_params[:password])
        return redirect_to(controller: 'sessions', action: 'new') unless user 
        session[:user_id] = user.id 
        @user = user 
        redirect_to controller: 'welcome', action: 'home'
    end

    def destroy
        session.delete :user_id
        redirect_to '/new'
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end

end