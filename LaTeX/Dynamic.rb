module Dynamic
  @@hash = Hash.new

  def self.[](key)
    if @@hash.has_key? key
    then @@hash[key]
    else raise "Unknown dynamic '#{key}'"
    end
  end

  def Dynamic.with(key, value)
    old_value = @@hash[key]
    @@hash[key] = value
    
    begin
      yield
    ensure
      @@hash[key] = old_value
    end      
  end
end
