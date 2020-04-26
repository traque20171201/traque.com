json.extract! trade, :id, :tradingDate, :tradingType, :volume, :price, :money, :fee, :tax, :user_id, :stock_id, :created_at, :updated_at
json.url trade_url(trade, format: :json)
