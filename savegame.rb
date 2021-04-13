# frozen_string_literal: true

require 'json'

class Savegame

  attr_accessor :secretword, :turn, :history, :foundletters

  def initialize(secretword="", turn=0, history=[], foundletters=[])
    @secretword = secretword
    @turn = turn
    @history = history
    @foundletters = foundletters
    Dir.mkdir('savedgames') unless Dir.exists?('savedgames')
  end

  def save
    JSON.dump ({
      :secretword => @secretword,
      :turn => @turn,
      :history => @history,
      :foundletters => @foundletters
    })
    File.open('savedgames/hangman.json', 'w') do |f|
        f.write(JSON.dump ({
            :secretword => @secretword,
            :turn => @turn,
            :history => @history,
            :foundletters => @foundletters
          }))
      end
  end

  def load 
    string = File.read('savedgames/hangman.json') 
    data = JSON.parse(string)
    @secretword =data['secretword']
    @turn =  data['turn']
    @history =  data['history']
    @foundletters = data['foundletters']
  end

  def self.fileexist?
    File.exist?('savedgames/hangman.json')
  end

  def self.deletesavedgame
    begin
      f = File.open('savedgames/hangman.json', 'r')
    ensure
      if !f.nil? && File.exist?(f)
        f.close unless f.closed? 
        File.delete(f)
      end
    end
  end
end #class
