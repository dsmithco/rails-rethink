class PagePageBlocksController < ApplicationController
  before_action :set_block, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /page_blocks
  # GET /page_blocks.json
  def index
    @page_blocks = PageBlock.all
  end

  # GET /page_blocks/1
  # GET /page_blocks/1.json
  def show
  end

  # GET /page_blocks/new
  def new
    @page_block = PageBlock.new
  end

  # GET /page_blocks/1/edit
  def edit
  end

  # POST /page_blocks
  # POST /page_blocks.json
  def create
    @page_block = PageBlock.new(page_block_params)

    respond_to do |format|
      if @page_block.save
        format.html { redirect_to @page_block, notice: 'PageBlock was successfully created.' }
        format.json { render :show, status: :created, location: @page_block }
      else
        format.html { render :new }
        format.json { render json: @page_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_blocks/1
  # PATCH/PUT /page_blocks/1.json
  def update
    respond_to do |format|
      if @page_block.update(page_block_params)
        format.html { redirect_to @page_block, notice: 'PageBlock was successfully updated.' }
        format.json { render :show, status: :ok, location: @page_block }
      else
        format.html { render :edit }
        format.json { render json: @page_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_blocks/1
  # DELETE /page_blocks/1.json
  def destroy
    @page_block.destroy
    respond_to do |format|
      format.html { redirect_to page_blocks_url, notice: 'PageBlock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @page_block = PageBlock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_block_params
      params.require(:page_block).permit(:page_id, :block_id, :position)
    end
end
