class HeroImagesController < AttachmentsController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # POST /attachments
  # POST /attachments.json
  def create
    @resource = @hero_image = instance_variable_set("@#{resource_name}", attachment_class.new(hero_image_params))
    authorize! :edit, @resource.attachable

    respond_to do |format|
      if @hero_image.save
        format.html { redirect_to @hero_image, notice: 'Attachment was successfully created.' }
        format.json { render :show, status: :created, location: @hero_image }
        format.js { render :create, status: :created }
      else
        format.html { render :new }
        format.json { render json: @hero_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @resource.update(hero_image_params)
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
      format.js { render :destroy }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @resource = @hero_image = instance_variable_set("@#{resource_name}", attachment_class.find(params[:id]))
    end

    def resources_name
      attachment.tableize
    end

    def resource_name
      attachment.downcase
    end

    def hero_image_params
      params.permit(:asset, :text_align, :type, :attachable_id, :attachable_type, :attachable, :name, :about, :link, :position, :link_text)
    end

    def attachment
      params[:type] || "Attachment"
    end

    def attachment_class
      attachment.constantize
    end
end
