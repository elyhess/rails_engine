require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validation" do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end
  describe "relationships" do
    it { should have_many :invoices }
  end
end
