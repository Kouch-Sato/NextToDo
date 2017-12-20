class Group < ApplicationRecord
	has_and_belongs_to_many :users
	has_many :tasks
	validates :name, { presence: true, uniqueness: true }
end
