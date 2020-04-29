class StocksController < ApplicationController
  before_action :check_permission
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/new/list
  def new_list
    @user = User.new
    5.times { @user.stocks.build }
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)
    @stock.user_id = current_user.id

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /list/stocks
  # POST /list/stocks.json
  def create_list
    @user = User.new(user_params)
    respond_to do |format|
      if !validates_new_list
        format.html { render :new_list }
      else
        for stock in @user.stocks do
          if !stock.code.empty? && !stock.name.empty?
            stock.user_id = current_user.id
            if !stock.save
              flash[:alert] = 'An error occurred, please try again later.'
              format.html { render :new_list }
            end
          end
        end
        format.html { redirect_to stocks_url, notice: 'Stocks was successfully created.' }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Check permission to access
    def check_permission
      if current_user.nil?
        flash[:alert] = t('error.sign_in')
        redirect_to new_user_session_path
      else
        if !current_user.admin?
          flash[:alert] = t('error.permission')
          redirect_to root_path
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:code, :name, :registrationVolume, :outstandingVolume, :website, :industry)
    end

    # Stock list via user
    def user_params
      params.require(:user).permit(stocks_attributes: [:code, :name, :registrationVolume, :outstandingVolume, :website, :industry])
    end

    # validates for stocks list input
    def validates_new_list
      result = true
      stocks = Array.new
      for stock in @user.stocks do
        if !stock.code.empty?
          stocks.push(stock.code)
          if Stock.where(code: stock.code).exists?
            @user.errors.add(:code, "#{stock.code} is exists. Please input again")
            result = false
          end
          if stock.name.empty?
            @user.errors.add(:name, "can't is blank. Please input for name")
            result = false
          end
        end
        if !stock.name.empty?
          if stock.code.empty?
            @user.errors.add(:code, "can't is blank. Please input for code")
            result = false
          end
        end
      end
      if stocks.uniq.length != stocks.length
        @user.errors.add(:code, "is duplicated. Please input again")
        result = false
      end
      return result
    end
end
