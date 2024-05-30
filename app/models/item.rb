class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, class_name: 'Pulldown::Category'
  belongs_to_active_hash :condition, class_name: 'Pulldown::Condition'
  belongs_to_active_hash :burden, class_name: 'Pulldown::Burden'
  belongs_to_active_hash :prefecture, class_name: 'Pulldown::Prefecture'
  belongs_to_active_hash :days, class_name: 'Pulldown::Days'

  belongs_to :user
   # has_one :transaction
  has_one_attached :image

  validates :image, presence: { message: "can't be blank" }
  validates :item_name, presence: { message: "can't be blank" }, length: { maximum: 40, message: "is too long (maximum is 40 characters)" }
  validates :item_description, presence: { message: "can't be blank" }, length: { maximum: 1000, message: "is too long (maximum is 1000 characters)" }
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :burden_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :days_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: { message: "can't be blank" },
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "must be a number between 300 and 9,999,999" }
end