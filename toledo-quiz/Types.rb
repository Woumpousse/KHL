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

    def to_s
      @name
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
      if t.size == 1 then
        seq_of( smart_predicate( t[0] ) )
      else
        tuple_of( t.map { |x| smart_predicate(x) } )
      end
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
      object.methods.member?(:all?) and object.all? { |item| predicate.call(item) }
    end
  end

  def Types.tuple_of(predicates)
    names = predicates.map { |predicate| predicate.name }.join(",")

    predicate("[#{names}]") do |tuple|
      tuple.methods.member?(:[]) and tuple.length == predicates.length and (0...predicates.length).all? do |idx|
        predicate = predicates[idx]
        object = tuple[idx]

        predicate.call( object )
      end
    end
  end

  def Types.one_of(*values)
    names = values.map do |value|
      value.to_s
    end.join("|")

    predicate(names) do |object|
      values.member?(object)
    end
  end
end
