require 'erb'

module Controller
  def process_template(template)
    template = ERB.new template

    template.result binding
  end
end
