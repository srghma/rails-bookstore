module CallerAttachable
  extend ActiveSupport::Concern

  included do
    def attach(caller)
      @caller = caller
      self
    end

    def method_missing(method_name, *args, &block)
      if @caller&.respond_to?(method_name, true)
        @caller.send(method_name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      @caller&.respond_to?(method_name, include_private) || super
    end
  end
end
