module Holidays
  module CoreExtensions
    module Date
      def self.included(base)
        base.extend ClassMethods
      end

      # Get holidays on the current date.
      #
      # Returns an array of hashes or nil. See Holidays#between for options
      # and the output format.
      #
      #   Date.civil('2008-01-01').holidays(:ca_)
      #   => [{:name => 'New Year\'s Day',...}]
      #
      # Also available via Holidays#on.
      def holidays(*options)
        Holidays.on(self, options)
      end

      # Check if the current date is a holiday.
      #
      # Returns true or false.
      #
      #   Date.civil('2008-01-01').holiday?(:ca)
      #   => true
      def holiday?(*options)
        holidays = self.holidays(options)
        holidays && !holidays.empty?
      end

      module ClassMethods
        def calculate_mday(year, month, week, wday)
          Holidays::DateCalculatorFactory.day_of_month_calculator.call(year, month, week, wday)
        end
      end
    end
  end
end
