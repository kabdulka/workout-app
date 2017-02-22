class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # this is a one to many association
  # so a user can have many exercises
  has_many :exercises
  validates :first_name, presence: true
  validates :last_name, presence: true
  self.per_page = 5

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

  def self.search_by_name(name) 
    names_array = name.split(' ')
    if names_array.size == 1
      where('first_name LIKE ? or last_name LIKE ?',
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else 
      where('first_name LIKE ? or first_name LIKE or ? last_name LIKE ? or last_name LIKE ?',
        "%#{names_array[0]}%", "%#{names_array[1]}%", "%#{names_array[0]}%", "%#{names_array[1]}%").order(:first_name)
    end
  end



end


