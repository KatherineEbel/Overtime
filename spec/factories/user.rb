# frozen_string_literal: true

FactoryBot.define do

  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    first_name 'Jon'
    last_name 'Snow'
    password 'password'
    password_confirmation 'password'
  end

  factory :admin_user, class: 'AdminUser' do
    email 'admin@test.com'
    first_name 'Admin'
    last_name 'User'
    password 'password'
    password_confirmation 'password'
  end
end