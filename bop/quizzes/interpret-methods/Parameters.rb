module Parameters
  @@parameters = {}

  def self.add(key, value)
    @@parameters[key] = value
  end

  def self.has?(key)
    @@parameters.has_key? key
  end

  def self.get(key)
    if has? key
    then @@parameters[key]
    else raise "Unknown key #{key}"
    end
  end

  def self.keys
    @@parameters.keys
  end
end
