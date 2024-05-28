require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できる場合' do
      it "nicknameとemail、passwordとpassword_confirmation、first_nameとlast_name、read_firstとread_last、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      # 空がある場合
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "password_confirmationが空では登録できない" do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "read_firstが空では登録できない" do
        @user.read_first = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first can't be blank")
      end
      it "read_lastが空では登録できない" do
        @user.read_last = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Read last can't be blank")
      end
      it "birthdayが空では登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      # 間違いがある場合
      it "emailが重複する場合登録できない" do
        FactoryBot.create(:user, email: 'test@example.com')
        user = FactoryBot.build(:user, email: 'test@example.com')
        user.valid?
        expect(user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailに無効なメールアドレス形式を使用している場合登録できない" do
        @user.email = "invalid_email"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordに英字が無い場合登録できない" do
        @user.password = "123456" # 英字が含まれていないパスワード
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "passwordに数字が無い場合登録できない" do
        @user.password = "abcdef" # 数字が含まれていないパスワード
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "passwordが6文字未満の場合登録できない" do
        @user.password = 'test1'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordとpassword_confirmationが一致しない場合登録できない" do
        @user.password = 'password1'
        @user.password_confirmation = 'wrong_password1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "first_nameに全角以外の文字が含まれている場合に登録できない" do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it "last_nameに全角以外の文字が含まれている場合に登録できない" do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it "read_firstにカタカナ以外の文字が含まれている場合に登録できない" do
        @user.read_first = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first is invalid. Input full-width katakana characters")
      end
      it "read_lastにカタカナ以外の文字が含まれている場合に登録できない" do
        @user.read_last = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read last is invalid. Input full-width katakana characters")
      end
      it "無効な日付形式をbirthdayとして指定した場合に登録できない" do
        @user.birthday = 'invalid_date'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday is invalid")
      end
    end
  end
end