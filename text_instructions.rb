# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize


# module only contains instructions for game
module TextInstructions
    def instructions
      <<~HEREDOC
        #{formatting('underline', 'How to play Hangman:')}
        #{formatting('bold', 'Hangman')} is a #{formatting('brightred', 'paper and pencil')} #{formatting('red', 'guessing game')} for two or more players. One player thinks of a word, 
        phrase or sentence and the other(s) tries to guess it by suggesting letters within a certain number
         of guesses.
      HEREDOC
    end
  end
  
# rubocop:enable Metrics/AbcSize
  
