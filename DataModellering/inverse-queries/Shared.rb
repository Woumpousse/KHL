class Array
  def pick(n)
    (0..length-1).to_a.shuffle[0..n-1].map do |i|
      self[i]
    end
  end
end


class String
  def indent(n = 2)
    lines.map { |s| (" " * n) + s }.join
  end

  def unindent(indentation = nil)
    unless indentation
      indentation = lines.select do |line|
        line.strip.length > 0
      end.map do |line|
        line =~ /^( *)/
        currentIndentation = $1.length

        currentIndentation
      end.min
    end

    lines.map do |line|
      if line.strip.length > 0
      then line[indentation..-1]
      else line
      end
    end.join
  end
end


class Set
  def self.universe
    UniverseSet.new
  end

  def self.empty
    Set.new
  end

  def initialize(*xs)
    @items = Hash.new(false)

    xs.each do |x|
      add x
    end
  end

  def add(x)
    @items[x] = true
  end

  def items
    @items.keys
  end

  def contains?(*xs)
    xs.all? do |x|
      @items[x]
    end
  end

  def subset_of?(set)
    items.all? do |item|
      set.contains?(item)
    end
  end

  def superset_of?(set)
    set.subset_of?(self)
  end

  def same?(set)
    subset_of?(set) and superset_of?(set)
  end

  def to_s
    items.to_s
  end
end

class UniverseSet
  def add(x)
    @items[x] = true
  end

  def items
    raise "Infinite array"
  end

  def contains?(*xs)
    true
  end

  def subset_of?(set)
    set.superset_of?(self)
  end

  def superset_of?(set)
    true
  end

  def same?(set)
    subset_of?(set) and superset_of?(set)
  end

  def to_s
    "universe"
  end
  
end
