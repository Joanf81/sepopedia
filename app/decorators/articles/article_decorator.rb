class Articles::ArticleDecorator < ApplicationDecorator
  #include ActionView::Helpers::UrlHelper
  #include Rails.application.routes.url_helpers

  delegate_all

  def last_modification_date
  	format_date object.last_modification_date
  end

  def field_for_created_at
  	"Fecha de creación"
  end

  def field_for_last_modification_date
  	"Última modificación:"
  end

  def field_for_key_words
  	"Palabras clave:"
  end

  def field_for_edition_icon 
    "Imagen:"
  end

  def field_for_edition_created_at 
    "fecha de edición:"
  end

  def field_for_edition_user 
    "Autor:"
  end

  def field_for_edition_characters_added
    "Cambios:"
  end
end