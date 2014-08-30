require 'erb'
require './Types.rb'

class Controller
  def process_template(template)
    template = ERB.new template

    template.result binding
  end

  def member(identifier)
    Types.check( binding, { :identifier => String } )

    self.send(identifier)
  end
end
