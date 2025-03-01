# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

main_user = FactoryBot.create :user
friend_users = FactoryBot.create_list :user, 2
other_users = FactoryBot.create_list :user, 5

friend_users.each do |u|
  FactoryBot.create :circle, user: u, following: main_user, status: :accepted
end

FactoryBot.create_list :sleep_history, 5, :completed, user: main_user
FactoryBot.create :sleep_history, user: main_user
