class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
    @knapsack_cache = {}
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?

    ans = blair_nums(n - 1) + blair_nums(n - 2) + (2*(n - 1) - 1)
    @blair_cache[n] = ans
    ans
  end

  def frog_hops_bottom_up(n)
    frog_cache = frog_cache_builder(n)
    frog_cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
    return frog_cache if n <= 3

    (4..n).each do |i| #O(n)
      frog_cache[i] = []
      (1..3).each do |j|
        frog_cache[i - j].each do |el1|
          frog_cache[j].each do |el2| 
            frog_cache[i] << el1 + el2
          end
        end
      end
      frog_cache[i].uniq!
    end
    frog_cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if n <= 3


    result = {}
    (1..3).each do |i|
      frog_hops_top_down_helper(n - i).each do |el1|
        frog_hops_top_down_helper(i).each do |el2|
          result[el1 + el2] = true
        end
      end
    end
    @frog_cache[n] = result.keys
    result.keys
  end

  def super_frog_hops(n, k)
    if k > n
      frog_cache = super_frog_hops_helper(n, n)
    else
      frog_cache = super_frog_hops_helper(n, k)
    end

    frog_cache[n]
  end

  def super_frog_hops_helper(n, k)
    frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
    return frog_cache if n <= 3

    (4..n).each do |i|
      frog_cache[i] = []
      if i <= k
        frog_cache[i] << [k]
      end
      (1..3).each do |j|
        frog_cache[i - j].each do |el1|
          frog_cache[j].each do |el2|
            frog_cache[i] << el1 + el2
          end
        end
      end
      frog_cache[i].uniq!
    end
    frog_cache
  end

  def knapsack(weights, values, capacity)
    check = [weights, capacity]
    return @knapsack_cache[check] unless @knapsack_cache[check].nil?
    return 0 if capacity == 0 || weights.empty?

    if weights[0] > capacity
      knapsack(weights[1..-1], values[1..-1], capacity)
    else 
      include_item = knapsack(weights[1..-1], values[1..-1], capacity - weights[0])
      not_include_item = knapsack(weights[1..-1], values[1..-1], capacity)
      @knapsack_cache[check] = [include_item + values[0], not_include_item].max
    end
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end