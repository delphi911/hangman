# frozen_string_literal: true

# module with display information for game
module Display
    def show_word(array)
      puts "The secret word is #{array.join}"
    end

    def show_history(array)
      puts "Your guessed up to now : #{array.join(", ")}"
    end
end
