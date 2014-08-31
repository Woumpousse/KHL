require 'erb'
require './Types.rb'

class Controller
  def process_template(template, passes = 1)
    Types.check( binding, {
                   :template => String,
                   :passes => Fixnum
                 } )

    passes.times do
      erb = ERB.new template
      template = erb.result binding
    end

    template
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
