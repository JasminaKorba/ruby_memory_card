class ComputerPlayer
    attr_accessor :previous_guess    
    attr_reader :size, :known_cards, :matched

    def initialize(size = 4)
        @size = size
        @known_cards = {}  
        @matched = {} 
        @previous_guess = nil
    end

    
    def first_guess
        unmatched_pos || random_guess
    end

    def guess
        if !previous_guess.nil?
            second_guess
        else
            first_guess
        end
    end
    
    def is_matched(pos)
        @matched.any? { |p1, p2| pos == p1 || pos == p2 }
    end

    def match_previous
        guess = nil
        @known_cards.any? do |pos, val|
            if  previous_guess != pos && @known_cards[previous_guess] == val
                guess = pos
            end
        end
        guess
    end

    def matched(pos_1, pos_2)
        @matched[pos_1] = pos_2
        puts "It is a match!"
    end

    def random_guess
        guess = nil

        until guess && !@known_cards[guess]
            guess = [rand(0...size), rand(0...size)]
        end

        guess
    end

    def receive_revealed_card(pos, revealed_value)
        known_cards[pos] = revealed_value
    end

    def second_guess
        match_previous || random_guess
    end

    def unmatched_pos
        guess = nil
        @known_cards.each do |pos, val|
            @known_cards.each do |pos2, val2|
                if pos != pos2 && val == val2 && !is_matched(pos)
                    guess = pos
                end
            end
        end
        guess
    end

end