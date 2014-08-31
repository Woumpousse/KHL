require './Types.rb'

module Generation
  def self.generate(resources, template)
    Types.check( binding, {
                   :resources => Types.nonnil,
                   :template => String
                 } )

    resources.process_template(template)
  end
end
