class UserDecorator < ApplicationDecorator
  include ActionView::Helpers::UrlHelper
  include Rails.application.routes.url_helpers

  delegate_all

  def name
  	return object.user_name unless object.user_name.blank?
  	return object.first_name unless object.first_name.blank?
  	return object.email
  end

  %w(email user_name first_name second_name tlf).each do |attribute|
    define_method attribute do
      object.try(attribute) || "-"
    end
  end

  def email_link
    link_to object.email, h.user_path(object)
  end

  def field_for_email
  	"Email:"
  end

  def field_for_user_name
  	"Usuario:"
  end

  def field_for_first_name
  	"Nombre:"
  end

  def field_for_second_name
  	"Apellidos:"
  end

  def field_for_tlf
  	"Teléfono:"
  end

  def field_for_created_at
    "Registro:"
  end

  def field_for_updated_at
    "Última modificación:"
  end
end
