module VagrantPlugins
  module Cosmic
    module Exceptions
      class IpNotFoundException < StandardError
      end
      class DuplicatePFRule < StandardError
      end
      class CosmicResourceNotFound < StandardError
        def initialize(msg='Resource not found in cosmic')
          super
        end
      end
    end
  end
end
