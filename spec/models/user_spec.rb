require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '正常系' do
      it 'すべての値が必須であること' do
        expect(@user).to be_valid
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'hogehoge@hugahuga'
        expect(@user).to be_valid
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '123abc'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = '123abc'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end
    context '異常系' do
      it 'ユーザーネームが必須であること' do
        @user.user_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "User name can't be blank"
      end
      it 'ユーザーネームが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.user_name = @user.user_name
        another_user.valid?
        expect(another_user.errors.full_messages).to include('User name has already been taken')
      end
      it '名前が必須であること' do
        @user.full_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Full name can't be blank"
      end
      it '社名が必須であること' do
        @user.corp_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Corp name can't be blank"
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '123ab'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end
      it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'パスワードは全角では登録できないこと' do
        @user.password = '１２３ＡＢＣ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end
    end
  end
end