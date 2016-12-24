module Fv
  class Parser
    PART_REGEXP = /\A([0-9A-Za-z-]+\.)*[0-9A-Za-z-]+\z/

    class << self
      def parse(version)
        return version if version.is_a?(V)

        normalized_version = version.to_s.split('+').first # Remove metadata

        major, minor, patch = normalized_version.split('.', 3)

        major = validate_part major, name: 'major'
        minor = validate_part minor, name: 'minor'
        patch = validate_part patch, name: 'patch', only_integer: false

        V.new(major, minor, patch)
      end

      private
      def validate_part(part, name: nil, only_integer: true, non_negative: true)
        name = name.capitalize
        is_integer = true

        part = begin
          Integer(part)
        rescue ArgumentError => e
          raise unless e.message =~ /invalid value for Integer\(\):/
          raise WrongVersionError, "#{name} version must be integer" if only_integer
          is_integer = false # Allow part to be not an integer
          part
        end

        if only_integer && non_negative && part < 0
          raise WrongVersionError, "#{name} version cannot be negative"
        end

        if !is_integer && part !~ PART_REGEXP
          raise WrongVersionError, "#{name} can contain only ASCII alphanumerics and hyphen"
        end

        part
      end
    end
  end
end
