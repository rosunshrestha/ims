class ProductsController < ApplicationController

  before_action :set_product, only:[:show, :edit, :update, :destroy]

  def index
    @products = Category.find(params[:category_id]).products
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @category = Category.find(params[:category_id])
  end

  # GET /products/new
  def new
    @category = Category.find(params[:category_id])
    @product = Product.new
    @product.category_id = params[:category_id]


  end

  # GET /products/1/edit
  def edit
    @category = Category.find(params[:category_id])
  end

  # POST /products
  # POST /products.json
  def create
    @category = Category.find(params[:category_id])
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to category_products_path }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @category = Category.find(params[:category_id])
    respond_to do |format|
      if @product.update(product_params)
        flash[:notice] ='Product was successfully updated.'
        format.html { redirect_to category_products_path }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if @product.destroy

    respond_to do |format|
      format.js
      flash[:notice] = 'Product was successfully destroyed.'
      format.html { redirect_to category_products_url  }
      format.json { head :no_content }
    end
      end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :description, :price)
  end


end
