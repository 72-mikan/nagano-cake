require 'rails_helper'

RSpec.describe Public::HomesController, type: :controller do
  describe "topページのテスト" do
    context "正常のテスト" do
      it "レスポンスが正常であるか？" do
        get :top
        expect(response).to be_successful
      end
    end
  end
end
