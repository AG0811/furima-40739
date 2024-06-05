FactoryBot.define do
  factory :order_address do
    postcode { '123-4567' }
    prefecture_id { 2 }
    municipalities { 'Test City' }
    address { 'Test Address' }
    building_name { 'Test Building' }
    phone_number { '09012345678' }
    user_id { 1 }
    item_id { 1 }
    price { 1000 }
    token { 'tok_abcdefghijk00000000000000000' }
    item { association :item }
  end
end
