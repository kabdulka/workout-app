class Friendship < ActiveRecord::Base
  # We need to specify a Friend model
  # It's still user as of now
  belongs_to :user
  belongs_to :friend, class_name: "User"

end
