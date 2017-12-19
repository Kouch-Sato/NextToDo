class User < ApplicationRecord
  validates :name, { presence: true, uniqueness: true }
  validates :email, { presence: true, uniqueness: true }
  validates :password, { presence: true }
  validates :role, { presence: true }

  enum role: [:not_admin, :admin]

  has_many :tasks, dependent: :delete_all
  has_and_belongs_to_many :groups
  mount_uploader :image, ImageUploader
end
