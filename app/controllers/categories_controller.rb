class CategoriesController < ApplicationController
  before_action :set_category, only:[:show, :edit, :update, :destroy]
  before_action :custom_authentication
  before_action :set_language
  #before_action :authenticate_user!
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all

  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])
  end

  # GET /category/new
  def new
    @category = Category.new
    3.times { @category.products.build
    }
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        flash[:notice] = t('cat_message_create')
        UserMailer.send_email(@category.products,current_user).deliver
        format.html { redirect_to categories_path}
        format.json { render :show, status: :created, location: @category}
      else
        format.html { render :new}
        format.json { render json: @category.errors, status: :unprocessable_entity}
      end
    end
  end


  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        flash[:notice] = t('cat_message_update')
        format.html { redirect_to categories_path }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if @category.destroy
    respond_to do |format|
      flash[:notice] = t('cat_message_delete')
      format.html { redirect_to categories_path }
      format.json { head :no_content }
    end
      end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
      @category = Category.find(params[:id])
    end

  def custom_authentication
    # binding.pry
      raise AccessDenied unless current_user
  end

  def set_language

    begin

          I18n.locale = params[:locale]
          session[:language] = I18n.locale

    rescue I18n::InvalidLocale
      I18n.locale = session[:language]
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
  # params.require(:category).permit(:name)
    params.require(:category).permit(:name, products_attributes:
                                              [:name, :description, :price,:id])
  end

end

