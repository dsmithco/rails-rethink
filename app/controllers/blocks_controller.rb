class BlocksController < ApplicationController
  before_action :set_block, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /blocks
  # GET /blocks.json
  def index
    @blocks = Block.all
  end

  # GET /blocks/1
  # GET /blocks/1.json
  def show
  end

  # GET /blocks/new
  def new
    @block||= Block.new
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks
  # POST /blocks.json
  def create
    @block = Block.new(block_params)
    @block.website_id ||= @current_website.id if @current_website.present?

    respond_to do |format|
      if @block.save
        format.html { redirect_to @block, notice: 'Block was successfully created.' }
        format.json { render json: @block.to_json, status: :created}
        format.js { render :update }
      else
        format.html { render :new }
        format.json { render json: @block.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  # PATCH/PUT /blocks/1
  # PATCH/PUT /blocks/1.json
  def update
    params[:page_ids] = params[:page_ids] - [params[:remove_page_id]] if params[:remove_page_id].present?
    params[:page_ids] = params[:page_ids] + [params[:add_page_id]] if params[:add_page_id].present?

    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to @block, notice: 'Block was successfully updated.' }
        format.json { render json: @block.to_json, status: :ok }
        format.js { render :update }
      else
        format.html { render :edit }
        format.json { render json: @block.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.json
  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to blocks_url, notice: 'Block was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def block_params
      params.require(:block).permit(:name, :block_id, :bg_color, :about, :continue_edit, :website_id, :block_type, :position, :location, :front_page, {:page_ids=>[]}, :link, :link_text)
    end
end
