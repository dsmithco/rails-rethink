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
    @block = Block.find(params[:id]) if params[:id].present?
    @block||= Block.new
    @block.block_type ||= params[:block_type]
    @block.block_id ||= params[:block_id]
    @block.front_page ||= params[:front_page]
    @block.columns ||= params[:columns]
    @block.position ||= params[:position]
    @block.save(validate: false)
    @block.page_id ||= params[:page_id].to_i if params[:page_id].present?
    @block.save(validate: false)
  end

  def sort
    params[:block].each_with_index do |id, index|
      Block.where(id: id).update_all(position: index + 1, block_id: params[:block_id])
      if params[:block_id].present?
        Block.find(params[:block_id]).touch
      end
    end
  end

  # GET /blocks/1/edit
  def edit
    @block.block_type ||= params[:block_type]
    @block.save(validate: false)
  end

  # POST /blocks
  # POST /blocks.json
  def create
    @block = Block.new(block_params)
    @block.page_id ||= params[:page_id] if params[:page_id].present?

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
      params.require(:block).permit(:name, :columns, :block_id, :form_id, :category_id,
                                    :bg_color, :text_align, :about, :continue_edit,
                                    :block_type, :position, :front_page, :page_id, :link,
                                    :link_text, :display_page_name, {:style=>['height','min-height']})
    end
end
