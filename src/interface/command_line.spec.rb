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

  weighings = Application::RetrieveWeighingEntries.call()

  initial_ui = Interface::Ui::Initial.new()
  weighing_menu_ui = Interface::Ui::WeighingMenu.new()
  add_weighing_menu_ui = Interface::Ui::AddWeighingMenu.new()

  app_add_weighing = Application::AddWeighing.new(weighings:)

  exit_transition = Interface::Transitions::Exit.new(writer:)
  list_weighings_transition = Interface::Transitions::ListWeighings.new(writer:, weighings:)
  add_weighing_transition = Interface::Transitions::AddWeighing.new(writer:, weighings:, app_add_weighing:)

  Interface::CommandLine.new(
    reader:,
    writer:,
    initial_ui:,
    weighing_menu_ui:,
    add_weighing_menu_ui:,
    app_add_weighing:,
    exit_transition:,
    list_weighings_transition:,
    add_weighing_transition:
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