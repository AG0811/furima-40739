class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def new
    @item = Item.new
    load_dropdowns
  end

  def create
    # @item = Item.new(item_params)
    # if @item.save
    @item = Item.create(item_params)
    if @item.persisted?
      redirect_to root_path
    else
      load_dropdowns
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :category_id, :condition_id, :burden_id, :prefecture_id,
                                 :days_id, :price, :image).merge(user_id: current_user.id)
  end

  def load_dropdowns
    @categories = Pulldown::Category.all
    @conditions = Pulldown::Condition.all
    @burdens = Pulldown::Burden.all
    @prefectures = Pulldown::Prefecture.all
    @days = Pulldown::Days.all
  end
end
