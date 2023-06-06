FactoryBot.define do
  factory :order_address do
    postalcode        { Faker::Number.between(from: 100, to: 999).to_s + '-' + Faker::Number.between(from: 1000, to: 9999).to_s }
    shiparea_id       { Faker::Number.between(from: 2, to: 47) }
    shipcity          { Faker::Address.city }
    shipaddress       { Faker::Address.street_address }
    apartment         { Faker::Address.building_number }
    phone_number      { '0' + Faker::Number.between(from: 100000000, to: 9999999999).to_s }
    token             { 'tok_abcdefghijk00000000000000000' }
  end
end
