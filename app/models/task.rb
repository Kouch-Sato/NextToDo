class Task < ApplicationRecord
    belongs_to :user

    validates :title, { presence: true }
    validates :status, { presence: true }
    validates :label, { presence: true }

    enum status: [:yet, :doing, :done]
    enum label: [:red, :yellow, :green, :blue]
    enum share: [:no, :yes]

    scope :yet, -> { where(status: "yet") }
    scope :doing, -> { where(status: "doing") }
    scope :done, -> { where(status: "done") }
    scope :share, -> { where(share: "yes") }

    scope :get_by_label, -> (label) {
        where(label: label)
    }

end
