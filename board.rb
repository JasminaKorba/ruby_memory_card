require_relative "card.rb"

class Board

    attr_reader :size

    def initialize(size = 4)
        @rows = Array.new(size) { Array.new(size) }
        @size = size
        populate
    end

    def [](pos)
        row, col = pos
        rows[row][col]
    end

    def []=(pos, value)
        row, col = pos
        rows[row][col] = value
    end

    def hide(pos)
        self[pos].hide
    end

    def populate
        num_pair = (size**2)/2
        p cards = Card.shuffle_pairs(num_pair)
        rows.each_index do |row_i|
            rows[row_i].each_index do |col_i|
                self[[row_i, col_i]] = cards.pop 
            end
        end
    end

    def render
        column = (0...rows.length).to_a
        puts "  " + "#{column.join(" ")}" 
        rows.each_with_index do |row, i|
            puts "#{i} #{row.join(" ")}"
        end
    end

    def reveal(pos)
        if self[pos].face_up?
            puts "You can not flip a card that has already been revealed."
        else
            self[pos].reveal
        end
        self[pos].value
    end

    def win?
        @rows.flatten.all?(&:face_up?) 
    end

    private

    attr_reader :rows
end


