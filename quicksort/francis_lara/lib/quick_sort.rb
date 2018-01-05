class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length == 1

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

    QuickSort.sort1(left) + [array[pivot]] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    
  end

  def self.partition(array, start, length, &prc)

  end
end
