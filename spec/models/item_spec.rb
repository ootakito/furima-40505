require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
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

    it '価格が10,000,000円以上だと登録できない' do
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
      @item.image.detach
      @item.valid?
      expect(@item.errors[:image]).to include("can't be blank")
    end
  end
end
