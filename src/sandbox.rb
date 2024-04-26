def foo
  puts "HERE"
  false
end

def bar
  puts "THERE"
  true
end

lambda {
  return if foo && bar

  puts "EVERYWHERE"
}  .call