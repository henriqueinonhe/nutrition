Test.test {
  Assertions.check_throws {
    Domain::WeighingEntry.new(
      date: "asdasd",
      weight_in_kg: 20 
    )
  }

  Assertions.check_throws {
    Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 0
    )
  }

  Assertions.check_throws {
    Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: -20
    )
  }

  Assertions.check_no_throw {
    Domain::WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 37
    )
  }
}
