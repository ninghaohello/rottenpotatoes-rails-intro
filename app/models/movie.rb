class Movie < ActiveRecord::Base
  def self.get_ratings
    return self.pluck(:rating).uniq
  end
end
