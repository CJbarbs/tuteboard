class Category < ActiveRecord::Base
	has_many :messages
end
