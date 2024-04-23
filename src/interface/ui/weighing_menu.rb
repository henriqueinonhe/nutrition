class Interface::Ui::WeighingMenu
  def render
    <<~HEREDOC
    Weighing Module:

    1. List weighings
    2. Add weighing
    3. Delete weighing
    0. Back
    HEREDOC
  end

  def parse_input(input)
    case input
    when "1"
      return [:ListWeighings, nil]
    when "2"
      return [:StartAddWeighingMenu, nil]
    when "3"
      return [:StartDeleteWeighingMenu, nil]
    when "0"
      return [:Back, nil]
    end
  end
end