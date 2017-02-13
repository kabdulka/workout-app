class ExercisesController < ApplicationController
	#only logged in users can take advantage of exercises
	before_action :authenticate_user!
	before_action :set_exercise, except: [:index, :new, :create]

	#add index action here
	def index

	end
	
	# need to create an index template, which will be users' lounge

	def new
		# we have a current user becasue users are required 
		# in order to create a new exercise
		@exercise = current_user.exercises.new
		# in order for the above line to work there needs to be an
		# association between the users and exercises
	end
	# need to create the exercise model now

	def create
		@exercise = current_user.exercises.new(exercise_params)
		if @exercise.save
			flash[:success] = "Exercise has been created"
			redirect_to [current_user, @exercise]

		else 
			flash[:danger] = "Exercise has not been created"
			render :new
		end
	end

	def show

	end

	private 

	def exercise_params
		params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user_id)
	end

	def set_exercise
		@exercise = current_user.exercises.find(params[:id])
	end
end








