FactoryBot.define do
  factory :user do
    email                 {'test@example'}
    password              {'000aaa'}
    password_confirmation {password}
  end
end