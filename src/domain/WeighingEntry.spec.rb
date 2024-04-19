require "./src/testing/Assertions"
require "./src/testing/Test"
require "./src/domain/WeighingEntry"

Test::test {
  Assertions::check_throws {
    WeighingEntry.new(
      date: "asdasd",
      weight_in_kg: 20 
    )
  }

  Assertions::check_throws {
    WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 0
    )
  }

  Assertions::check_throws {
    WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: -20
    )
  }

  Assertions::check_no_throw {
    WeighingEntry.new(
      date: Time.new(),
      weight_in_kg: 37
    )
  }
}
