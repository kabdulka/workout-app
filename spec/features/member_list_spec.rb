require "rails_helper"

RSpec.feature "Listing Members" do 
# we're going to set up 2 members
# we're going to set them up with first name and last name
# because that's how we want our users to show up on the home page 
	before do
		@john = User.create(first_name: "John", last_name: "Doe", 
			email: "johndoe@example.com", password: "password")
		@sarah = User.create(first_name: "Sarah", last_name: "Joseph", 
			email: "sarahjoseph@example.com", password: "password")
	end

	# we only want to show members signed in the application
	scenario "shows a list of registered members" do
		visit "/"
		expect(page).to have_content("List of Members")
		expect(page).to have_content(@john.full_name)
		expect(page).to have_content(@sarah.full_name)
	end
end
