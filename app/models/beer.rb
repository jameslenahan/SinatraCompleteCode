class Beer < ActiveRecord::Base
  belongs_to :user, inverse_of: :beers
  belongs_to :category
  has_one :review
  validates :name, :description, :abv, :category_id, presence: true
end
