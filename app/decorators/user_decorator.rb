class UserDecorator < ApplicationDecorator
  delegate_all

  def name
  	return object.user_name unless object.user_name.blank?
  	return object.first_name unless object.first_name.blank?
  	return object.email
  end

  def field_for_email
  	"Email:"
  end

  def field_for_user_name
  	"Nombre de usuario:"
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
end
