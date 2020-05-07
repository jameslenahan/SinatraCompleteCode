class ReviewsController < ApplicationController
  get "/beer/:id/reviews/new" do
    @beer = Beer.find_by_id(params[:id])
    erb :'beer/review'
  end
  post "/reviews" do
    @beer = Beer.find_by_id(params[:id])
    @review = Review.where(:beer_id => current_user.id).build(params[:review])
    @review.save
    redirect to '/show'

  end
end