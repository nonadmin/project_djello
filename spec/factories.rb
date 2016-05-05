FactoryGirl.define do

  factory :board do
    
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    username "someuser"
    email
    password "password"
  end

end