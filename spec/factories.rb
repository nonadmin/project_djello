FactoryGirl.define do
  factory :card do
    title "TestCard"
    description "A Task Card"
    association :list
  end
  
  factory :list do
    sequence(:position) { |n| n }
    title "TestList"
    description "List of Cards"
    association :board
  end

  factory :board do
    title "Some Board"
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