class AvatarInput < SimpleForm::Inputs::FileInput
	def input
		out = template.image_tag(object.send(attribute_name).url(:thumb), :class => 'profile-picture', id: 'profile-picture', height: '300', width: '300')
	    out << @builder.file_field(attribute_name, input_html_options)
	    out.html_safe
	end
end