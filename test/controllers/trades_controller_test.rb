require 'test_helper'

class TradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trade = trades(:one)
  end

  test "should get index" do
    get trades_url
    assert_response :success
  end

  test "should get new" do
    get new_trade_url
    assert_response :success
  end

  test "should create trade" do
    assert_difference('Trade.count') do
      post trades_url, params: { trade: { fee: @trade.fee, money: @trade.money, price: @trade.price, stock_id: @trade.stock_id, tax: @trade.tax, tradingDate: @trade.tradingDate, tradingType: @trade.tradingType, user_id: @trade.user_id, volume: @trade.volume } }
    end

    assert_redirected_to trade_url(Trade.last)
  end

  test "should show trade" do
    get trade_url(@trade)
    assert_response :success
  end

  test "should get edit" do
    get edit_trade_url(@trade)
    assert_response :success
  end

  test "should update trade" do
    patch trade_url(@trade), params: { trade: { fee: @trade.fee, money: @trade.money, price: @trade.price, stock_id: @trade.stock_id, tax: @trade.tax, tradingDate: @trade.tradingDate, tradingType: @trade.tradingType, user_id: @trade.user_id, volume: @trade.volume } }
    assert_redirected_to trade_url(@trade)
  end

  test "should destroy trade" do
    assert_difference('Trade.count', -1) do
      delete trade_url(@trade)
    end

    assert_redirected_to trades_url
  end
end
