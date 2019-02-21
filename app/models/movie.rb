class Movie < ActiveRecord::Base
  def self.with_ratings(ratings)
    return self.where(rating: ratings)
  end
end
