# う〜ん、競プロ的に入出力を楽にするにはどうするという観点から。

def int
  gets.to_s.to_i
end

def string
  gets.to_s.chomp
end

def float
  gets.to_s.to_f
end

def ints(n = nil)
  n ? Array.new(n){ gets.to_s.to_i } : gets.to_s.map{ |e| e.to_i }
end

def strings
  gets.to_s.split
end

def char
  gets.to_s.to_s
end

def chars
  gets.to_s.split
end
