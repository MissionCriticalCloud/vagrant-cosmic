require "log4r"

module VagrantPlugins
  module Cosmic
    module Action
      # This stops the running instance.
      class StopInstance
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_cosmic::action::stop_instance")
        end

        def call(env)
          server = env[:cosmic_compute].servers.get(env[:machine].id)

          if env[:machine].state.id == :stopped
            env[:ui].info(I18n.t("vagrant_cosmic.already_status", :status => env[:machine].state.id))
          else
            env[:ui].info(I18n.t("vagrant_cosmic.stopping"))
            server.stop({'force' => !!env[:force_halt]})
          end

          @app.call(env)
        end
      end
    end
  end
end
