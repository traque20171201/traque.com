class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :destroy]

  # GET /trades
  # GET /trades.json
  def index
    @trades = Trade.where(user_id: current_user.id)
  end

  # GET /trades/1
  # GET /trades/1.json
  def show
  end

  # GET /trades/new
  def new
    @trade = Trade.new
  end

  # GET /trades/1/edit
  def edit
  end

  # POST /trades
  # POST /trades.json
  def create
    @trade = Trade.new(trade_params)
    @trade.user_id = current_user.id
    @trade.money = @trade.volume * @trade.price
    @trade.fee = @trade.money * 0.0015
    if @trade.tradingType == 2 #Sell have tax
      @trade.tax = @trade.money * 0.0010
    else
      @trade.tax = 0
    end

    respond_to do |format|
      if @trade.save
        format.html { redirect_to @trade, notice: 'Trade was successfully created.' }
        format.json { render :show, status: :created, location: @trade }
      else
        format.html { render :new }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1
  # PATCH/PUT /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to @trade, notice: 'Trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade }
      else
        format.html { render :edit }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trades/1
  # DELETE /trades/1.json
  def destroy
    @trade.destroy
    respond_to do |format|
      format.html { redirect_to trades_url, notice: 'Trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade
      @trade = Trade.where(["id = ? AND user_id = ?", params[:id], current_user.id]).first
      if @trade.nil?
        redirect_to trades_url, notice: 'Không có quyền truy cập hoặc dữ liệu không tồn tại.'
      end
    end

    # Only allow a list of trusted parameters through.
    def trade_params
      params.require(:trade).permit(:tradingDate, :tradingType, :volume, :price, :stock_id)
    end
end
