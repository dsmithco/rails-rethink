class ImagesController < AttachmentsController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # POST /attachments
  # POST /attachments.json
  def create
    unless params[:id].present?
      @image = Image.new(image_params)
      @image.save
    else
      @image = Image.find_or_initialize_by(id: params[:id])
      @image.update(image_params)
    end
    authorize! :edit, @image.attachable

    respond_to do |format|
      if !@image.errors.present?
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
        format.js { }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
        format.js { }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.permit(:asset, :type, :attachable_id, :attachable_type, :attachable, :name, :about, :link, :position, :link_text)
    end
end
