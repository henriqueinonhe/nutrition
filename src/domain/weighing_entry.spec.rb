RSpec.describe Domain::WeighingEntry do
  context "When creating a weighing entry with an invalid id" do
    it "Raises an exception" do
      expect {
         Domain::WeighingEntry.new(
          id: 1,
          date: Time.new(),
          weight_in_kg: 20 
        )
      }.to raise_error(
          having_attributes(
            tags: [:PreconditionViolation, :ConstructionFailure, :WeighingEntry, :InvalidId]
          )
        )
    end
  end

  context "When creating a weighing entry with an invalid date" do
    it "Raises an exception" do
      expect {
         Domain::WeighingEntry.new(
          id: "1",
          date: "asdasd",
          weight_in_kg: 20 
        )
      }.to raise_error(
          having_attributes(
            tags: [:PreconditionViolation, :ConstructionFailure, :WeighingEntry, :InvalidDate]
          )
        )
    end
  end

  context "When creating a weighing entry with zero weight" do
    it "Raises an exception" do
      expect {
         Domain::WeighingEntry.new(
          id: "1",
          date: Time.new(),
          weight_in_kg: 0
        )
      }.to raise_error(
          having_attributes(
            tags: [:PreconditionViolation, :ConstructionFailure, :WeighingEntry, :InvalidWeight]
          )
        )
    end
  end

  context "When creating a weighing entry with negative weight" do
    it "Raises an exception" do
      expect {
         Domain::WeighingEntry.new(
          id: "1",
          date: Time.new(),
          weight_in_kg: -20
        )
      }.to raise_error(
          having_attributes(
            tags: [:PreconditionViolation, :ConstructionFailure, :WeighingEntry, :InvalidWeight]
          )
        )
    end
  end

  context "When creating a valid weighing entry" do
    def setup
      Domain::WeighingEntry.new(
        id: "1",
        date: Time.new(),
        weight_in_kg: 37
      )
    end

    it "Does not throw an exception" do
      expect { setup }.not_to raise_error
    end
      
  end
end