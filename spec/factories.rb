FactoryGirl.define do
  
  factory :list do
    sequence(:position) { |n| n }
    title "Some List"
    description "List of Cards"
  end

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