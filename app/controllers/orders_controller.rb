class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_sold, only: [:index, :create]
  before_action :load_dropdowns, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    @order_address.token = params[:token]
    @order_address.item = @item # @itemをOrderAddressに渡す

    if @order_address.valid?
      logger.debug("OrderAddressの保存に成功しました！")
      pay_item
      @order_address.save
      redirect_to root_path
    else
      logger.debug("OrderAddressの保存に失敗しました。エラーメッセージ: #{@order_address.errors.full_messages.join(', ')}")
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find_by(id: params[:item_id]) || Item.find(1)
  end
  def redirect_if_sold
    if Order.exists?(item_id: @item.id)
      redirect_to root_path #, alert: 'この商品は既に売れています。'
    end
  end

  def order_address_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :municipalities, :address, :building_name, :phone_number, :price, :token).merge(user_id: current_user.id, item_id: @item.id, price: @item.price)
  end

  def pay_item
    Payjp.api_key = "sk_test_20b2d0ad9a7d354d28fe9fd8"
    Payjp::Charge.create(
      amount: @item.price,
      # card: order_address_params[:token],
      card: @order_address.token,
      currency: 'jpy'
    )
  end

  def load_dropdowns
    @prefectures = Pulldown::Prefecture.all
  end
end



# class OrdersController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_item
#   before_action :load_dropdowns, only: [:index, :create]

#   def index
#     @order = Order.new
#     @address = Address.new
#   end

#   def create
#     @order = Order.new(order_params)
#     @order.user = current_user
#     @order.item = @item
#     @address = @order.build_address(address_params)

#     if @order.valid? && @address.valid?
#       pay_item
#       @order.save
#       @address.save
#       redirect_to root_path
#     else
#       logger.debug("Orderの保存に失敗しました。")
#       render 'index', status: :unprocessable_entity
#     end
#   end

#   private

#   def set_item
#     # もし、itemがnilの場合、[1]とする
#     @item = Item.find_by(id: params[:item_id]) || Item.find(1)
#   end

#   def order_params
#     params.require(:order).permit(:user_id, :item_id).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
#   end

#   def address_params
#     params.require(:order).permit(:postcode, :prefecture_id, :municipalities, :address, :building_name, :phone_number)
#   end

#   def pay_item
#     Payjp.api_key = "sk_test_20b2d0ad9a7d354d28fe9fd8"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
#     Payjp::Charge.create(
#       amount: @item.price,  # 商品の値段
#       card: order_params[:token],    # カードトークン
#       currency: 'jpy'                 # 通貨の種類（日本円）
#     )
#   end

#   def load_dropdowns
#     @prefectures = Pulldown::Prefecture.all
#   end
# end