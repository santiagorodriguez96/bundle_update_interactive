# frozen_string_literal: true

require "pastel"
require "bundler/plugin/api"

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

  Bundler::Plugin::API.command('update-interactive', self)
  Bundler::Plugin::API.command('ui', self)
  Bundler::Plugin::API.command('lorem_ipsum', self)

  def exec(command, args)
    CLI.new.run(argv: args)
  end
end
