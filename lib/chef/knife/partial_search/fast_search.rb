class Chef
  class Knife
    class Search

      include Chef::Knife::PartialSearch

      deps do
        begin
          require 'partial_search'
        rescue LoadError => e
        end
      end

      alias_method :classic_run, :run unless method_defined? :classic_run

      def run
        if defined?(Chef::PartialSearch)
          keys = {}
          if config[:attribute]
            keys['name'] = ['name']
            Array(config[:attribute]).each do |nested_value_spec|
              keys[nested_value_spec] = nested_value_spec.split('.')
            end
            define_partial_search(keys)
          else
            define_partial_search({
              'name'      => ['name'],
              'chef_environment' => ['chef_environment'],
              'fqdn'      => ['fqdn'],
              'ipaddress' => ['ipaddress'],
              'run_list'  => ['run_list'],
              'roles'     => ['roles'],
              'recipes'   => ['recipes'],
              'platform'  => ['platform'],
              'tags'      => ['tags'],
              'platform_version' => ['platform_version'],
            })
          end
        end
        classic_run
      end

    end
  end
end

