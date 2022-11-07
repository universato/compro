def foo(x, y)
  p x + y
end

def foo(*a : Int32)
  p typeof(a)
  p a.class
  p a
end



foo(1, 2)
foo(1, 2, 3)
foo(1)
