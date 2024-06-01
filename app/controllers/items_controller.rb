class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :load_dropdowns, only: [:new, :create, :edit, :update, :show]

  def index
    @items = Item.order(created_at: :desc)
    load_dropdowns
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def new
    @item = Item.new
  end

  def create
    # @item = Item.new(item_params)
    # if @item.save
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def authorize_user!
    return if current_user == @item.user

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

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
