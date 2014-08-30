require 'erb'
require './Types.rb'

module Controller
  def process_template(template)
    template = ERB.new template

    template.result binding
  end

  def dynamic(identifier)
    Types.check( binding, { :identifier => String } )

    self.send(identifier)
  end
end
