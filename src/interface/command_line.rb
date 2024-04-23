class Interface::CommandLine
  def initialize(reader:, writer:)
    @reader = reader
    @writer = writer

    # TODO: Extract the composition root somewhere else
    weighings = Application::RetrieveWeighingEntries.call()
    @weighings = weighings

    initial_ui = Interface::Ui::Initial.new()
    weighing_menu_ui = Interface::Ui::WeighingMenu.new()
    add_weighing_menu_ui = Interface::Ui::AddWeighingMenu.new()

    app_add_weighing = Application::AddWeighing.new(weighings:)

    exit_transition = Interface::Transitions::Exit.new(writer:)
    list_weighings_transition = Interface::Transitions::ListWeighings.new(writer:, weighings:)
    add_weighing_transition = Interface::Transitions::AddWeighing.new(writer:, weighings:, app_add_weighing:)

    @state_matrix = {
    Initial: {
      ui: initial_ui,
      transitions: {
        StartWeighingMenu: proc { :WeighingMenu },
        Exit: exit_transition
      },
    },
    WeighingMenu: {
      ui: weighing_menu_ui,
      transitions: {
        ListWeighings: list_weighings_transition,
        StartAddWeighingMenu: proc { :AddWeighing },
        Back: proc { :Initial }
      }
    },
    AddWeighing: {
      ui: add_weighing_menu_ui,
      transitions: {
        AddWeighing: add_weighing_transition
      }
    },
  }
  end

  def start()
    state = :Initial

    begin
      while true
        break if state == :Finished

        render_ui(state)

        input = @reader.read()

        command = parse_input(state, input)

        next_state = process_command(state, command)

        state = next_state
      end
    rescue Interrupt
    end
  end

  private

  def render_ui(state)
    @writer.write(@state_matrix[state][:ui].render())
  end

  def parse_input(state, input)
    @state_matrix[state][:ui].parse_input(input)
  end

  def process_command(state, command)
    (action, payload) = command

    handler = @state_matrix[state][:transitions][action]

    if !handler 
      @writer.write "Invalid command!\n\n"
      return state
    end

    next_state = handler.call(payload)

    return next_state
  end
end