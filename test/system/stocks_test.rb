require "application_system_test_case"

class StocksTest < ApplicationSystemTestCase
  setup do
    @stock = stocks(:one)
  end

  test "visiting the index" do
    visit stocks_url
    assert_selector "h1", text: "Stocks"
  end

  test "creating a Stock" do
    visit stocks_url
    click_on "New Stock"

    fill_in "Code", with: @stock.code
    fill_in "Industry", with: @stock.industry
    fill_in "Name", with: @stock.name
    fill_in "Outstandingvolume", with: @stock.outstandingVolume
    fill_in "Registrationvolume", with: @stock.registrationVolume
    fill_in "Website", with: @stock.website
    click_on "Create Stock"

    assert_text "Stock was successfully created"
    click_on "Back"
  end

  test "updating a Stock" do
    visit stocks_url
    click_on "Edit", match: :first

    fill_in "Code", with: @stock.code
    fill_in "Industry", with: @stock.industry
    fill_in "Name", with: @stock.name
    fill_in "Outstandingvolume", with: @stock.outstandingVolume
    fill_in "Registrationvolume", with: @stock.registrationVolume
    fill_in "Website", with: @stock.website
    click_on "Update Stock"

    assert_text "Stock was successfully updated"
    click_on "Back"
  end

  test "destroying a Stock" do
    visit stocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stock was successfully destroyed"
  end
end
