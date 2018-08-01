
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "elasticsearch_query/version"

Gem::Specification.new do |spec|
  spec.name          = "elasticsearch_query"
  spec.version       = ElasticsearchQuery::VERSION
  spec.authors       = ["Greg Orlov"]
  spec.email         = ["gaorlov@gmail.com"]

  spec.summary       = "Elasticsearch Query from Rails params"
  spec.description   = "Rails params parser that converts the prams hash into an Elasticsearch query"
  spec.homepage      = "https://github.com/gaorlov/elasticsearch_query"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "simplecov"
end
