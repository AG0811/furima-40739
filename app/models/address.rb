class Address < ApplicationRecord
  belongs_to :order

  validates :postcode, presence: true
  validates :prefecture_id, presence: true
  validates :municipalities, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
end