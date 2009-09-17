Gem::Specification.new do |s|
  s.name = %q{zip_codes}
  s.version = "0.5.0"
  s.author = 'Matt Lightner"
  s.default_executable = %q{zip_codes}
  s.description = %q{A library for looking up zip codes and their associated info.}
  s.email = %q{mlightner@gmail.com}
  s.executables = ["zip_codes"]
  s.files = _____GEMFILES____,
  s.has_rdoc = false
  s.homepage = %q{http://github.com/mlightner/zip_codes}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "zip_codes", "--main"]
  s.require_paths = ["lib"]
  s.summary = %q{A library for looking up zip codes and their associated info.}

  s.add_dependency('sqlite3')
end
