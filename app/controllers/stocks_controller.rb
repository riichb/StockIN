class StocksController < ApplicationController
  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @stock = Stock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stock }
    end
  end

  # GET /stocks/new
  # GET /stocks/new.json
  def new
    @stock = Stock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stock }
    end
  end

  # GET /stocks/1/edit
  def edit
    @stock = Stock.find(params[:id])
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(params[:stock])

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render json: @stock, status: :created, location: @stock }
      else
        format.html { render action: "new" }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stocks/1
  # PUT /stocks/1.json
  def update
    @stock = Stock.find(params[:id])

    respond_to do |format|
      if @stock.update_attributes(params[:stock])
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end

  # POST /stocks/1
  def checkout 
    @stock = Stock.find(params[:id])

    if @stock.quantity <= 15
      UserMailer.low_stock_email(@stock).deliver
    end

    respond_to do |format|
      if @stock.quantity <= 0
        format.html { redirect_to stocks_url, notice: 'No Inventory. ' }
      elsif @stock.update_attributes(:quantity => (@stock.quantity - 1))
        format.html { redirect_to stocks_url, notice: 'Successfully updated inventory.' }
      else
        format.html { redirect_to stocks_url, notice: 'Failed to update inventory.' }
      end
    end
  end

  def report
    @stocks = Stock.all

    respond_to do |format| 
      format.html
      format.json { render json: @stocks }
    end
  end

  def add
    respond_to do |format|
      format.html
    end
  end

  def add_multiple 
    @stock = Stock.find(params[:stock]['id']) 
    @new_quantity = params[:stock]['quantity'].to_i
    
    respond_to do |format|
      if (@new_quantity <= 0)
        format.html { render action: "add", notice: 'Invalid quantity' }
      elsif @stock.update_attributes(:quantity => (@stock.quantity + @new_quantity))
        format.html { redirect_to stocks_url, notice: 'Successfully updated inventory.' }
      else
        format.html { redirect_to stocks_url, notice: 'Failed to update inventory.' }
      end
    end
  end

  def search 
    #@stocks = Stock.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    @stocks = Stock.all.map(&:name).compact.reject(&:blank?)

    respond_to do |format| 
      format.html
      format.js
    end
  end

end
