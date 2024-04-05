# coding: utf-8

require_relative "lib/unigo/sender/version"
# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.authors = ["Alexander Tarasov"]
  spec.description = "Based on official UniGo Gem https://gitflic.ru/project/unisender/unigo-ruby"
  spec.metadata = { "github_repo" => "ssh://github.com/tarassov/unigo-sender-simple" }
  spec.homepage = "https://github.com/tarassov/unigo-sender-simple"
  spec.email = "tarassov.al@gmail.com"
  spec.files = %x(git ls-files -z).split("\x0")
  spec.licenses = ["MIT"]
  spec.name = "unigo-sender-simple"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.7"
  spec.summary = "Simple UniGo sender Gem"
  spec.version = Unigo::Sender::VERSION

  spec.add_dependency("faraday", "~> 2.0")
  spec.add_dependency("faraday-mashify", "~> 0.1")
  spec.add_dependency("json", "~> 2.0")
  spec.add_dependency("json-schema", "~> 2.0")
  spec.add_dependency("zeitwerk", "~> 2.6")
end
