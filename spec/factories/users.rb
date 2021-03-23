FactoryBot.define do
  factory :user do
    user_name { Faker::Name.first_name }
    full_name { Faker::Name.name }
    corp_name { Faker::Company.name }
    email { Faker::Internet.free_email }
    password = 'hogehoge000' # 英数字混在が条件なのでFakerを使わない
    password { password }
    password_confirmation { password }
  end
end
