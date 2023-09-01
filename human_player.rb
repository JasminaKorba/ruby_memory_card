class HumanPlayer

    attr_accessor :previous_guess

    def initialize
        @previous_guess = nil
    end

    def guess
        prompt
        parse(STDIN.gets.chomp)
    end

    def matched(pos_1,pos_2)
        puts "It is a match!"
    end

    def parse(string)
        string.split(" ").map(&:to_i)
    end

    def receive_revealed_card(pos, revealed_value)
        my_cards = {}
        my_cards[revealed_value] = pos
    end

    def prompt
        puts "Which card's position do you want to flip? (e.g. 2 3)"
    end

end