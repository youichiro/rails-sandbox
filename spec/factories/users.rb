FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test@gmail.com" }
    password { "test_password" }
  end
end
