class Movie < ActiveRecord::Base
  def self.with_ratings(ratings)
    return self.where(rating: ratings)
  end
  
  
  def self.with_ratings_sort(ratings, sort_by)
      return self.where(rating: ratings).order(sort_by)
  end
end
