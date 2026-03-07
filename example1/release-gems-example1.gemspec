require_relative "lib/example1/version"

Gem::Specification.new do |spec|
  spec.name = "release-gems-example1"
  spec.version = Example1::VERSION
  spec.authors = ["Kasumi Hanazuki"]
  spec.email = ["kasumi@rollingapple.net"]

  spec.summary = "Working example of release-gems action"
  spec.description = "release-gems action automates gem release workflow: build, attestation and publish"
  spec.homepage = "https://github.com/release-gems/example"
  spec.license = "CC0-1.0"
  spec.required_ruby_version = ">= 3.2.0"
  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
end
