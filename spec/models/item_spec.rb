require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'ユーザー商品出品登録' do
    context '商品が出品できるとき' do
      it '正常に登録できる' do
        expect(@item).to be_valid
      end
      it 'priceが￥300以上￥9,999,999以下だと登録できる' do
        @item.price = '10000'
        @item.valid?
        expect(@item).to be_valid
      end
      it 'priceが半角数字だと登録できる' do
        @item.price = '10000'
        @item.valid?
        expect(@item).to be_valid
      end
    end
    context '商品が出品出来ない時' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_nameが40文字以上では登録できない' do
        @item.item_name = '１２３４５' * 10
        @item.valid?
        expect(@item.errors.full_messages).to include('Item name is too long (maximum is 40 characters)')
      end
      it 'item_descriptionが空では登録できない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end
      it 'item_descriptionが1000字以上では登録できない' do
        @item.item_description = 'あいうえお' * 210
        @item.valid?
        expect(@item.errors.full_messages).to include('Item description is too long (maximum is 1000 characters)')
      end
      it 'category_idが空では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'item_condition_idが空では登録できない' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank")
      end
      it 'shipbase_idが空では登録できない' do
        @item.shipbase_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipbase can't be blank")
      end
      it 'shiparea_idが空では登録できない' do
        @item.shiparea_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shiparea can't be blank")
      end
      it 'shipdate_idが空では登録できない' do
        @item.shipdate_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipdate can't be blank")
      end
      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角数字以外だと登録できない' do
        @item.price = '１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが￥300以下だと登録できない' do
        @item.price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが￥9,999,999以上だと登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'userが紐づいていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
