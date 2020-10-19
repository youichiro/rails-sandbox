FactoryBot.define do
  factory :user, class User do
    name: { "test_user" }
    email: { "test@gmail.com" }
    password: { "test_password" }
  end
end
