class Exercise < ActiveRecord::Base
	#because we did references user we have a belongs_to :user
  belongs_to :user
end
