module Types
  class TypeError < Exception      
  end

  class TypePredicate
    def initialize(name, code)
      @name = name
      @code = code
    end

    def call(object)
      @code.call(object)
    end

    attr_reader :name
  end

  def Types.predicate(name, &block)
    TypePredicate.new(name, block)
  end

  def Types.smart_predicate(t)
    case t
    when Class
      type(t)
    when Array
      raise "Must contain exactly one element" unless t.length == 1
      seq_of( smart_predicate( t[0] ) )
    else
      t
    end
  end

  def Types.check(context, map)
    map.each do |id, t|
      predicate = smart_predicate(t)
      object = context.eval(id)

      unless predicate.call(object)
        raise TypeError, "#{id} should be a #{predicate.name}"
      end
    end
  end

  def Types.type(t)
    raise "Expected class" unless t.class == Class

    predicate(t.name) do |object|
      object.is_a? t
    end
  end

  def Types.seq_of(predicate)
    predicate("[#{predicate.name}]") do |object|
      object.methods.member?(:all?) and object.all? { |item| predicate(item) }
    end
  end
end
