FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password1' } # 一貫性を保つために明示的に設定
    password_confirmation { password }
    first_name { Faker::Japanese::Name.first_name }
    last_name { Faker::Japanese::Name.last_name }
    read_first { 'カタカナ' } # 有効なカタカナ文字列を設定
    read_last { 'カタカナ' } # 有効なカタカナ文字列を設定
    birthday { Faker::Date.birthday }
  end
end