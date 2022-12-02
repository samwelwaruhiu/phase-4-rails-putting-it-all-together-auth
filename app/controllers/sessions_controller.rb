class SessionsController < ApplicationController
  #create a user and store in a session
  def create
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user, status: :created
      else
          render json: { errors: ["Invalid username or password"] }, status: :unauthorized
      end
  end 

  # DELETE user session through their id
  def destroy
       # is user is not logged in when they make a request
       return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
      # if logged in and session is in session hash
      session.delete :user_id
      render json: {}, status: :no_content
  end
end