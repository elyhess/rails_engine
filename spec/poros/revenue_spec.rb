require 'rails_helper'

describe "Revenue" do
  it "has attributes" do
    attributes = {
                  revenue: 100.0
                }
    rev_test = Revenue.new(attributes)
    expect(rev_test).to be_an_instance_of(Revenue)
    expect(rev_test.revenue).to have_key(:revenue)
  end
end
