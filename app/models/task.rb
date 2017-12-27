class Task < ApplicationRecord
	belongs_to :user
	belongs_to :group

	include RankedModel
	ranks :row_order

	validates :title, { presence: true }
	validates :status, { presence: true }
	validates :label, { presence: true }

	enum status: [:yet, :doing, :done]
	enum label: [:blue, :red, :yellow, :green]

	scope :alert, -> { where(due_date: Date.today - 30..Date.today + 2) }
	scope :desc, -> { order(created_at: :desc) }
	scope :get_by_label, -> (label) {
			where(label: label)
	}

	mount_uploader :file, FileUploader

end
