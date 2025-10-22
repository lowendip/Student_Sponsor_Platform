# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.find_or_initialize_by(username: "sponsor")
user.assign_attributes(name: "Sponsor", organization: "UMBC", contact: "fake@email.com", role: "Sponsor", password: "test", password_confirmation: "test", email_confirmed: true)
user.save!
domain = Domain.new(name:"AI")
domain.save!
