class ApplicationDecorator < Draper::Decorator

	%w(created_at updated_at).each do |attribute|
    define_method attribute do
      format_date object.try(attribute)
    end
  end

  private
  def format_date attribute
  	attribute.try(:blank?) ? "-" : attribute.try(:strftime, "%d/%y/%Y %k:%M") || "-"
  end  
end
