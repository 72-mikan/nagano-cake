require 'rails_helper'

RSpec.describe "Public::AfterLogins", type: :system do
  before do
    driven_by(:rack_test)
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
  
  it "新規登録ができる" do
    visit root_path
    expect {
      click_link "新規登録"
      fill_in "customer[last_name]", with: "田中"
      fill_in "customer[first_name]", with: "太郎"
      fill_in "customer[last_name_kana]", with: "タナカ"
      fill_in "customer[first_name_kana]", with: "タロウ"
      fill_in "customer[email]", with: "tester@example.com"
      fill_in "customer[postal_code]", with: "1500043"
      fill_in "customer[address]", with: "東京都渋谷区道玄坂２丁目１"
      fill_in "customer[telephone_number]", with: "00011112222"
      fill_in "customer[password]", with: "testabcd"
      fill_in "customer[password_confirmation]", with: "testabcd"
      click_button "Sign up"
    }.to change(Customer, :count).by(1)
  end
  
  # it "ログインができる" do
  #   customer = FactoryBot.create(:customer)
  #   visit root_path
  #   click_link "ログイン"
  #   fill_in "customer[email]", with: customer.email
  #   fill_in "customer[password]", with: customer.password
  #   click_button "Log in"
  #   expect(session[:customer_id]).to eq customer.id
  # end
end
