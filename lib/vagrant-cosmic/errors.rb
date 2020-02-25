require "vagrant"

module VagrantPlugins
  module Cosmic
    module Errors
      class VagrantCosmicError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_cosmic.errors")
      end

      class FogError < VagrantCosmicError
        error_key(:fog_error)
      end

      class InstanceReadyTimeout < VagrantCosmicError
        error_key(:instance_ready_timeout)
      end

      class RsyncError < VagrantCosmicError
        error_key(:rsync_error)
      end

      class UserdataError < VagrantCosmicError
        error_key(:user_data_error)
      end
    end
  end
end
