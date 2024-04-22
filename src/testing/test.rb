class Test
  @@tests = []

  def self.test(&f)
    @@tests.push(f)
  end

  def self.run()
    @@tests.each { |f|
      f.call()
    }
  end
end