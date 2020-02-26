require 'fog/cosmic'
require 'log4r'

module VagrantPlugins
  module Cosmic
    module Action
      # This action connects to Cosmic, verifies credentials work, and
      # puts the Cosmic connection object into the
      # `:cosmic_compute` key in the environment.
      class ConnectCosmic
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new('vagrant_cosmic::action::connect_cosmic')
        end

        def call(env)
          # Get the domain we're going to booting up in
          domain        = env[:machine].provider_config.domain_id

          # Get the configs
          domain_config = env[:machine].provider_config.get_domain_config(domain)

          # Build the fog config
          fog_config    = {
              :provider => :cosmic
              #:domain        => domain_config
          }

          if domain_config.api_key
            fog_config[:cosmic_api_key]           = domain_config.api_key
            fog_config[:cosmic_secret_access_key] = domain_config.secret_key
          end

          fog_config[:cosmic_host]   = domain_config.host if domain_config.host
          fog_config[:cosmic_path]   = domain_config.path if domain_config.path
          fog_config[:cosmic_port]   = domain_config.port if domain_config.port
          fog_config[:cosmic_scheme] = domain_config.scheme if domain_config.scheme

          @logger.info('Connecting to Cosmic...')
          env[:cosmic_compute] = Fog::Compute.new(fog_config)

          @app.call(env)
        end
      end
    end
  end
end
