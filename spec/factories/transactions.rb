FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "2020-08-29" }
    result { "MyString" }
  end
end
