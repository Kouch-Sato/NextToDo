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

	scope :yet, -> { where(status: "yet") }
	scope :doing, -> { where(status: "doing") }
	scope :done, -> { where(status: "done") }
	scope :alert, -> { where(due_date: Date.today - 30..Date.today + 2) }

	scope :get_by_label, -> (label) {
			where(label: label)
	}

	scope :desc, -> { order(created_at: :desc) }

end
