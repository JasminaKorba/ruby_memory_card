require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"

class MemoryGame

    attr_reader :player

    def initialize(player, size = 4)
        @board = Board.new(size)
        @previous_guess = nil
        @player = player
    end

    def compare_guess(new_guess)
        if previous_guess.nil?
            self.previous_guess = new_guess
            player.previous_guess = new_guess
        else
           if match?(previous_guess, new_guess)
                player.matched(previous_guess, new_guess)
           else
                puts "Try again..."
                [previous_guess, new_guess].each { |pos| board.hide(pos) }
           end
           self.previous_guess = nil
           player.previous_guess = nil
        end
    end
    
    def get_player_input
        pos = nil
        until pos && valid_guess?(pos)
            pos = player.guess
        end
        pos
    end

    def in_border?(pos)
        pos.all? { |x| x.between?(0, board.size - 1) }
    end

    def make_guess(pos)
        revealed_value = board.reveal(pos)
        player.receive_revealed_card(pos, revealed_value) 
        board.render

        compare_guess(pos)
        sleep(1)
    end

    def match?(pos1, pos2)
        board[pos1] == board[pos2]
    end

    def valid_guess?(pos)
        if in_border?(pos) && pos.count == 2 && pos.is_a?(Array)
             return true
        else
            puts "Card's position is incorrect."
        end
        false
    end

    def play
        welcome
        until board.win?
            board.render
            pos = get_player_input
            make_guess(pos)
            sleep(2)
            system("clear")
        end
        puts "Congratulations, you win!"
    end

    # UI methods
    def welcome
        system("clear")
        puts "This is big brain time!"
        sleep(2)
    end

    private

    attr_accessor :previous_guess
    attr_reader :board

end

if $PROGRAM_NAME == __FILE__
    game = MemoryGame.new(ComputerPlayer.new)
    game.play
end