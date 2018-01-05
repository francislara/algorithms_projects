require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    left = []
    right = []
    pivot = rand(array.length)

    array.each do |el, idx|
      if idx == pivot
        next
      elsif el < array[pivot]
        left.push(el)
      else
        right.push(el)
      end
    end

    self.sort1(left) + [array[pivot]] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    return array if length <= 1

    pivot_idx = self.partition(array, start, length, &prc)

    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, (length - pivot_idx + start - 1), &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    pivot = start

    ((start + 1)...(start + length)).each do |i|
      if prc.call(array[pivot], array[i]) >= 0
        array.insert(pivot, array.delete_at(i))
        pivot += 1
      end
    end

    pivot
  end
end
