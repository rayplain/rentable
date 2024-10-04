class Unit < ApplicationRecord
  belongs_to :property
  validates :bedroom_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bathroom_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :square_footage, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :rent_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :property, presence: true
end