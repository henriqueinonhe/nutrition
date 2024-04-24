def foo(&f)
  puts f.call(self)
end

foo &:methods.to_proc
