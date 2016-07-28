class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /attachments
  # GET /attachments.json
  def index
    @resources = instance_variable_set("@#{resources_name}", attachment_class.all)
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  # GET /attachments/new
  def new
    @resource = instance_variable_set("@#{resource_name}", attachment_class.new)
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @resource = instance_variable_set("@#{resource_name}", attachment_class.new(attachment_params))

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: 'Attachment was successfully created.' }
        format.json { render :show, status: :created, location: @resource }
        format.js { render :create, status: :created }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @resource.update(attachment_params)
        format.html { redirect_to @resource, notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource }
        format.js { render :update, status: :created }
      else
        format.html { render :edit }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @resource = instance_variable_set("@#{resource_name}", attachment_class.find(params[:id]))
    end

    def resources_name
      attachment.tableize
    end

    def resource_name
      attachment.downcase
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:asset, :type, :attachable_id, :attachable_type, :attachable, :name, :about, :link, :position, :link_text)
    end

    def attachment
      params[:type] || "Attachment"
    end

    def attachment_class
      attachment.constantize
    end
end
