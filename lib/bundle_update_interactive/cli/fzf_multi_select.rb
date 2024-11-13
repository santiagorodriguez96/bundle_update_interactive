# frozen_string_literal: true

class BundleUpdateInteractive::CLI
  class FzfMultiSelect
    include BundleUpdateInteractive::StringHelper

    def self.prompt_for_gems_to_update(outdated_gems, withheld_gems, legend:)
      chosen = new(legend: legend, outdated_gems: outdated_gems, withheld_gems: withheld_gems).prompt
      outdated_gems.slice(*chosen)
    end

    def initialize(legend:, outdated_gems:, withheld_gems:)
      @legend = legend
      @outdated_gems = outdated_gems
      @withheld_gems= withheld_gems
    end

    def prompt
      choices = outdated_gems_table.gem_names.each_with_object([]) do |name, memo|
        memo << outdated_gems_table.render_gem(name)
      end

      %x{echo '#{choices.join('\n')}' | fzf -m --ansi --layout=reverse --header=$'#{header}' --info=inline --header-first --color=header:#A8B2B1 | awk '{ print $1 }' }.split(/\n/)
    end

    private

    attr_reader :outdated_gems, :withheld_gems, :legend

    def outdated_gems_table
      @outdated_gems_table ||= Table.updatable(outdated_gems)
    end

    def withheld_gems_table
      @withheld_gems_table ||= Table.withheld(withheld_gems)
    end

    def title
      "#{pluralize(outdated_gems.length, 'gem')} can be updated."
    end

    def withheld_gems_header
      return if withheld_gems.empty?

      "The following gems are being held back and cannot be updated.\n" +
      withheld_gems_table.render
    end

    def header
      [
        legend,
        withheld_gems_header ? withheld_gems_header + '\n' : nil,
        title,
        outdated_gems_table.render_header
      ].compact.join('\n')
    end
  end
end
