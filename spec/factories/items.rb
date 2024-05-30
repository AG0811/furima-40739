FactoryBot.define do
  factory :item do
    association :user
    item_name { "Example Item" }
    item_description { "This is an example item description." }
    category_id { 2 } # あなたのカテゴリIDに置き換えてください
    condition_id { 2 } # あなたのコンディションIDに置き換えてください
    burden_id { 2 } # あなたの負担IDに置き換えてください
    prefecture_id { 2 } # あなたの都道府県IDに置き換えてください
    days_id { 2 } # あなたの日数IDに置き換えてください
    price { 1000 } # あなたの価格に置き換えてください
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'factories', 'image', 'test_image.png')), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end