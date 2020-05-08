begin
  require 'hirb'
rescue LoadError
end

if defined? Hirb
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  module Hirb
    IGNORE = [:created_at, :updated_at, :profimg, :adimg, :reset_password_token, :reset_password_sent_at, :remember_created_at, :encrypted_password]
  end

  module Hirb::Views::Rails #:nodoc:
    alias :_original_get_active_record_fields :get_active_record_fields
    def get_active_record_fields(obj)
      _original_get_active_record_fields(obj).select {|x| !Hirb::IGNORE.include?(x) }
    end
  end

  Hirb.enable
end