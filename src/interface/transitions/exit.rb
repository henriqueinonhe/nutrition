class Interface::Transitions::Exit
  def initialize(writer:)
    @writer = writer
  end

  def call(*)
    @writer.end()

    return :Finished
  end
end