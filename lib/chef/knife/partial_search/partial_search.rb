class Chef
  class Knife
    module PartialSearch
      def define_partial_search(keys)
        Chef::Search::Query.class_eval do

          @@keys = keys

          alias_method :old_search, :search unless method_defined? :old_search

          def search(type, query, args={}, &block)
            q = Chef::PartialSearch.new
            args[:keys] = @@keys
            if block_given?
              q.search(type, query, args) do |node_hash|
                n = FakeNode.new do |h,k| node_hash[k] end
                block.call(n)
              end
            else
              res = q.search(type, query, args)
              [res.first]
            end
          end
        end
      end
    end
  end
end
