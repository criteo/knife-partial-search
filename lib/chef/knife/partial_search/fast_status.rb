class Chef
  class Knife
    class Status

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
          define_partial_search({
            'name'      => ['name'],
            'ohai_time' => ['ohai_time'],
            'fqdn'      => ['fqdn'],
            'ipaddress' => ['ipaddress'],
            'platform'  => ['platform'],
            'platform_version' => ['platform_version'],
            'run_list'  => ['run_list'],
          })
        end
        classic_run
      end

    end
  end
end
