require "./src/domain/WeighingEntry"

class CommandLineInterface
  NO_OP = proc {}

  def initialize()
    # TODO: Load weighings
    @weighings = [
      WeighingEntry.new(
        date: Time.new(),
        weight_in_kg: 65.3
      )
    ]

    @state_matrix = {
    Initial: {
      ui: method(:render_initial_ui),
      parse_input: method(:parse_initial_input),
      transitions: {
        StartWeighingMenu: [:WeighingMenu, NO_OP],
        Exit: [:Finished, method(:exit)]
      },
    },
    WeighingMenu: {
      ui: method(:render_weighing_menu_ui),
      parse_input: method(:parse_weighing_menu_input),
      transitions: {
        ListWeighings: [:WeighingMenu, method(:list_weighings)],
        StartAddWeighingMenu: [:AddWeighing, NO_OP],
        Back: [:Initial, NO_OP]
      }
    },
    AddWeighing: {
      ui: method(:render_add_weighing_menu_ui),
      parse_input: method(:parse_add_weighing_menu_input),
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
        render_ui(state)

        input = read_input()

        command = parse_input(state, input)

        next_state = process_command(state, command)

        state = next_state
      end
    rescue Interrupt
    end
  end

  private

  def read_input()
    puts
    input = readline.strip()
    puts

    return input
  end

  def render_ui(state)
    @state_matrix[state][:ui].call()
  end

  def parse_input(state, input)
    @state_matrix[state][:parse_input].call(input)
  end

  def process_command(state, command)
    (action, payload) = command

    result = @state_matrix[state][:transitions][action]

    if !result 
      puts "Invalid command!\n\n"
      return state
    end

    (next_state, handler) = result

    handler.call(payload)

    return next_state
  end

  def render_initial_ui()
    puts <<~HEREDOC
    Nutrition Tracker

    1. Weighing Module
    0. Exit
    HEREDOC
  end

  # Specific

  def parse_initial_input(input)
    case input
    when "1"
      return [:StartWeighingMenu, nil]
    when "0"
      return [:Exit, nil]
    end
  end

  def exit(*)
    Kernel::exit(0)
  end

  def render_weighing_menu_ui()
    puts <<~HEREDOC
    Weighing Module:

    1. List weighings
    2. Add weighing
    0. Back
    HEREDOC
  end

  def parse_weighing_menu_input(input)
    case input
    when "1"
      return [:ListWeighings, nil]
    when "2"
      return [:StartAddWeighingMenu, nil]
    when "0"
      return [:Back, nil]
    end
  end

  def list_weighings(*)
    puts "Weighings:\n\n"

    @weighings.each do | weighing |
      puts "#{weighing.date} #{weighing.weight_in_kg}Kg"
    end

    puts
  end

  def render_add_weighing_menu_ui()
    puts <<~HEREDOC
    Write the weight (in Kg)
    HEREDOC
  end

  def parse_add_weighing_menu_input(input)
    weight_in_kg = input.to_f

    return [:AddWeighing, weight_in_kg]
  end

  def add_weighing(weight_in_kg)
    @weighings.push(WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: weight_in_kg
    ))
  end
end