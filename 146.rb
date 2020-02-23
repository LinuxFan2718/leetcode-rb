class Node
    attr_accessor :left, :right, :key, :value
    def initialize(key, value)
        @key = key
        @value = value
        @left = nil
        @right = nil
    end

    def remove_node
        # no need to check for nil due to existence of head and tail dummy Nodes
        @left.right = @right
        @right.left = @left
    end

    def place_in_front(head)
        old_front_node = head.right
        head.right = self
        self.left = head
        self.right = old_front_node
        old_front_node.left = self
    end
end

class LRUCache
=begin
    :type capacity: Integer
=end
    def initialize(capacity)
        @capacity = capacity
        @hash = {}
        @head = Node.new(nil, nil)
        @tail = Node.new(nil, nil)
        @head.right = @tail
        @tail.left = @head
    end

=begin
    :type key: Integer
    :rtype: Integer
=end
    def get(key)
        node = @hash[key]
        if node
            # move Node to most-recently used position
            node.remove_node
            node.place_in_front(@head)
            return node.value
        else
            return -1
        end        
    end

=begin
    :type key: Integer
    :type value: Integer
    :rtype: Void
=end
    def put(key, value)
        node = @hash[key]
        if node
            node.value = value
            node.remove_node
            node.place_in_front(@head)
        else
            node = Node.new(key, value)
            node.place_in_front(@head)
            @hash[key] = node
            if @capacity < @hash.length
                node_to_remove = @tail.left
                @hash.delete(node_to_remove.key)
                node_to_remove.remove_node
            end
        end
    end
end

# cache = LRUCache.new(2)

# cache.put(1, 1);
# cache.put(2, 2);
# a1 = cache.get(1);      # returns 1
# puts("#{a1} #{a1 == 1}")
# cache.put(3, 3);        # evicts key 2
# a2 = cache.get(2);      # returns -1 (not found)
# puts("#{a2} #{a2 == -1}")
# cache.put(4, 4);        # evicts key 1
# a3 = cache.get(1);      # returns -1 (not found)
# puts("#{a3} #{a3 == -1}")
# a4 = cache.get(3);       # returns 3
# puts("#{a4} #{a4 == 3}")
# a5 = cache.get(4);       # returns 4
# puts("#{a5} #{a5 == 4}")

["LRUCache","put","put","put","put","get","get"]
[[2],[2,1],[1,1],[2,3],[4,1],[1],[2]]
puts
cache2 = LRUCache.new(2)
cache2.put(2,1)
cache2.put(1,1)
cache2.put(2,3)
cache2.put(4,1)
a6 = cache2.get(1)
puts(a6, a6 == -1)
a7 = cache2.get(2)
puts(a7, a7 == 3)