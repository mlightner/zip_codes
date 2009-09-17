Gem::Specification.new do |s|
	s.name = %q{zip_codes}
	s.version = "0.5.1"
	s.author = "Matt Lightner"
	s.default_executable = %q{zip_codes}
	s.description = %q{A library for looking up zip codes and their associated info.}
	s.email = %q{mlightner@gmail.com}
	s.executables = ["zipfind"]
  s.files = ["./README","./bin","./bin/zipfind","./lib","./lib/zip_code.rb","./zip_codes.gemspec","./data","./data/zip_codes.db","./Rakefile","./zip_codes.rb","./test.rb"]
	s.has_rdoc = false
	s.homepage = %q{http://github.com/mlightner/zip_codes}
	s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "zip_codes", "--main"]
	s.require_paths = ["lib"]
	s.summary = %q{A library for looking up zip codes and their associated info.}

  s.add_dependency(%q<sqlite3-ruby>, [">= 0.0.0"])
end
