module Playwright
  class ChannelOwner
    include Playwright::EventEmitter

    # define accessor for @initializer
    def self.define_initializer_reader(**name_map)
      name_map.each do |method_name, key_name|
        define_method(method_name) { @initializer[key_name] }
      end
    end

    def self.from(channel)
      channel.object
    end

    # @param parent [Playwright::ChannelOwner|Playwright::Connection]
    # @param type [String]
    # @param guid [String]
    # @param initializer [Hash]
    def initialize(parent, type, guid, initializer)
      @objects = {}

      if parent.is_a?(Playwright::ChannelOwner)
        @connection = parent.instance_variable_get(:@connection)
        @connection.send(:update_object_from_channel_owner, guid, self)
        @parent = parent
        @parent.send(:update_object_from_child, guid, self)
      elsif parent.is_a?(Playwright::Connection)
        @connection = parent
        @connection.send(:update_object_from_channel_owner, guid, self)
      else
        raise ArgumentError.new('parent must be an instance of Playwright::ChannelOwner or Playwright::Connection')
      end

      @channel = Playwright::Channel.new(@connection, guid, object: self)
      @type = type
      @guid = guid
      @initializer = initializer
    end

    attr_reader :channel

    def dispose
      # Clean up from parent and connection.
      @parent&.send(:delete_object_from_child, @guid)
      @connection.send(:delete_object_from_channel_owner, @guid)

      # Dispose all children.
      @objects.each_value(&:dispose)
      @objects.clear
    end

    private

    def update_object_from_child(guid, child)
      @objects[guid] = child
    end

    def delete_object_from_child(guid)
      @objects.delete(guid)
    end
  end

  class RootChannelOwner < ChannelOwner
    # @param connection [Playwright::Connection]
    def initialize(connection)
      super(connection, '', '', {})
    end
  end

  # namespace declaration
  module ChannelOwners ; end

  def self.define_channel_owner(class_name, &block)
    klass = Class.new(ChannelOwner)
    klass.class_eval(&block) if block
    ChannelOwners.const_set(class_name, klass)
  end
end

# load subclasses
Dir[File.join(__dir__, 'channel_owners', '*.rb')].each { |f| require f }
