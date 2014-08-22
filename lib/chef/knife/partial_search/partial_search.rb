class Chef
  class Knife
    module PartialSearch
      def define_partial_search(keys)
        Chef::Search::Query.class_eval do

          @@keys = keys

          alias_method :old_search, :search unless method_defined? :old_search

          def search(type, query="*:*", sort='X_CHEF_id_CHEF_X asc', start=0, rows=1000, &block)
            q = Chef::PartialSearch.new
            args = Hash.new
            args[:keys] = @@keys
            args[:sort] = sort
            args[:start] = start
            args[:rows] = rows
            if block_given?
              q.search(type, query, args) do |node_hash|
                n = ::Knife::PartialSearch::FakeNode.new do |h,k|
                  h[k] = node_hash[k]
                end
                @@keys.each do |k,v| n[k] end

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

class Chef
  class Knife
    module Core
      class GenericPresenter

        alias_method :old_extract, :extract_nested_value unless method_defined? :old_extract

        def extract_nested_value(data, nested_value_spec)
          if data.kind_of?(::Knife::PartialSearch::FakeNode)
            data[nested_value_spec]
          else
            old_extract(data, nested_value_spec)
          end
        end
      end
    end
  end
end
