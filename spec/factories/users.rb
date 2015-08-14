require 'ffaker'

FactoryGirl.define do
  factory :user do
  	name FFaker::Name.name
  	city FFaker::Address.city
    email FFaker::Internet.email
    password FFaker::Lorem.words(2).join
  end

end
