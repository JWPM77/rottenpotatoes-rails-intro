class Movie < ActiveRecord::Base
    def self.getPossibleRatings
        rating_list = []
        self.select(:rating).distinct.all.each do |item|
            rating_list << item.rating
        end
        
        return rating_list.sort
    end
end
