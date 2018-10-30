
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "abr/version"

Gem::Specification.new do |spec|
  spec.name          = "abr"
  spec.version       = Abr::VERSION
  spec.authors       = ["nyaahara"]
  spec.email         = ["d.niihara@gmail.com"]

  spec.summary       = %q{multiple request ab(apache bench)}
  spec.homepage      = "https://github.com/nyaahara/abr"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "thor"
  spec.add_dependency "activemodel"
end
