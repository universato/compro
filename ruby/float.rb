Math::TAU = 2 * Math::PI

# 浮動小数点数の勉強用に作ったもの。
# Float.f64(b64): 64bit以内の整数を与え、64個の01のデータを浮動小数点数と解釈して浮動小数点数を返す。
class Float
  def self.f64(b64)
    raise ArgumentError if b64.bit_length > 64 && b64 < 0

    b = b64.to_s(2).tr('-', '').rjust(64, '0')
    sign = b[0].to_i(2)
    expo = b[1, 11].to_i(2)
    frac = b[12, 52].to_i(2)
    # p [sign, expo, frac, self, b]
    # p format("%b %011b %52b", sign, expo, frac)

    if 1 <= expo && expo <= 2046
      # Normalized number
      n_expo = expo - 1023
      n_frac = frac + (1 << 52)
      # p [sign, n_expo, n_frac.fdiv(2**52), self, b]

      # 2**52 #=> 4503599627370496
      (-1)**sign * (2**n_expo * n_frac).fdiv(2**52)
    elsif expo == 2047 # 0b11111111111 # 2047.bit_length #=> 11
      if frac != 0
        Float::NAN
      else
        sign.zero? ? Float::INFINITY : -Float::INFINITY
      end
    elsif expo == 0 && frac == 0
      sign.zero? ? 0.0 : -0.0
    else
      raise ArgumentError
    end
  end

  def self.f32(b32)
    raise ArgumentError if b32.bit_length > 32 && b32 < 0

    b = b32.to_s(2).tr('-', '').rjust(32, '0')
    sign = b[0].to_i(2)
    expo = b[1, 8].to_i(2)
    frac = b[9, 23].to_i(2)
    # p [sign, expo, frac, self, b]
    p format("%b %08b %23b", sign, expo, frac)

    if 1 <= expo && expo <= (2**8 - 2)
      # Normalized number
      n_expo = expo - (2**7 - 1)
      n_frac = frac + (1 << 23)
      # p [sign, n_expo, n_frac.fdiv(2**52), self, b]

      # 2**24 #=> 16777216
      (-1)**sign * (2**n_expo * n_frac).fdiv(2**23)
    elsif expo == (2**8 - 1) # 0b11111111111 # 2047.bit_length #=> 11
      if frac != 0
        Float::NAN
      else
        sign.zero? ? Float::INFINITY : -Float::INFINITY
      end
    elsif expo == 0 && frac == 0
      sign.zero? ? 0.0 : -0.0
    else
      n_expo = expo - (2**7 - 1)
      n_frac = frac + (1 << 23)
      (-1)**sign * (n_frac * 2**n_expo.fdiv(2**23))
      # raise ArgumentError
    end
  end

  # [TODO]
  private def validate_and_convert(b)
    if b.is_a?(String)

    end
  end

  def radian_to_degree
    self * 360 / Math::TAU
  end

  def degree_to_radian
    self * Math::TAU / 360
  end
end

class Rational
  def degree_to_radian
    self / 360 * Matt::TAU
  end
end

def put_pow(x, y)
  res = x.pow(y)
  xb, yb, rb = [x, y, res].map{ |i| i.to_s(2) }
  puts "#{x}.pow(#{y}) # => #{res}"
  puts "0b#{xb}.pow(0b#{yb}) # => 0b#{rb}"
end

def put_bin(x)
  puts "#{x}: 0b#{x.to_s(2)}"
end

def put_floatble?(i)
  puts "#{i}.floatable? # => #{i.floatable?}"
end

# Integer
class Integer
  def floatable?
    self == self.to_f
  end
end
