require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn's Algorithm
def topological_sort(vertices)
  queue = []
  list = []
  vertices.each { |vertex| queue << vertex if vertex.in_edges.empty? }

  until queue.empty?
    removal = queue.shift
    list << removal

    removal.out_edges.each do |edge|
      outer_vertex = edge.to_vertex

      outer_vertex.in_edges.delete(edge)

      queue << outer_vertex if outer_vertex.in_edges.empty?
    end
  end

  return list if list.length == vertices.length

  []
end