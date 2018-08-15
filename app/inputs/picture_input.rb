class PictureInput < SimpleForm::Inputs::FileInput
	def input
		out = template.image_tag(object.send(attribute_name).url(@options[:version]), :class => @options[:class])
	    out << @builder.file_field(attribute_name, input_html_options)
	    out.html_safe
	end
end