require "vagrant"

module VagrantPlugins
  module Cosmic
    class Config < Vagrant.plugin("2", :config)
      INSTANCE_VAR_DEFAULT_NIL = %w(affinity_group_id
                                    affinity_group_name
                                    display_name
                                    domain_id
                                    group
                                    host
                                    keypair
                                    name
                                    network_id
                                    network_name
                                    path
                                    pf_ip_address
                                    pf_ip_address_id
                                    pf_private_port
                                    pf_public_port
                                    pf_public_rdp_port
                                    pf_trusted_networks
                                    port
                                    private_ip_address
                                    project_id
                                    service_offering_id
                                    service_offering_name
                                    ssh_key
                                    ssh_network_id
                                    ssh_network_name
                                    ssh_user
                                    template_id
                                    template_name
                                    user_data
                                    vm_password
                                    vm_user
                                    zone_id
                                    zone_name).freeze
      INSTANCE_VAR_DEFAULT_EMPTY_ARRAY = %w(static_nat port_forwarding_rules firewall_rules).freeze

      ### API settings

      # Cosmic API host.
      #
      # @return [String]
      attr_accessor :host

      # Cosmic API path.
      #
      # @return [String]
      attr_accessor :path

      # Cosmic API port.
      #
      # @return [String]
      attr_accessor :port

      # Cosmic API scheme
      #
      # @return [String]
      attr_accessor :scheme

      # The API key for accessing Cosmic.
      #
      # @return [String]
      attr_accessor :api_key

      # The secret key for accessing Cosmic.
      #
      # @return [String]
      attr_accessor :secret_key

      ### Instance settings

      # Hostname for the machine instance
      # This will be passed through to the api.
      #
      # @return [String]
      attr_accessor :name

      # Affinity group ID(s) the instance should be applied to
      #
      # @return [String]
      attr_accessor :affinity_group_id

      # Affinity group name(s) the instance should be applied to
      #
      # @return [String]
      attr_accessor :affinity_group_name

      # Disk offering uuid to use for the instance
      #
      # @return [String]
      attr_accessor :disk_offering_id

      # Disk offering name to use for the instance
      #
      # @return [String]
      attr_accessor :disk_offering_name

      # display name for the instance
      #
      # @return [String]
      attr_accessor :display_name

      # Domain id to launch the instance into.
      #
      # @return [String]
      attr_accessor :domain_id

      # flag to enable/disable expunge vm on destroy
      #
      # @return [Boolean]
      attr_accessor :expunge_on_destroy

      # group for the instance
      #
      # @return [String]
      attr_accessor :group

      # The timeout to wait for an instance to become ready.
      #
      # @return [Fixnum]
      attr_accessor :instance_ready_timeout

      # The name of the keypair to use.
      #
      # @return [String]
      attr_accessor :keypair

      # Network uuid(s) that the instance should use
      #
      # @return [String,Array]
      attr_accessor :network_id

      # Network name(s) that the instance should use
      #
      # @return [String,Array]
      attr_accessor :network_name

      # Network Type
      #
      # @return [String]
      attr_accessor :network_type

      # Private ip for the instance
      #
      # @return [String]
      attr_accessor :private_ip_address

      # Project uuid that the instance should belong to
      #
      # @return [String]
      attr_accessor :project_id

      # Service offering uuid to use for the instance
      #
      # @return [String]
      attr_accessor :service_offering_id

      # Service offering name to use for the instance
      #
      # @return [String]
      attr_accessor :service_offering_name

      # The key to be used when loging in to the vm via ssh
      #
      # @return [String]
      attr_accessor :ssh_key

      # The network_id to be used when loging in to the vm via ssh
      #
      # @return [String]
      attr_accessor :ssh_network_id

      # The network_name to be used when loging in to the vm via ssh
      #
      # @return [String]
      attr_accessor :ssh_network_name

      # The username to be used when loging in to the vm via ssh
      #
      # @return [String]
      attr_accessor :ssh_user

      # Paramters for Static NAT
      #
      # @return [String]
      attr_accessor :static_nat

      # Template uuid to use for the instance
      #
      # @return [String]
      attr_accessor :template_id

      # Template name to use for the instance
      #
      # @return [String]
      attr_accessor :template_name

      # The user data string
      #
      # @return [String]
      attr_accessor :user_data

      # The username to be used when loging in to the vm
      #
      # @return [String]
      attr_accessor :vm_password

      # The username to be used when loging in to the vm
      #
      # @return [String]
      attr_accessor :vm_user

      # Zone uuid to launch the instance into. If nil, it will
      # launch in default project.
      #
      # @return [String]
      attr_accessor :zone_id

      # Zone name to launch the instance into. If nil, it will
      # launch in default project.
      #
      # @return [String]
      attr_accessor :zone_name

      ### Firewall settings

      # comma separated list of firewall rules
      # (hash with rule parameters)
      #
      # @return [Array]
      attr_accessor :firewall_rules

      # flag to enable/disable automatic open firewall rule
      #
      # @return [Boolean]
      attr_accessor :pf_open_firewall

      ### Port forward settings

      # IP address id to use for port forwarding rule
      #
      # @return [String]
      attr_accessor :pf_ip_address_id

      # IP address to use for port forwarding rule
      #
      # @return [String]
      attr_accessor :pf_ip_address

      # public port to use for port forwarding rule
      #
      # @return [String]
      attr_accessor :pf_public_port

      # public port to use for port forwarding rule
      #
      # @return [String]
      attr_accessor :pf_public_rdp_port

      # private port to use for port forwarding rule
      #
      # @return [String]
      attr_accessor :pf_private_rdp_port

      # public port to use for port forwarding rule
      #
      # @return [Range]
      attr_accessor :pf_public_port_randomrange

      # private port to use for port forwarding rule
      #
      # @return [String]
      attr_accessor :pf_private_port

      # CIDR List string of trusted networks
      #
      # @return [String]
      attr_accessor :pf_trusted_networks

      # comma separated list of port forwarding rules
      # (hash with rule parameters)
      #
      # @return [Array]
      attr_accessor :port_forwarding_rules

      def initialize(domain_specific = false)
        # Initialize groups in bulk, re-use these groups to set defaults in bulk
        INSTANCE_VAR_DEFAULT_NIL.each do |instance_variable|
          instance_variable_set("@#{instance_variable}", UNSET_VALUE)
        end
        # Initialize groups in bulk, re-use these groups to set defaults in bulk
        INSTANCE_VAR_DEFAULT_EMPTY_ARRAY.each do |instance_variable|
          instance_variable_set("@#{instance_variable}", UNSET_VALUE)
        end

        @scheme                     = UNSET_VALUE
        @api_key                    = UNSET_VALUE
        @secret_key                 = UNSET_VALUE
        @instance_ready_timeout     = UNSET_VALUE
        @network_type               = UNSET_VALUE
        @pf_private_rdp_port        = UNSET_VALUE
        @pf_public_port_randomrange = UNSET_VALUE
        @pf_open_firewall           = UNSET_VALUE
        @expunge_on_destroy         = UNSET_VALUE

        # Internal state (prefix with __ so they aren't automatically
        # merged)
        @__compiled_domain_configs = {}
        @__finalized               = false
        @__domain_config           = {}
        @__domain_specific         = domain_specific
      end

      # Allows domain-specific overrides of any of the settings on this
      # configuration object. This allows the user to override things like
      # template and keypair name for domains. Example:
      #
      #     cosmic.domain_config "abcd-ef01-2345-6789" do |domain|
      #       domain.template_id = "1234-5678-90ab-cdef"
      #       domain.keypair_name = "company-east"
      #     end
      #
      # @param [String] domain The Domain name to configure.
      # @param [Hash] attributes Direct attributes to set on the configuration
      #   as a shortcut instead of specifying a full block.
      # @yield [config] Yields a new domain configuration.
      def domain_config(domain, attributes=nil, &block)
        # Append the block to the list of domain configs for that domain.
        # We'll evaluate these upon finalization.
        @__domain_config[domain] ||= []

        # Append a block that sets attributes if we got one
        if attributes
          attr_block = lambda do |config|
            config.set_options(attributes)
          end

          @__domain_config[domain] << attr_block
        end

        # Append a block if we got one
        @__domain_config[domain] << block if block_given?
      end

      #-------------------------------------------------------------------
      # Internal methods.
      #-------------------------------------------------------------------

      def merge(other)
        super.tap do |result|
          # Copy over the domain specific flag. "True" is retained if either
          # has it.
          new_domain_specific = other.instance_variable_get(:@__domain_specific)
          result.instance_variable_set(
              :@__domain_specific, new_domain_specific || @__domain_specific)

          # Go through all the domain configs and prepend ours onto
          # theirs.
          new_domain_config = other.instance_variable_get(:@__domain_config)
          @__domain_config.each do |key, value|
            new_domain_config[key] ||= []
            new_domain_config[key] = value + new_domain_config[key]
          end

          # Set it
          result.instance_variable_set(:@__domain_config, new_domain_config)

          # Merge in the tags
          result.tags.merge!(self.tags)
          result.tags.merge!(other.tags)
        end
      end

      def finalize!
        INSTANCE_VAR_DEFAULT_NIL.each do |instance_variable|
          # ... must be nil, since we can't default that
          instance_variable_set("@#{instance_variable}", nil) if
              instance_variable_get("@#{instance_variable}") == UNSET_VALUE
        end

        INSTANCE_VAR_DEFAULT_EMPTY_ARRAY.each do |instance_variable|
          # ... must be empty array
          instance_variable_set("@#{instance_variable}", []) if
              instance_variable_get("@#{instance_variable}") == UNSET_VALUE
        end

        # We default the scheme to whatever the user has specifid in the .fog file
        # *OR* whatever is default for the provider in the fog library
        @scheme                 = nil if @scheme == UNSET_VALUE

        # Try to get access keys from environment variables, they will
        # default to nil if the environment variables are not present
        @api_key                = ENV['COSMIC_API_KEY'] if @api_key == UNSET_VALUE
        @secret_key             = ENV['COSMIC_SECRET_KEY'] if @secret_key == UNSET_VALUE

        # Set the default timeout for waiting for an instance to be ready
        @instance_ready_timeout = 120 if @instance_ready_timeout == UNSET_VALUE

        # NetworkType is 'Advanced' by default
        @network_type           = "Advanced" if @network_type == UNSET_VALUE

        # Private rdp port defaults to 3389
        @pf_private_rdp_port     = 3389 if @pf_private_rdp_port == UNSET_VALUE

        # Public port random-range, default to rfc6335 'Dynamic Ports'; "(never assigned)"
        @pf_public_port_randomrange = {:start=>49152, :end=>65535} if @pf_public_port_randomrange == UNSET_VALUE

        # Open firewall is true by default (for backwards compatibility)
        @pf_open_firewall       = true if @pf_open_firewall == UNSET_VALUE

        # expunge on destroy is nil by default
        @expunge_on_destroy     = false if @expunge_on_destroy == UNSET_VALUE

        # Compile our domain specific configurations only within
        # NON-DOMAIN-SPECIFIC configurations.
        unless @__domain_specific
          @__domain_config.each do |domain, blocks|
            config = self.class.new(true).merge(self)

            # Execute the configuration for each block
            blocks.each { |b| b.call(config) }

            # The domain name of the configuration always equals the domain config name:
            config.domain = domain

            # Finalize the configuration
            config.finalize!

            # Store it for retrieval
            @__compiled_domain_configs[domain] = config
          end
        end

        # Mark that we finalized
        @__finalized = true
      end

      def validate(machine)
        errors = []

        if @domain
          # Get the configuration for the domain we're using and validate only that domain.
          config = get_domain_config(@domain)

          unless config.use_fog_profile
            errors << I18n.t("vagrant_cosmic.config.api_key_required") if \
               config.access_key_id.nil?
            errors << I18n.t("vagrant_cosmic.config.secret_key_required") if \
               config.secret_access_key.nil?
          end
        end

        {"Cosmic Provider" => errors}
      end

      # This gets the configuration for a specific domain. It shouldn't
      # be called by the general public and is only used internally.
      def get_domain_config(name)
        raise 'Configuration must be finalized before calling this method.' unless @__finalized

        # Return the compiled domain config
        @__compiled_domain_configs[name] || self
      end
    end
  end
end
