
require "rails_helper"

RSpec.feature "Users signup" do

	scenario "with valid credentials" do
		visit "/"

		click_link "Sign up"
		########## for list of members feature #########
		fill_in "First name", with: "John"
		fill_in "Last name", with: "Doe"
		##########
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		fill_in "Password confirmation", with: "password"
		click_button "Sign up"

		# The expectation is to have a sign in successfully message
 		# then email address

		expect(page).to have_content("You have signed up successfully.")

		###### for list of members
		visit "/"
		expect(page).to have_content("John Doe")
		######

## we don't have the expectations to have cont john doe on the page
	## Since the expectation is not there the spec is passing
	end


		scenario "with invalid credentials" do
		visit "/"

		click_link "Sign up"
		########## for list of members feature #########
		fill_in "First name", with: ""
		fill_in "Last name", with: ""
		##########
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		fill_in "Password confirmation", with: "password"
		click_button "Sign up"

		# The expectation is to have a sign in successfully message
 		# then email address

		expect(page).to have_content("First name can't be blank")


		expect(page).to have_content("Last name can't be blank")
		######

## we don't have the expectations to have cont john doe on the page
	## Since the expectation is not there the spec is passing
	end




end






