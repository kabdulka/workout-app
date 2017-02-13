class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # this is a one to many association
  # so a user can have many exercises
  has_many :exercises

  # Need to create an exercise model then we have a foriegn key for user
  # ID in the exercises table that the model will generate so that we can
  # reference which user is associated with each exercise
  # to create a model we type
  # rails g model exercise duration_in_min:integer workout:text workout_date:date user:references
  # user:references for the foreign key to the user table

  def full_name
    "#{first_name} #{last_name}"
  end
  # first name is undefined so we need to 
  # generate a migration 
  # rails g migration add_name_to_users first_name:string last_name:string
  # run the migration using 
  # rake db:migrate

end
