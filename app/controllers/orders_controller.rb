class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_sold, only: [:index, :create]
  before_action :load_dropdowns, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new

    # カレントユーザーと@itemの所有者のIDが一致した場合、root_pathにリダイレクトする
    redirect_to root_path if current_user.id == @item.user_id
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    @order_address.token = params[:token]
    @order_address.item = @item # @itemをOrderAddressに渡す

    if @order_address.valid?
      logger.debug('OrderAddressの保存に成功しました！')
      pay_item
      @order_address.save
      redirect_to root_path
    else
      logger.debug("OrderAddressの保存に失敗しました。エラーメッセージ: #{@order_address.errors.full_messages.join(', ')}")
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end

  def redirect_if_sold
    return unless Order.exists?(item_id: @item.id)

    redirect_to root_path # , alert: 'この商品は既に売れています。'
  end

  def order_address_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :municipalities, :address, :building_name, :phone_number, :price, :token).merge(
      user_id: current_user.id, item_id: @item.id, price: @item.price
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      # card: order_address_params[:token],
      card: @order_address.token,
      currency: 'jpy'
    )
  end

  def load_dropdowns
    @burdens = Pulldown::Burden.all
    @prefectures = Pulldown::Prefecture.all
  end
end
