module Interface::StdinReader
  def self.read
    puts
    input = readline.strip()
    puts

    return input
  end
end