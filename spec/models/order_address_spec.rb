require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '注文と住所の保存' do
    context '有効な情報の場合' do
      before do
        @user = FactoryBot.create(:user)
        @item = FactoryBot.create(:item, name: 'テストアイテム', price: 1000)
        @order_address = OrderAddress.new(
          user_id: @user.id,
          item_id: @item.id,
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '東京都',
          address: '中央区1-1-1',
          phone_number: '09012345678'
        )
      end

      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
    end

    context '無効な情報の場合' do
      it '郵便番号が空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors[:postal_code]).to include("can't be blank")
      end

      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors[:postal_code]).to include('is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県IDが「---」だと登録できない' do
        order_address = OrderAddress.new(prefecture_id: 1)
        order_address.valid?
        expect(order_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it '市区町村が空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors[:city]).to include("can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors[:address]).to include("can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include("can't be blank")
      end

      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（11桁です。）' do
        @order_address.phone_number = '090-1234-56'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is invalid. Input only number')
      end

      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（9桁です。）' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is too short')
      end
    end
  end
end
