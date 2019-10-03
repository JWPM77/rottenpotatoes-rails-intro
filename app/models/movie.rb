class Movie < ActiveRecord::Base
    def self.get_possible_ratings
        rating_list = []
        self.select(:rating).distinct.all.each do |item|
            rating_list << item.rating
        end
        
        return rating_list.sort
    end
    
    def self.with_ratings(ratings)
       return self.where(rating: ratings)
    end
end
