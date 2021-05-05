# require 'ac-library'
require 'ac-library/version'

p AcLibrary::VERSION

include AcLibrary

p VERSION

# include AcLibrary
fw = AcLibrary::FenwickTree.new(5)
p fw
