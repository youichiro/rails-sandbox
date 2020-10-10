class Task < ApplicationRecord
  validate :name, presence: true, length: { maximum: 100 }
end
