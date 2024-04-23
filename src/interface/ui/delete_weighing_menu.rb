class Interface::Ui::DeleteWeighingMenu
  def render
    "Write the position of the weighing you want to delete"
  end

  def parse_input(input)
    position = input.to_i

    return [:DeleteWeighing, position]
  end
end