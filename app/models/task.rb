class Task < ApplicationRecord
	belongs_to :user

	include RankedModel
	ranks :row_order

	validates :title, { presence: true }
	validates :status, { presence: true }
	validates :label, { presence: true }

	enum status: [:yet, :doing, :done]
	enum label: [:blue, :red, :yellow, :green]
	enum share: [:no, :yes]

	scope :yet, -> { where(status: "yet") }
	scope :doing, -> { where(status: "doing") }
	scope :done, -> { where(status: "done") }
	scope :share, -> { where(share: "yes") }
	scope :alert, -> { where(due_date: Date.today - 30..Date.today + 2) }

	scope :get_by_label, -> (label) {
			where(label: label)
	}

end
