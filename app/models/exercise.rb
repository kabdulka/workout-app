class Exercise < ActiveRecord::Base
	#because we did references user we have a belongs_to :user
  belongs_to :user

  validates :duration_in_min, presence: true 
  # enforce that the field has to be a number
  validates :duration_in_min, numericality: { only_integer: true }
  validates :workout, presence: true
  validates :workout_date, presence: true
  # user should be present
  # user must have a valid user id associated with 
  # the workout for it to work, otherwise it won't
  # each workout has to have a user id
  validates :user_id, presence: true
end
