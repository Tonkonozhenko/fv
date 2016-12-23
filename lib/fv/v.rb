module Fv
  class Error < StandardError;
  end
  class WrongVersionError < Error;
  end

  class V
    ##
    # Behaviour
    #
    include Comparable

    ##
    # Attributes
    #
    attr_reader :parts, :major, :minor, :patch

    ##
    # Instance methods
    #
    def initialize(major, minor, patch)
      @major = major
      @minor = minor
      @patch = patch

      @parts = [@major, @minor, @patch]
    end

    def to_s
      parts.join('.')
    end

    def prerelease?
      !patch.is_a?(Integer)
    end

    def <=>(other)
      other = Fv.parse(other) unless other.is_a?(V)

      major_cmp = @major <=> other.major
      return major_cmp unless major_cmp.zero?

      minor_cmp = @minor <=> other.minor
      return minor_cmp unless minor_cmp.zero?

      patch_cmp = @patch <=> other.patch
      return patch_cmp if patch_cmp && !patch_cmp.zero?

      this_pre = prerelease? ? 0 : 1
      other_pre = other.prerelease? ? 0 : 1
      both_prerelease = prerelease? && other.prerelease?
      return this_pre <=> other_pre unless both_prerelease

      prerelease_compare(other)
    end

    private
    def prerelease_compare(other)
      # TODO
    end
  end
end

