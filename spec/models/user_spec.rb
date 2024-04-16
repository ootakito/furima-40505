require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = FactoryBot.build(:user, nickname: '')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      user = FactoryBot.build(:user, email: '')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailは@を含まないと登録できない' do
      user = FactoryBot.build(:user, email: 'invalid_email')
      user.valid?
      expect(user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できない' do
      user = FactoryBot.build(:user, password: '')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字未満では登録できない' do
      user = FactoryBot.build(:user, password: '12345')
      user.valid?
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordは半角英数字混合でないと登録できない' do
      user = FactoryBot.build(:user, password: 'password')
      user.valid?
      expect(user.errors.full_messages).to include('Password is invalid')
    end

    it 'last_nameが空では登録できない' do
      user = FactoryBot.build(:user, last_name: '')
      user.valid?
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'first_nameが空では登録できない' do
      user = FactoryBot.build(:user, first_name: '')
      user.valid?
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last_name_kanaが空では登録できない' do
      user = FactoryBot.build(:user, last_name_kana: '')
      user.valid?
      expect(user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'first_name_kanaが空では登録できない' do
      user = FactoryBot.build(:user, first_name_kana: '')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'last_name_kanaはカタカナでないと登録できない' do
      user = FactoryBot.build(:user, last_name_kana: '山田')
      user.valid?
      expect(user.errors.full_messages).to include('Last name kana is invalid')
    end

    it 'first_name_kanaはカタカナでないと登録できない' do
      user = FactoryBot.build(:user, first_name_kana: '太郎')
      user.valid?
      expect(user.errors.full_messages).to include('First name kana is invalid')
    end

    it 'birthdateが空では登録できない' do
      user = FactoryBot.build(:user, birthdate: '')
      user.valid?
      expect(user.errors.full_messages).to include("Birthdate can't be blank")
    end
  end
end
