require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  context '有効な場合' do
    it '必要な情報が全て存在すれば登録できる' do
      expect(@item).to be_valid
    end
  end

  context '無効な場合' do
    it '商品名が空だと登録できない' do
      @item.name = nil
      @item.valid?
      expect(@item.errors[:name]).to include("can't be blank")
    end

    it 'カテゴリーが「---」だと登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors[:category_id]).to include("can't be blank")
    end

    it '商品の状態が「---」だと登録できない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors[:condition_id]).to include("can't be blank")
    end

    it '送料負担が「---」だと登録できない' do
      @item.shipping_cost_burden_id = 1
      @item.valid?
      expect(@item.errors[:shipping_cost_burden_id]).to include("can't be blank")
    end

    it '発送元の地域が「---」だと登録できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors[:prefecture_id]).to include("can't be blank")
    end

    it '発送までの日数が「---」だと登録できない' do
      @item.shipping_duration_id = 1
      @item.valid?
      expect(@item.errors[:shipping_duration_id]).to include("can't be blank")
    end

    it '価格が¥300未満の場合登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors[:price]).to include('must be greater than or equal to 300')
    end

    it '価格が¥9,999,999を超える場合登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors[:price]).to include('must be less than or equal to 9999999')
    end

    it '価格が半角数字以外だと登録できない' do
      @item.price = '五千円'
      @item.valid?
      expect(@item.errors[:price]).to include('is not a number')
    end

    it '画像が添付されていないと登録できない' do
      @item.image.detach # 画像をデタッチしてテスト
      @item.valid?
      expect(@item.errors[:image]).to include("can't be blank")
    end

    it '商品説明が空だと登録できない' do
      @item.description = nil
      @item.valid?
      expect(@item.errors[:description]).to include("can't be blank")
    end

    it '価格が空だと登録できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors[:price]).to include("can't be blank")
    end

    it 'userが紐付いていなければ登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors[:user]).to include('must exist')
    end
  end
end
