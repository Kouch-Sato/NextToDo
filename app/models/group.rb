class Group < ApplicationRecord
	has_and_belongs_to_many :users
	has_many :tasks

	include RankedModel
	ranks :row_order
	
	validates :name, { presence: true, uniqueness: true }
end
