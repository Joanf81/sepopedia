class Articles::ArticleEditionDecorator < ApplicationDecorator

  delegate_all

  def icon 
  	h.image_tag(object.picture.url(:icon), :class => "article-icon")
  end

  def user 
    object.user.decorate.name_link
  end
end