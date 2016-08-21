class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :delete_image, :add_image, :add_block, :remove_block]
  load_and_authorize_resource

  # GET /pages
  # GET /pages.json
  def index
    if @current_website.present?
      @pages = @current_website.pages
    else
      @pages = Page.all
    end
    render layout: "themes/#{@current_website.theme}/layout"
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    render layout: "themes/#{@current_website.theme}/layout"
  end

  def edit_block
    @block = Block.find(params[:block_id])
  end

  def save_block
    @block = Block.find(params[:block_id])
    @block.save(block_params)
  end

  def add_block
    new_block_ids = @page.block_ids + [ params[:block_id].to_i ]
    @page.update(block_ids: new_block_ids)
    render :update
  end

  def remove_block
    new_block_ids = @page.block_ids - [ params[:block_id].to_i ]
    @page.update(block_ids: new_block_ids)
    render :update
  end

  # GET /pages/new
  def new
    @page = Page.new
    @page.website_id = params[:website_id] if params[:website_id].present?
    render layout: "themes/#{@current_website.theme}/layout"
  end

  # GET /pages/1/edit
  def edit
    render layout: "themes/#{@current_website.theme}/layout"
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @page.slug = nil
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
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
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
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
          redirect_to '/', status: 302, notice: 'This is not the page you are looking for...move along.'
        end
      else
        redirect_to '/'
      end
      @resource = @page
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :about, :website_id, :position, :page_id, :is_published, :show_sub_menu)
    end

    def image_params
      params.permit(:asset, :type, :attachable_id, :attachable_type, :attachable, :name, :about, :link, :position, :link_text)
    end

    def block_params
      params.permit(:name, :about, :website_id, :block_type, :position, :location, {:page_ids=>[]})
    end
end
