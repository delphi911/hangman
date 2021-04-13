module TextContent
    def formatting(description, string)
      {
        'underline' => "\e[4;1m#{string}\e[0m",
        'bold' => "\e[1;1m#{string}\e[0m",
        'dim' => "\e[2;1m#{string}\e[0m",
        'italic' => "\e[3;1m#{string}\e[0m",
        'strike' => "\e[9;1m#{string}\e[0m",
        'black' => "\e[30;1m#{string}\e[0m",
        'red' => "\e[31;1m#{string}\e[0m",
        'green' => "\e[32;1m#{string}\e[0m",
        'yellow' => "\e[33;1m#{string}\e[0m",
        'blue' => "\e[34;1m#{string}\e[0m",
        'magenta' => "\e[35;1m#{string}\e[0m",
        'cyan' => "\e[36;1m#{string}\e[0m",
        'white' => "\e[37;1m#{string}\e[0m",
        'brightred' => "\e[91;1m#{string}\e[0m",

      }[description]
    end
  
    def game_message(message)
      {
        'won' => "  You found the secret word! Congratulations, you win! \n\n",
        'save' => "Saving game. You can play from where you left.",
        'load' => "Loading last saved game.",
        'repeat_prompt' => "\n\nDo you want to play again? Press 'y' for yes (or any other key for no).",
        'thanks' => "Thank you for playing Hangman!",
        'lost' => "You lost the game",
        'display_word' => "Here is the 'secret word' that you were trying to guess : ",
        'playsavedgame' => "There is a saved game. Shall we continue with the saved game? (+ for yes or any other key for a new game.)"
      }[message]
    end
   
    def turn_message(message, number = nil)
      {
        'game_start' => "The computer has set the 'secret word' and now it's time for you to guess the secret word.\n\n",
        'guess_prompt' => "Turn ##{number}: Type in One letter (case insensitive) to guess the secret word, or '-' to quit game. or '*'    save the current game"
      }[message]
    end
  
    def warning_message(message)
      {
        'input_error' => formatting('red', 'Your guess should only be one letter between a-z or A-Z.').to_s,
        'last_turn' => formatting('red', 'Choose carefully. This is your last chance to win!').to_s,
        'used_letter' => formatting('red', 'You used this letter already. Please enter a letter that is not used before!').to_s,
        'game_over' => "#{formatting('red', 'Game over. That was a hard word to break! ¯\\_(ツ)_/¯ ')} \n\n"
      }[message]
    end
  end
