require_relative 'lib/linux_stat/version'

Gem::Specification.new do |spec|
  spec.name          = "linux_stat"
  spec.version       = LinuxStat::VERSION
  spec.authors       = ["Sourav Goswami"]
  spec.email         = ["souravgoswami@protonmail.com"]

  spec.summary       = %q{Efficient linux system reporting gem}
  spec.description   = %q{Efficient linux system reporting gem. Linux Only | Efficient | Reliable}
  spec.homepage      = "https://github.com/Souravgoswami/linux_stat/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Souravgoswami/linux_stat"
  spec.metadata["changelog_uri"] = "https://github.com/Souravgoswami/linux_stat/commits/master"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|logo)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
