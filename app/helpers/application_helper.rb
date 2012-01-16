module ApplicationHelper
  def current_url
    "http://#{request.host_with_port}"
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "Vimpusher.remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, raw("Vimpusher.add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end

  def complement_plugin_url(url)
    components = url.split('/')
    case components.size
    when 1
      "https://github.com/vim-scripts/" + url
    when 2
      if components[0].include?(".")
        "http://" + url
      else
        "https://github.com/" + url
      end
    else
      "http://" + url
    end
  end

  def gravatar_url(user_id)
    User.find(user_id).gravatar_url
  end
end
