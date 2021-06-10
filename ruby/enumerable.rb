module Enumerable
  def stable_sort_by
    sort_by.with_index { |item, index| [yield(item), index] }
  end
end
