# frozen_string_literal: true

require "pastel"
require 'bundle_update_interactive/bundler_plugin'

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "cli" => "CLI"
loader.inflector.inflect "http" => "HTTP"
loader.setup

module BundleUpdateInteractive
  class << self
    attr_accessor :pastel
  end

  self.pastel = Pastel.new
end
