class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :delete_image, :add_image, :add_block, :remove_block]
  include PageMeta

  load_and_authorize_resource

  # GET /pages
  # GET /pages.json
  def index
    if @current_website.present?
      @pages = @current_website.pages
    else
      @pages = Page.all
    end
    render layout: "themes/basic/layout"
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if @page.redirectable_url.present?
      redirect_to @page.redirectable_url
    else
      render layout: "themes/basic/layout"
    end
  end

  # GET /pages/new
  def new
    session[:return_to] = params[:return_to] if params[:return_to].present?

    @page = Page.new
    @page.website_id = @current_website.id if @current_website.present?
    @page.category_ids = params[:category_ids].present? ? params[:category_ids] : nil
    @page.is_published = true
    render layout: "themes/basic/layout"
  end

  # GET /pages/1/edit
  def edit
    session[:return_to] = params[:return_to] if params[:return_to].present?

    render layout: "themes/basic/layout"
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    @page.website_id = @current_website.id if @current_website.id.present?

    respond_to do |format|
      if @page.save
        format.html { redirect_to session.delete(:return_to) || @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
        format.js { render :update }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @page.slug = nil
    @page.category_ids = params[:category_ids].present? ? params[:category_ids] : nil

    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to session.delete(:return_to) || @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
        format.js { render :update }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  def delete_image
    @image = Image.find(params[:image_id])
    @image.destroy
  end

  def add_image
    @image = Image.new(image_params)
    @image.save
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to) || '/', notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      if @current_website.present?
        begin
          @page = @current_website.pages.find_by(slug: params[:id])
          if !@page.present?
            @page = @current_website.pages.friendly.find(params[:id])
          end
        rescue
          redirect_to '/', status: 404, notice: 'This is not the page you are looking for...move along.'
        end
      else
        redirect_to '/'
      end
      @resource = @page
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :display_name, :subtitle, :description, :is_homepage, :about, :website_id, :position, :page_id, :is_published, :show_sub_menu, :redirectable_id, :redirectable_type, :redirectable_url, :show_in_menu, {:category_ids=>[]})
    end

    def image_params
      params.permit(:asset, :type, :attachable_id, :attachable_type, :attachable, :name, :about, :link, :position, :link_text)
    end

end
