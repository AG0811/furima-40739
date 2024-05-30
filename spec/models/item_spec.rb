require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品新規登録' do
    it '必要な情報が適切に存在すれば登録できる' do
      expect(@item).to be_valid
    end
  end

  context '新規登録できない場合' do
    it 'item_nameが空では登録できない' do
      @item.item_name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Item name can't be blank")
    end
    it 'item_nameが40文字を超えると登録できない' do
      @item.item_name = 'a' * 41
      @item.valid?
      expect(@item.errors.full_messages).to include('Item name is too long (maximum is 40 characters)')
    end
    it 'item_descriptionが空では登録できない' do
      @item.item_description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Item description can't be blank")
    end
    it 'item_descriptionが1000文字を超えると登録できない' do
      @item.item_description = 'a' * 1001
      @item.valid?
      expect(@item.errors.full_messages).to include('Item description is too long (maximum is 1000 characters)')
    end
    it 'category_idが空では登録できない' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it 'category_idが1では登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it 'condition_idが空では登録できない' do
      @item.condition_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end
    it 'condition_idが1では登録できない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end
    it 'burden_idが空では登録できない' do
      @item.burden_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Burden can't be blank")
    end
    it 'burden_idが1では登録できない' do
      @item.burden_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Burden can't be blank")
    end
    it 'prefecture_idが空では登録できない' do
      @item.prefecture_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'prefecture_idが1では登録できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'days_idが空では登録できない' do
      @item.days_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Days can't be blank")
    end
    it 'days_idが1では登録できない' do
      @item.days_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Days can't be blank")
    end
    it 'priceが空では登録できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it 'priceが300未満では登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be a number between 300 and 9,999,999')
    end

    it 'priceが9,999,999より大きいと登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be a number between 300 and 9,999,999')
    end

    it 'priceが半角数値でなければ登録できない' do
      @item.price = 'a'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be a number between 300 and 9,999,999')
    end
  end
end
