module VagrantPlugins
  module Cosmic
    module Model
      class CosmicResource
        attr_accessor :id, :name, :details
        attr_reader   :kind

        def initialize(id, name, kind)
          raise 'Resource must have a kind' if kind.nil? || kind.empty?
          @id             = id
          @name           = name
          @kind           = kind
        end

        def is_undefined?
          is_id_undefined? and is_name_undefined?
        end

        def is_id_undefined?
          id.nil? || id.empty?
        end

        def is_name_undefined?
          name.nil? || name.empty?
        end

        def to_s
          "#{kind} - #{id || '<unknown id>'}:#{name || '<unknown name>'}"
        end

        def self.create_list(ids, names, kind)
          return create_id_list(ids, kind)     unless ids.empty?
          return create_name_list(names, kind) unless names.empty?
          []
        end

        def self.create_id_list(ids, kind)
          ids.each_with_object([]) do |id, resources|
            resources << CosmicResource.new(id, nil, kind)
          end
        end

        def self.create_name_list(names, kind)
          names.each_with_object([]) do |name, resources|
            resources << CosmicResource.new(nil, name, kind)
          end
        end
      end
    end
  end
end
