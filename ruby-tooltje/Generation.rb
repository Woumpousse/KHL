require './Types.rb'

module Generation
  def self.generate(resources, template, passes=1)
    Types.check( binding, {
                   :resources => Types.nonnil,
                   :template => String,
                   :passes => Fixnum
                 } )

    resources.process_template(template, passes)
  end
end
