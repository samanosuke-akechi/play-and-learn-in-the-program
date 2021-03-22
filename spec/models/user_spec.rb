require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができる時' do
      it 'すべての情報があれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録ができない時' do
      it 'emailが空だと保存できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれていないと保存できないこと' do
        @user.email = 'test-example'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空だと保存できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字未満だと保存できないこと' do
        @user.password = '11aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordは半角英字のみでは保存できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
      end
      it 'passwordは半角数字のみでは保存できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
      end
      it 'passwordは全角では保存できないこと' do
        @user.password = '１２３ａｂｃ'
        @user.password_confirmation = '１２３ａｂｃ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
      end
      it 'password_confirmationが空だと保存できないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致しないと保存できないこと' do
        @user.password = '789xyz'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end