class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.order(created_at: :desc)
    load_dropdowns
  end

  def show
    set_item
    load_dropdowns
  end
  def edit
    if current_user != @item.user
      redirect_to root_path
    else
      set_item
      load_dropdowns
    end
  end
  def update
    set_item
    if current_user != @item.user
      redirect_to root_path
    elsif @item.update(item_params)
      redirect_to item_path(@item)
    else
      load_dropdowns
      render 'edit', status: :unprocessable_entity
    end
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
