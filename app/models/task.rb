class Task < ApplicationRecord
  attribute :completed, :boolean, default: false
  validates :description, presence: true
end
