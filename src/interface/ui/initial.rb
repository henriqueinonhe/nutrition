class Interface::Ui::Initial
  def render
    <<~HEREDOC
    Nutrition Tracker

    1. Weighing Module
    0. Exit
    HEREDOC
  end

  def parse_input(input)
    case input
    when "1"
      return [:StartWeighingMenu, nil]
    when "0"
      return [:Exit, nil]
    end
  end
end