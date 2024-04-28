require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id, token: 'tok_valid00000000000000000')
  end

  describe '注文と住所の保存' do
    context '有効な情報の場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end

      it '建物名が空でも保存できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '無効な情報の場合' do
      it '郵便番号が空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors[:postal_code]).to include("can't be blank")
      end

      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors[:postal_code]).to include('is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県IDが「---」だと登録できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors[:prefecture_id]).to include("can't be blank")
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

      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと' do
        @order_address.phone_number = '090-1234-56'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is invalid. Input only number')
      end

      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（9桁です。）' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is too short')
      end

      it '電話番号が12桁以上では保存できないこと' do
        @order_address.phone_number = '0901234567890'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is too long')
      end

      it 'ユーザーが紐づいていない場合は保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors[:user_id]).to include("can't be blank")
      end

      it '商品が紐づいていない場合は保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors[:item_id]).to include("can't be blank")
      end
    end
  end
end
