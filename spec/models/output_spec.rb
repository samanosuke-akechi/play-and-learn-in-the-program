require 'rails_helper'

RSpec.describe Output, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @output = FactoryBot.build(:output, user_id: @user.id)
  end

  describe 'アウトプット投稿機能' do
    context 'アウトプット投稿が登録できる時' do
      it 'すべての情報があれば登録できる' do
        expect(@output).to be_valid
      end
    end

    context 'アウトプット投稿が登録できない時' do
      it 'titleが空だと登録できないこと' do
        @output.title = ""
        @output.valid?
        expect(@output.errors.full_messages).to include("Title can't be blank")
      end
      it 'textが空だと登録できないこと' do
        @output.text = ""
        @output.valid?
        expect(@output.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
end