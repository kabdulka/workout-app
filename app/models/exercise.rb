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

  #show user workouts for the last 7 days
  # implemet that last 7 days
  # to implement give a default scope
  default_scope { where('workout_date > ?', 7.days.ago).order(workout_date: :desc)}

end

# moris.js provides graphical user interface for data
