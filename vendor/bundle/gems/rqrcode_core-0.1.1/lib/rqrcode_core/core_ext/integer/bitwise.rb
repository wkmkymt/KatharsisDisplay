# frozen_string_literal: true

module RQRCodeCore
  module CoreExtensions #:nodoc: all
    module Integer
      module Bitwise
        def rszf(count)
          # zero fill right shift
          (self >> count) & ((2 ** ((self.size * 8) - count))-1)
        end
      end
    end
  end
end

