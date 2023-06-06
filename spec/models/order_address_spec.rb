require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入登録' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:user)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    end

    context '商品が購入できるとき' do
      it '正常に登録できる' do
        expect(@order_address).to be_valid
      end
      it '建物名が空でも購入できること' do
        @order_address.apartment = ''
        expect(@order_address).to be_valid
      end
      it 'postalcodeは「3桁ハイフン4桁」の半角文字列だと登録できる' do
        @order_address.postalcode = '123-4567'
        @order_address.valid?
        expect(@order_address).to be_valid
      end
      it 'phone_numberが10桁以上11桁以内の半角数値だと登録できる' do
        @order_address.phone_number = '1234567890'
        @order_address.valid?
        expect(@order_address).to be_valid
      end
    end
    context '商品が出品出来ない時' do
      it 'postalcodeが空では登録できない' do
        @order_address.postalcode = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:postalcode]).to include("can't be blank")
      end
      it 'postalcodeは『3桁ハイフン4桁』半角英数字でないと保存できないこと' do
        @order_address.postalcode = '123-456７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postalcode Input correctly')
      end
      it 'shiparea_idが空では登録できない' do
        @order_address.shiparea_id = 1
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:shiparea_id]).to include("can't be blank")
      end
      it 'shipcityが空ではでは登録できない' do
        @order_address.shipcity = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:shipcity]).to include("can't be blank")
      end
      it 'shipaddressが空では登録できない' do
        @order_address.shipaddress = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:shipaddress]).to include("can't be blank")
      end
      it 'phone_numberが半角数値でないと購入できないこと' do
        @order_address.phone_number = '090123４1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end
      it 'phone_numberが空では登録できない' do
        @order_address.phone_number = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include("can't be blank")
      end
      it 'phone_numberが9桁で登録できない' do
        @order_address.phone_number = '123456789'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include('Input only number')
      end
      it 'phone_numberが12桁で登録できない' do
        @order_address.phone_number = '123456789012'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include('Input only number')
      end
      it 'userが紐づいていないと登録できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと登録できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
