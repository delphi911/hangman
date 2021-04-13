require 'csv'

class Words 
  attr_reader :secretword

  def initialize
    loadwords
    getsecretword
  end
  
  def loadwords
    contents = CSV.open(
    '5desk.txt',
    headers: true, 
    header_converters: :symbol
  )
  wordlist = []
  contents.each do |row|
    wordlist << row[:word] if row[:word].length > 4 &&  row[:word].length < 13
  end # do
  wordlist
end

def getsecretword
  @secretword = loadwords.sample(1)[0]
end

end #class
