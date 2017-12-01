class User < ApplicationRecord
    validates :name, { presence: true, uniqueness: true }
    validates :email, { presence: true, uniqueness: true }
    validates :password, { presence: true }

    has_many :tasks, dependent: :delete_all
end
