class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :search]
  load_and_authorize_resource except: [:search, :create]
  include PageMeta

  # GET /categories
  # GET /categories.json
  def index
    @categories = @current_website.categories.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    order = params[:order].present? ? params[:order] : 'pages.created_at DESC'
    @pages = @category.pages.includes(:categories).page(params[:page]).reorder(order)
  end

  def search
    order = params[:order].present? ? params[:order] : 'pages.created_at DESC'
    @pages = @category.pages.where('lower(description) LIKE :term OR lower(name) LIKE :term OR lower(about) LIKE :term', term: "%#{params[:term].downcase.strip}%").page(params[:page]).reorder(order)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.website_id = @current_website.id
    authorize! :manage, @category.website

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
        format.js { render :update }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category.slug = nil
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
        format.js { render :update }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      if @current_website.present?
        begin
          @category = @current_website.categories.includes(:pages, :categories).find_by(slug: params[:id])
          if !@category.present?
            @category = @current_website.categories.includes(:pages, :categories).friendly.find(params[:id])
          end
        rescue
          redirect_to '/', status: 302, notice: 'This is not the page you are looking for...move along.'
        end
      else
        redirect_to '/'
      end
      @resource = @category
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :about, :subtitle, :description, :category_id, {:page_ids=>[]}, :continue_edit)
    end
end
