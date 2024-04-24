module Assertions
  def self.check(&expr)
    raise "Failed!" unless expr.call
  end

  def self.check_throws()
    begin
      yield
    rescue Exception
    else
      raise "Failed!"
    end
  end

  def self.check_no_throw()
    begin
      yield
    rescue Exception
      raise "Failed!"
    end
  end

  def self.should_not_get_here()
    raise "Failed!"
  end
end