require 'fv/version'
require 'fv/v'
require 'fv/parser'

module Fv
  def self.parse(version)
    Parser.parse(version)
  end
end
