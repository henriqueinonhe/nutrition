class Interface::CommandLine
  NO_OP = proc {}

  def initialize(reader:, writer:)
    @reader = reader
    @writer = writer

    initial_ui = Interface::Ui::Initial.new()
    weighing_menu_ui = Interface::Ui::WeighingMenu.new()
    add_weighing_menu_ui = Interface::Ui::AddWeighingMenu.new()

    # TODO: Load weighings
    @weighings = [
      Domain::WeighingEntry.new(
        date: Time.new(), 
        weight_in_kg: 65.3
      )
    ]

    @state_matrix = {
    Initial: {
      ui: initial_ui,
      transitions: {
        StartWeighingMenu: [:WeighingMenu, NO_OP],
        Exit: [:Finished, method(:exit)]
      },
    },
    WeighingMenu: {
      ui: weighing_menu_ui,
      transitions: {
        ListWeighings: [:WeighingMenu, method(:list_weighings)],
        StartAddWeighingMenu: [:AddWeighing, NO_OP],
        Back: [:Initial, NO_OP]
      }
    },
    AddWeighing: {
      ui: add_weighing_menu_ui,
      transitions: {
        AddWeighing: [:WeighingMenu, method(:add_weighing)]
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

    result = @state_matrix[state][:transitions][action]

    if !result 
      @writer.write "Invalid command!\n\n"
      return state
    end

    (next_state, handler) = result

    handler.call(payload)

    return next_state
  end

  def exit(*)
    @writer.end()
  end

  def list_weighings(*)
    @writer.write "Weighings:\n\n"

    @weighings.each do | weighing |
      @writer.write "#{weighing.date} #{weighing.weight_in_kg}Kg"
    end

    @writer.write("\n")
  end

  def add_weighing(weight_in_kg)
    @weighings.push(Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: weight_in_kg
    ))
  end
end