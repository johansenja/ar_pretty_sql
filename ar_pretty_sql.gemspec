# frozen_string_literal: true

require_relative "lib/ar_pretty_sql/version"

Gem::Specification.new do |spec|
  spec.name          = "ar_pretty_sql"
  spec.version       = ArPrettySql::VERSION
  spec.authors       = ["Joseph Johansen"]
  spec.email         = ["joe@stotles.com"]

  spec.summary       = "Debug your active record queries fast"
  spec.description   = "This is a debugging tool to inspect your Active Record queries in a developer-friendly way"
  spec.homepage      = "https://github.com/johansenja/ar_pretty_sql"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rouge", "~> 3.2"
  spec.add_dependency "anbt-sql-formatter", "~> 0.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
