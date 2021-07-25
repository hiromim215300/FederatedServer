# -*- encoding: utf-8 -*-
# stub: googleapis-common-protos-types 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "googleapis-common-protos-types".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Google Inc".freeze]
  s.date = "2021-07-07"
  s.description = "Common protocol buffer types used by Google APIs".freeze
  s.email = ["googleapis-packages@google.com".freeze]
  s.homepage = "https://github.com/googleapis/common-protos-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "2.7.6.2".freeze
  s.summary = "Common protobuf types used in Google APIs".freeze

  s.installed_by_version = "2.7.6.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<google-protobuf>.freeze, ["~> 3.14"])
    else
      s.add_dependency(%q<google-protobuf>.freeze, ["~> 3.14"])
    end
  else
    s.add_dependency(%q<google-protobuf>.freeze, ["~> 3.14"])
  end
end
