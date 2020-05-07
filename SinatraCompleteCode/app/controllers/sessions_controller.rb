class SessionsController < ApplicationController

  get '/login' do
    erb :'user/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/account"
    else
      redirect to "/failure"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end