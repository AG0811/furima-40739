class Address < ApplicationRecord
  belongs_to :order

  # 以下のバリデーションはOrderAddressで行うため削除します
  # validates :postcode, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
  # validates :prefecture_id, presence: true, numericality: { other_than: 0, message: "can't be blank" }
  # validates :municipalities, presence: true
  # validates :phone_number, presence: true
  # validates :address, allow_blank: true
end
