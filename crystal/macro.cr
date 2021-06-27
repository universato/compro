macro chmin(x, y)
  {{x}} = {{y}} if {{x}} > {{y}}
end

macro chmin(x, y)
  f = {{x}} > {{y}}
  {{x}} = {{y}} if f
  f
end

macro chmax(x, y)
  {{x}} = {{y}} if {{x}} < {{y}}
end

macro chmax(x, y)
  f = {{x}} < {{y}}
  {{x}} = {{y}} if f
  f
end

macro swap(x, y)
  t = x; x = y; y = t;
end
