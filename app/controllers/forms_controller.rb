class FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:create]

  # GET /forms
  # GET /forms.json
  def index
    @forms = @current_website.forms
    authorize! :edit, @current_website

  end

  # GET /forms/1
  # GET /forms/1.json
  def show
  end

  # GET /forms/new
  def new
    session[:return_to] = params[:return_to] if params[:return_to].present?

    @form = Form.new
    @form.website_id = @current_website.id
  end

  # GET /forms/1/edit
  def edit
    session[:return_to] = params[:return_to] if params[:return_to].present?

  end

  # POST /forms
  # POST /forms.json
  def create
    @form = Form.new(form_params)
    @form.website_id = @current_website.id
    authorize! :manage, @form.website

    respond_to do |format|
      if @form.save
        format.html { redirect_to session.delete(:return_to) || @form, notice: 'Form was successfully created.' }
        format.json { render :show, status: :created, location: @form }
      else
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms/1
  # PATCH/PUT /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to session.delete(:return_to) || @form, notice: 'Form was successfully updated.' }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.json
  def destroy
    @form.destroy
    respond_to do |format|
      unless @form.errors.present?
        format.html { redirect_to request.referrer, notice: 'Form was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to request.referrer, alert: "Cannot delete form"}
        format.json { }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.require(:form).permit(:name,
                                   :about,
                                   :email_recipients,
                                   :description,
                                   :open_at,
                                   :close_at,
                                   :is_published,
                                   {:questions_attributes=>[
                                     :id,
                                     :_destroy,
                                     :name,
                                     :about,
                                     :help,
                                     :question_type,
                                     :is_required,
                                     :conditional_id,
                                     :conditional_value,
                                     :conditional_condition,
                                     :position,
                                     :deleted_at
                                     ]})
    end
end
