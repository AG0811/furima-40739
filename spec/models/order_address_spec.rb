# spec/models/order_address_spec.rb
require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe 'バリデーション' do
    context '有効な属性の場合' do
      it 'すべての属性が有効であること' do
        expect(@order_address).to be_valid
      end
    end

    context '無効な属性の場合' do
      it 'トークンがないと無効であること' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号がないと無効であること' do
        @order_address.postcode = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
      end

      it '郵便番号の形式が正しくないと無効であること' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '都道府県IDがないと無効であること' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県IDが0だと無効であること' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県IDが1だと無効であること' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村がないと無効であること' do
        @order_address.municipalities = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '住所がないと無効であること' do
        @order_address.address = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号がないと無効であること' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が短すぎると無効であること' do
        @order_address.phone_number = '090123'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too short")
      end

      it '電話番号の形式が正しくないと無効であること' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only numbers")
      end
    end
  end
end
