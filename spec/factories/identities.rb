# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    email "MyString"
    provider "MyString"
    password_digest "MyString"
  end
end
