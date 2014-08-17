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
    when Hash
      if t.size == 1 then
        from, to = t.first

        hash_of(smart_predicate(from), smart_predicate(to))
      else
        abort "Unrecognized predicate"
      end
    else
      t
    end
  end

  def Types.check(context, map)
    map.each do |id, t|
      if id.is_a? Symbol
      then id = id.to_s
      end

      predicate = smart_predicate(t)
      object = context.eval(id)

      unless predicate.call(object)
        raise TypeError, "'#{id}' should be a #{predicate.name} (value was #{object})"
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

  def Types.hash_of(key_predicate, value_predicate)
    predicate("{#{key_predicate.name} => #{value_predicate.name}}") do |hash|
      Hash === hash and hash.to_a.all? do |key, val|
        key_predicate.call(key) and value_predicate.call(val)
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

  def Types.any
    predicate("any") do |object|
      true
    end
  end
end
