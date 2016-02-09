module TestHelpers
  def it_has_attributes(*attributes)
    record = described_class.new
    attributes.each do |attribute|
      it "has #{attribute}" do
        expect(record.send("#{attribute}")).to be_falsey
      end
    end
  end
end