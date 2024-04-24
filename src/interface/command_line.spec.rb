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

  reader = ReaderMock.new
  writer = WriterMock.new
  weighing_entry_persistence = Infra::FsWeighingEntryPersistence.new(
    weighings_file_path: "./storage/weighings.test.json"
  )

  container = RootContainer.derive(
    weighing_entry_persistence: Di::Container.value_resolver(weighing_entry_persistence),
    reader: Di::Container.value_resolver(reader),
    writer: Di::Container.value_resolver(writer),
  )

  container.get(:command_line).start

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
    3. Delete weighing
    0. Back
    HEREDOC

    expected == writer.buffer[1]
  }
}