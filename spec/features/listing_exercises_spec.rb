require "rails_helper"

RSPec.feature "Listing Exercises" do
	before do
		@john = User.create(first_name: "John",last_name: "Doe",email: "john@example.com", password: "password")
		@sarah = User.create(first_name: "Sarah",last_name: "Doe",email: "sarah@example.com", password: "password")
		login_as(@john)

		@e1 = @john.exercises.create(duration_in_min: 20, workout: "Body build routine", workout_date: Date.today)
		@e2 = @john.exercises.create(duration_in_min: 20, workout: "Cardio", workout_date: Date.today)
	
		## Create a friendship between john and sarah
		## that is, create a following feature
		## The line below creates an entry in the friendship table 
		## with user ID of john and friend ID of sarah (user ID of sarah)
		## so sarah is now johns friend
		@following = Friendship.create(user: @john, friend: @sarah)
		
		## need to add a scenario now which john's account should show
		## a list of john's friends (so sarah should be in the list)
	end
	
	scenario "shows user's workout for last 7 days" do
		visit "/"

		click_link "My Lounge"
		expect(page).to have_content(@e1.duration_in_min)
		expect(page).to have_content(@e1.workout)
		expect(page).to have_content(@e1.workout_date)
		expect(page).to have_content(@e2.duration_in_min)
		expect(page).to have_content(@e2.workout)
		expect(page).to have_content(@e2.workout_date)
	end

	scenario "shows a list of users friends" do
		visit "/"
		## need to add a scenario now which john's account should show
	## a list of john's friends (so sarah should be in the list)
		# we want this in the mylounge section
		click_link "My Lounge"
		expect(page).to have_content("My Friends")
		expect(page).to have_link(@sarah.full_name)
		expect(page).to have_link("Unfollow")
	end

end














