# frozen_string_literal: true

@user = User.create!(email: 'post@test.com', password: 'password',
                    password_confirmation: 'password',
                    first_name: 'Jon', last_name: 'Snow')

puts '1 user created'

100.times do |post|
  Post.create(user_id: @user.id,
              date: Date.today,
              rationale: "#{post} rationale")
end

puts '100 posts created'