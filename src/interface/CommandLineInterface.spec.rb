require "./src/testing/Test"
require "./src/testing/Assertions"
require "./src/interface/CommandLineInterface"

Test.test {
  class WriterMock
    attr_reader :buffer

    def initialize 
      @buffer = []
    end

    def write(output)
      @buffer.push(output)
    end
    
    def end(*)
      # NO OP
    end
  end

  class ReaderMock
    def initialize
      @buffer = [
        "1",
        "0",
        "0"
      ].map { |line| line }

      @index = 0
    end

    def read
      input = @buffer[@index]

      @index += 1

      return input
    end
  end

  writer = WriterMock.new
  reader = ReaderMock.new

  CommandLineInterface.new(
    reader:,
    writer:
  ).start

  Assertions.check {
    expected = <<~HEREDOC
    Nutrition Tracker

    1. Weighing Module
    0. Exit
    HEREDOC

    expected == writer.buffer[0]
  }

  Assertions.check {
    expected = <<~HEREDOC
    Weighing Module:

    1. List weighings
    2. Add weighing
    0. Back
    HEREDOC

    expected == writer.buffer[1]
  }
}