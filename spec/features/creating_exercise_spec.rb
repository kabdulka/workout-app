require "rails_helper"

RSpec.feature "creating Exercise" do

# before do we need to create a user, since exercises are going
# to belong to users we'll want to create a user and then we'll want 
# to simulate how the user would work through the application

# so first create the user
	before do
		@john = User.create(email: "john@example.com", password: "password")
# And then we want jonh (user) to log in because we don't
# users who are not logged in to be able to create an
# exercise 
		login_as(@john)
	end	

	# we're going to create a valid exercise 
	scenario "with valid inputs" do
		# we want user to visit root rout first
		# this has been pretty standard in all of the
		# feature tests
		visit "/"

		# Then user will click on a link that takes them
		# to their area in the app
		# this area is called My Lounge
		click_link "My Lounge"
		# the bottom line creates the workout
		click_link "New Workout"

		#There should be an expectation to have a link to
		# go back if user doesn't want to go through
		# with the new workout or for any reason wants to go back
		# to the previous screen they should be able to do so
		expect(page).to have_link("Back")

		# now that the user has clicked on the link for 
		# a new workout
		fill_in "Duration", with: 70
		fill_in "Workout Details", with: "Weight lifting"
		fill_in "Activity date", with: "2017-02-12"
		click_button "create Exercise"

		# so at this point if the exercise is created we'll want some
		# kind of expectation

		expect(page).to have_content("Exercise has been created")
		# we want the latest exercise created to be the link that is
		# displayed in the URL
		# Therefore, once the exercise has been created we want
		# to be in the link of that exercise's show page
		# we check that by grabbing the last exercise 
		exercise = Exercise.last
		# because latest entry will be last entry in Database
		expect(page.current_path).to eq(user_exercise_path(@john, exercise))

	end

end
