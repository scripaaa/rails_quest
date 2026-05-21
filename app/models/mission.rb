class Mission < ApplicationRecord
  belongs_to :agent

  enum :status, {
    assigned: "assigned",
    pending: "pending",
    in_progress: "in_progress",
    completed: "completed"
  }

  validates :title, presence: true
  validates :status, presence: true
end