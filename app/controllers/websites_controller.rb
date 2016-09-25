class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy, :edit_heroes]

  # GET /websites
  # GET /websites.json
  def index
    @websites = current_user.websites
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
    respond_to do |format|
      format.html {redirect_to @website.rethink_href }
      format.json {}
    end
  end

  def stylesheet
    dir = "#{Rails.root}/tmp/websites"
    path = "#{dir}/#{@current_website.id}-#{@current_website.updated_at.to_i}-theme.css"
    unless File.exist?(path) && Rails.env != 'development'
      File.delete(*Dir.glob("#{dir}/#{@current_website.id}-*.css"))
      sass =  "#{@current_website.style_settings}\n
               #{@current_website.css_override}\n
               @import 'application';\n
              "

      compiler = Sass::Engine.new(sass, {
        syntax: :scss,
        load_paths: ["#{Rails.root}/app/assets/stylesheets"],
        cache: true,
        read_cache: true,
        style: :compressed
      }).render

      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      File.open(path, "w+") do |f|
        f.write(compiler)
      end
    end
    # compiler = Sass::Compiler.new(temp, {:syntax => :scss, :output_dir => Rails.root.join(dir)})
    render text: File.read(path), content_type: 'text/css'
  end

  def edit_heroes

  end

  def home
    @website = @current_website || Website.where("domain_url = ?", "#{request.host}").first

    render :show, {layout: "themes/#{@current_website.theme}/layout"}
  end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit
  end

  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new(website_params)

    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
        format.json { render :show, status: :created, location: @website }
      else
        format.html { render :new }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1
  # PATCH/PUT /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params)
        format.html { redirect_to '/', notice: 'Website was successfully updated.' }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website.destroy
    respond_to do |format|
      format.html { redirect_to websites_url, notice: 'Website was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_website
      params[:id] ||= Website.where("domain_url like ?", "%#{request.host}%").first.id
      @website = Website.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def website_params
      params.require(:website).permit(:account_id, :css_override, {:style=>['brand-primary', 'brand-info', 'brand-success', 'brand-danger', 'brand-warning', 'border-radius-base', 'nav-inverse', 'nav-fixed', 'navbar-height']}, :name, :about, :domain_url, :google_analytics, :description, :facebook, :twitter, :tags, :theme, {logo_attributes: [:asset, :type, :attachable_id, :attachable_type]})
    end
end
