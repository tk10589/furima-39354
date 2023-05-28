require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '正常に登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = 't111111'
        @user.password_confirmation = 't111111'
        expect(@user).to be_valid
      end
      it 'fnameとlnameが全角であれば登録できる' do
        @user.fname = '佐藤'
        @user.lname = 'タカシ'
        expect(@user).to be_valid
      end
      it 'fname_kanaとlname_kanaが全角であれば登録できる' do
        @user.fname_kana = 'サトウ'
        @user.lname_kana = 'タカシ'
        expect(@user).to be_valid
      end
    end
    context '新規登録出来ない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが数字だけだと登録できない' do
        @user.password = '11111111'
        @user.password_confirmation = '11111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが英字だけだと登録できない' do
        @user.password = 'testtest'
        @user.password_confirmation = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが全角だと登録できない' do
        @user.password = 'ＡＢＣａｂｃ'
        @user.password_confirmation = 'ＡＢＣａｂｃ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordとconfirmが一致していないと登録できない' do
        @user.password = 't111111'
        @user.password_confirmation = 't111112'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが英数字混合でも6文字未満なら登録できない' do
        @user.password = 'test1'
        @user.password_confirmation = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailには@が含まれていないと登録できない' do
        @user.email = 'test001'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'fnameが空では登録できない' do
        @user.fname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Fname can't be blank", 'Fname is invalid')
      end
      it 'fnameが半角では登録できない' do
        @user.fname = 'satou'
        @user.valid?
        expect(@user.errors.full_messages).to include('Fname is invalid')
      end
      it 'lnameが空では登録できない' do
        @user.lname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lname can't be blank", 'Lname is invalid')
      end
      it 'lnameが半角では登録できない' do
        @user.lname = 'takashi'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lname is invalid')
      end
      it 'fname_kanaが空では登録できない' do
        @user.fname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Fname kana can't be blank", 'Fname kana is invalid')
      end
      it 'fname_kanaが半角では登録できない' do
        @user.fname_kana = 'ｻﾄｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Fname kana is invalid')
      end
      it 'lname_kanaが空では登録できない' do
        @user.lname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Lname kana is invalid')
      end
      it 'lname_kanaが半角では登録できない' do
        @user.lname_kana = 'ﾀｶｼ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lname kana is invalid')
      end
      it 'birthdateが空では登録できない' do
        @user.birthdate = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdate can't be blank")
      end
    end
  end
end
