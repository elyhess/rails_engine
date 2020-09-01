FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Games::Minecraft.item}
    description { Faker::TvShows::RickAndMorty.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
