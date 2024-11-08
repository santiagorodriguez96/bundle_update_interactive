# frozen_string_literal: true

module BundleUpdateInteractive
  class BundlerPlugin < ::Bundler::Plugin::API
    command('update-interactive', self)
    command('ui', self)
    command('lorem_ipsum', self)

    def exec(command, args)
      BundleUpdateInteractive::CLI.new.run(argv: args)
    end
  end
end

