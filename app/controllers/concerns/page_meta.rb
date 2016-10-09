module PageMeta
  extend ActiveSupport::Concern

  included do
    before_action :set_site_meta_data, only: [:show]
  end

  def set_site_meta_data
    @resource = instance_variable_get("@#{self.controller_name.singularize}")
    @site_title = "#{@resource.name} - #{@site_title}" if @resource.name.present?
    @site_title = "#{@site_title} - #{@resource.subtitle}" if @resource.subtitle.present?
    @site_description = @resource.description.present? ? "#{@resource.description}" : "#{ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(@resource.about), length: 250)}"
  end

end
