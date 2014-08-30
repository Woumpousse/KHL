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

  def once(id)
    field = "@#{id}_cache"

    value = instance_variable_get(field)

    if not value
    then
      value = yield
      instance_variable_set(field, value)
    end

    value
  end
end
