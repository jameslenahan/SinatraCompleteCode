
class BeersController < ApplicationController

  get '/beer/new' do
    erb :'beer/new'
  end

  post '/beer' do

    if params[:beer][:name] == "" || params[:beer][:abv] == "" || params[:beer][:description] == "" || params[:review][:content] == "" || (params[:beer][:category_id] == nil && params[:beer][:name] == "")
      erb :'beer/new'
    end
    @beer = Beer.where(:user_id => current_user.id).build(params[:beer])
    @beer.save
    #refactor to use build^
    if !params[:category][:name].empty? #checking if category exists, and if not, saving it
      @category = Category.find_or_create_by(name: params[:category][:name])
      @beer.category_id = @category.id
      @beer.save

    end
    redirect to "/beer/#{@beer.id}"
  end

  get '/beer/:id' do
    @beer = Beer.find_by_id(params[:id])
    @review = Review.find_by_id(params[:id])
    @review = params[:content]
    erb :'beer/show'
  end

  get '/beer/:id/edit' do
    if logged_in?
      @beer = Beer.find_by_id(params[:id])
      if @beer.user_id == current_user.id
        erb :'beer/edit'
      else
        redirect to '/'
      end
    else
      redirect to '/login'
    end
  end

  patch '/beer/:id' do
    if params[:beer][:name] == "" || params[:beer][:description] == "" || params[:beer][:abv] == "" || (params[:beer][:category_id] == "" && params[:category][:name] == "")
      redirect to "/beer/#{params[:id]}/edit"
    else
      @beer = Beer.find_by_id(params[:id])
      @beer.name = params[:name]
      @beer.description = params[:description]
      @beer.abv = params[:abv]
      @beer.save


      if !params[:category][:name].empty? #checking if category exists, and if not saving it
        @category = Category.find_or_create_by(name: params[:category][:name])
        @beer.category_id == @category.id
        @beer.save
      end
      redirect to "/beer/#{@beer.id}"
    end
  end


  delete '/beer/:id/delete' do
    @beer= Beer.find_by_id(params[:id])
    if @beer.user_id == current_user.id
      @beer.delete
    end
    redirect '/'
  end
end