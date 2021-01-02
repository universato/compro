require 'prime'
require_relative '../float.rb'

s = "01111111111" + "1".ljust(52, '0')
p s.to_i(2).to_s(2)
p Float.f64(s.to_i(2))

# p Float::DIG   # 15
# p Float::RADIX # 2
# p Float::MAX_10_EXP # 308
# p Float::MANT_DIG # 53
# p Float::MAX_EXP # 1024

# put_bin(10)
# put_pow(2, 53)

# p s = ("01111111111" + "1".ljust(52, '0'))
# p s.size
# p b = s.to_i(2)
# p b

# p "54656".rjust(32, '0')



# p 1023.to_s(2)

# p (2**53).fdiv(2**52)

# p 0x3ff0_0000_0000_0000.to_s(2).rjust(64, '0')
# p 0x4000_0000_0000_0000.to_s(2).rjust(64, '0')
# p "aa"
# p 0x3ff0_0000_0000_0000.to_s(2).rjust(64, '0').to_i(2).float_as_binary
# p 0x4000_0000_0000_0000.to_s(2).rjust(64, '0').to_i(2).float_as_binary
# # p "100000000000000000000000000000000000000000000000000000000000011".size
# p "0100000000000000000000000000000000000000000000000000000000000011".size

# x = (2**53) - 1
# p x

# put_floatble?(5)



# put_floatble?((1 << 52))
# put_floatble?((1 << 52) + 1)
# put_floatble?((1 << 52) + 2)

# put_floatble?((1 << 53) - 2)
# put_floatble?((1 << 53) - 1)
# put_floatble?(1 << 53)
# put_floatble?((1 << 53) + 1)
# put_floatble?((1 << 53) + 2)
# put_floatble?((1 << 53) + 3)

# p ((1 << 52) + 1).to_s(2).size
# p ((1 << 52) + 1).bit_length
# p ((1 << 52) + 1).to_s(2)

# p ((1 << 3) == 2**3)


# puts((1 << 1) + 1)
# p ((1 << 52) + 0)
# p ((1 << 52) + 0).to_f
# p ((1 << 52) + 1).to_f

# p [x.to_f, (x + 1).to_f, (x + 2).to_f]

# p x.to_f.to_i
# p (x + 1).to_f.to_i
# p 2251799813685248.0
# p 2251799813685249.0

# puts 1024.to_s(2) # 10000000000
# puts '0' * 51 + '1'
