require "application_system_test_case"

class TradesTest < ApplicationSystemTestCase
  setup do
    @trade = trades(:one)
  end

  test "visiting the index" do
    visit trades_url
    assert_selector "h1", text: "Trades"
  end

  test "creating a Trade" do
    visit trades_url
    click_on "New Trade"

    fill_in "Fee", with: @trade.fee
    fill_in "Money", with: @trade.money
    fill_in "Price", with: @trade.price
    fill_in "Stock", with: @trade.stock_id
    fill_in "Tax", with: @trade.tax
    fill_in "Tradingdate", with: @trade.tradingDate
    fill_in "Tradingtype", with: @trade.tradingType
    fill_in "User", with: @trade.user_id
    fill_in "Volume", with: @trade.volume
    click_on "Create Trade"

    assert_text "Trade was successfully created"
    click_on "Back"
  end

  test "updating a Trade" do
    visit trades_url
    click_on "Edit", match: :first

    fill_in "Fee", with: @trade.fee
    fill_in "Money", with: @trade.money
    fill_in "Price", with: @trade.price
    fill_in "Stock", with: @trade.stock_id
    fill_in "Tax", with: @trade.tax
    fill_in "Tradingdate", with: @trade.tradingDate
    fill_in "Tradingtype", with: @trade.tradingType
    fill_in "User", with: @trade.user_id
    fill_in "Volume", with: @trade.volume
    click_on "Update Trade"

    assert_text "Trade was successfully updated"
    click_on "Back"
  end

  test "destroying a Trade" do
    visit trades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trade was successfully destroyed"
  end
end
