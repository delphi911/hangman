# frozen_string_literal: true

require './text_instructions'
require './text_content'
require './display'


# main class that starts the game
class Game
  include TextInstructions
  include TextContent
  include Display

  def initialize
    @turn = 1
    @history = []
    @foundletters = []
  end

  def play
    if Savegame.fileexist?
      puts game_message('playsavedgame')
      if player_input == "+"
        playsavedgame      
        return
      end
    end
    puts instructions
    words = Words.new
    @secretword = words.secretword.downcase
    @secretword.length.times {@foundletters << "?"}
    player_turns
  end

  def playsavedgame
    load_game
    Savegame.deletesavedgame
    show_word(@foundletters)
    show_history(@history)
    player_turns
  end

  def player_turns
    puts turn_message('game_start') if freshgame?
    turn_order
    game_over 
  end

  def turn_order
    while @turn <= 8
      turn_messages(@turn)
      @guess = player_input 
      break if @guess.downcase == '-' #quit
      break if @guess.downcase == '*' #save
      @turn += 1 if process_guess(@guess) != 1
      show_word(@foundletters)
      show_history(@history)
      break if solved? 
    end
  end
  
  def player_input
    input = gets.chomp
    return input if input.match(/^[a-zA-Z]{1}$/)
    return input if input.downcase == '*'
    return input if input.downcase == '-'
    return input if input.downcase == "+"
    puts warning_message('input_error')
    player_input
  end

  def process_guess(letter)
    if letter_used?(letter)
      puts warning_message('used_letter')
      return 1
    end
    @history << letter 
    a = (0 ... @secretword.length).find_all { |i| @secretword[i] == letter.downcase }
    unless a.empty?
      a.each {|v|@foundletters[v]= letter}
      return 1
    end
  end

  def turn_messages(turn)
    puts turn_message('guess_prompt', turn)
    puts warning_message('last_turn') if turn == 8
  end

  def solved?
    @foundletters.none?{|i| i == "?"}
  end

  def freshgame?
    @foundletters.all?{|i| i == "?"}
  end

  def letter_used?(letter)
    @history.any?{|i| i == letter}
  end

  def game_over
    puts game_message('won') if solved?
    quitgame  if @guess.downcase == '-' 
    savegame  if @guess.downcase == '*'
    quitgame if @turn >= 9
    repeat_game
  end

  def quitgame
    puts game_message('lost')
    print game_message('display_word')
    puts formatting('green', @secretword)
  end

  def savegame
    puts game_message('save')
    save = Savegame.new(@secretword, @turn, @history, @foundletters)
    save.save
  end

  def load_game
    puts game_message('load')
    savegame = Savegame.new
    savegame.load
    @secretword =savegame.secretword
    @turn = savegame.turn 
    @history = savegame.history
    @foundletters = savegame.foundletters
  end

  def repeat_game
    puts game_message('repeat_prompt')
    replay = gets.chomp
    puts game_message('thanks') if replay.downcase != 'y'
    Game.new.play if replay.downcase == 'y'
  end
end

