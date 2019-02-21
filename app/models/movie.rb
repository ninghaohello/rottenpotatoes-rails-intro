class Movie < ActiveRecord::Base
  # Part2 BEGIN



  def self.get_all_ratings



    return self.pluck(:rating).uniq



  end







  def self.with_ratings(ratings)



    return self.where(rating: ratings)



  end
  def self.with_ratings_sort(ratings, sort_by)
      return self.where(rating: ratings).order(sort_by)
  end
end
