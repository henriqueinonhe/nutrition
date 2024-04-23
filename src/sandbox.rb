class Error < StandardError
  def initialize(msg)
    super(msg)
  end
  
  def to_s
    "#{super} HERE"
  end
end

raise Error.new("FooJS dhA SD")


