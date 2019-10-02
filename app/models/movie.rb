class Movie < ActiveRecord::Base
    def getPossibleRatings
        return self.select(:rating).distinct
    end
end
