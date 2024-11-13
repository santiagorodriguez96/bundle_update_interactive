# frozen_string_literal: true

require "bundler/plugin/api"

module BundleUpdateInteractive
  class BundlerPlugin < ::Bundler::Plugin::API
    command('update-interactive', self)
    command('ui', self)

    def exec(command, args)
      BundleUpdateInteractive::CLI.new.run(argv: args)
    end
  end
end

