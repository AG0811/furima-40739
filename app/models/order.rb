class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address

  attr_accessor :token

  validates :token, presence: true

  # price属性を追加
  attribute :price, :integer, default: 0
  # 注文を作成する際に価格を設定
  before_create :set_price

  private

  def set_price
    # アイテムが存在し、かつ価格が設定されている場合のみ、価格を設定する
    self.price = item.price if item.present? && item.price.present?
  end
end
