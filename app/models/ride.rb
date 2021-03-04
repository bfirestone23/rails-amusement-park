class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction

    def take_ride
        if ticket_requirement == false && height_requirement == true
            not_enough_tickets
        elsif height_requirement == false && ticket_requirement == true
            not_tall_enough
        elsif height_requirement == false && ticket_requirement == false
            meets_no_requirements
        else
            start_ride
        end
    end

    def start_ride
        new_user_tickets = user.tickets - attraction.tickets
        new_user_nausea = user.nausea + attraction.nausea_rating
        new_user_happiness = user.happiness + attraction.happiness_rating
        
        user.update(
            nausea: new_user_nausea,
            happiness: new_user_happiness,
            tickets: new_user_tickets
        )

        "Thanks for riding the #{attraction.name}!"
    end

    def ticket_requirement
        user.tickets >= attraction.tickets
    end

    def height_requirement
        user.height >= attraction.min_height
    end

    def not_enough_tickets
        "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    end

    def not_tall_enough
        "Sorry. You are not tall enough to ride the #{attraction.name}."
    end

    def meets_no_requirements
        "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    end

end
