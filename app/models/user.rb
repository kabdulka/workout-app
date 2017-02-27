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
  has_many :friendships
  # Note: we don't have a table or a model for friends
  # they're still users but since we're referring to them
  # as friends we need to specify that it is the class of 
  # user (this is bending the convention of Rails)
  # therefore, we need to specify the class name (user in this case)
  has_many :friends, through: :friendships, class_name: "User"

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

  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end

end


