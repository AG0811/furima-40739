class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :municipalities, :address, :building_name, :phone_number, :item_id, :user_id, :price, :token, :item

  with_options presence: true do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is invalid' }
    validates :user_id, :item_id, :token
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :municipalities, :address
    validates :phone_number, length: { in: 10..11, message: "is too short" }, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only numbers" }
  end

  validate :validate_prefecture_id

  def validate_prefecture_id
    if prefecture_id.nil? || prefecture_id == 0 || prefecture_id == 1
      errors.add(:prefecture_id, "can't be blank")
    end
  end

  def save
    return false unless token.present? && item.present? && item.price.present?
  
    order = Order.create(user_id: user_id, item_id: item_id, price: price, token: token)
    unless order.persisted?
      logger.debug("Orderの保存に失敗しました。エラーメッセージ: #{order.errors.full_messages.join(', ')}")
      return false
    end
  
    Address.create(
      postcode: self.postcode,
      prefecture_id: self.prefecture_id,
      municipalities: self.municipalities,
      address: self.address,
      building_name: self.building_name,
      phone_number: self.phone_number,
      order_id: order.id
    )
  end
end
