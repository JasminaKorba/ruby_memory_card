class Card
    VALUES = ("A"..."Z").to_a

    def self.shuffle_pairs(num_pair)
        values = VALUES

        while num_pair > values.length
            values = values + values
        end

        values = values.shuffle.take(num_pair) * 2
        values.shuffle! 
        values.map { |value| self.new(value) }
    end
    
    attr_reader :value

    def initialize(value, face_up = false)
        @value = value
        @face_up = face_up
    end

    def hide
        @face_up = false
    end 

    def reveal
        @face_up = true
    end

    def to_s
        @face_up == true ? value.to_s : "∎"
    end

    def face_up?
        @face_up
    end

    def ==(object)
        object.is_a?(self.class) && object.value == value
    end
end