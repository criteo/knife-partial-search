class Chef
  class Knife
    class Ssh

      include Chef::Knife::PartialSearch

      deps do
        begin
          require 'partial_search'
        rescue LoadError => e
        end
      end

      alias_method :classic_configure_session, :configure_session unless method_defined? :classic_configure_session

      def configure_session
        if defined?(Chef::PartialSearch)
          keys = {}
          keys[config[:attribute]] = config[:attribute].split('.') if config[:attribute]
          keys[config[:override_attribute]] = config[:override_attribute].split('.') if config[:override_attribute]
          define_partial_search(keys)
        end
        classic_configure_session
      end
    end
  end
end
