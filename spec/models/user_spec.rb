require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザ新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '全ての情報が正しく入力されていれば保存できる' do
      expect(@user).to be_valid
    end
    it 'ニックネームが空だと保存できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'ニックネームが「test」から始まると保存できない' do
      @user.nickname = 'test' + @user.nickname
      @user.valid?
      expect(@user.errors.full_messages).to include('Nickname is invalid')
    end
    it 'すでに登録済みのニックネームは登録できない' do
      another_user = FactoryBot.create(:user)
      @user.nickname = another_user.nickname
      @user.invalid?
      expect(@user.errors.full_messages).to include('Nickname has already been taken')
    end
    it 'パスワードが空だと保存できない' do
      @user.password = ''
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードが5文字以下だと保存できない' do
      @user.password = Faker::Internet.password(min_length: 2, max_length: 5)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードとパスワード確認用が一致しないと保存できない' do
      @user.password_confirmation = FactoryBot.build(:user).password_confirmation
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
