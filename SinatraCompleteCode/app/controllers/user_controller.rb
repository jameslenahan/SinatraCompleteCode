class UsersController < ApplicationController

  get '/signup' do
    @user = User.new
    erb :'user/signup'

  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      redirect '/login'
    else
      @message = @user.errors.full_messages.join(', ')
      erb :'user/signup'
    end
  end

  get '/account' do
    erb :'user/show'
  end

end