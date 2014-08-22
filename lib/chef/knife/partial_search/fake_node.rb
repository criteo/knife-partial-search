class Chef
  class Knife
    class PartialSearch
      class FakeNode < Hash
        def name
          self['name']
        end
        def chef_environment
          self['chef_environment']
        end
        def run_list
          self['run_list'].join(', ')
        end

        def [](key)
          super(key.to_s)
        end

        def kind_of?(klass)
          if klass.to_s == 'Chef::Node'
            true
          else
            super
          end
        end
      end
    end
  end
end
