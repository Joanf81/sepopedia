class ApplicationDecorator < Draper::Decorator

	%w(created_at updated_at).each do |attribute|
    define_method attribute do
      object.try(attribute).try(:blank?) ? "-" : object.try(attribute).try(:strftime, "%d/%y/%Y %k:%M")
    end
  end	  
end
