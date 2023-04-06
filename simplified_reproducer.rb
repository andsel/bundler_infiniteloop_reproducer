# encoding: utf-8

# Script to test Bundler leak
# 
# Use a JRuby 9.4.2.0 version which bundles Bundler 2.4.10
#
# ruby -J-Xmx2g -J-Djruby.compile.mode=FORCE -J-Djruby.compile.invokedynamic=true simplified_reproducer.rb

require "bundler"

cwd = ::File.expand_path(::File.join(__FILE__, ".."))
puts "current working dir: #{cwd}"

lockfile = Pathname.new(::File.join(cwd, "lockfiles", "Gemfile.lock"))
puts "lock_file is: #{lockfile}"

gemfile = Pathname.new("whatever unused")

logstash_core_path = Bundler::Source::Path.new({"gemfile"=>gemfile, "path"=>Pathname.new("./logstash-core"), "root_path"=>Pathname.new(cwd), "gemspec"=>nil})
logstash_core_plugin_api_path = Bundler::Source::Path.new({"gemfile"=>gemfile, "path"=>Pathname.new("./logstash-core-plugin-api"), "root_path"=>Pathname.new(cwd), "gemspec"=>nil})

sources = Bundler::SourceList.new()
sources.add_global_rubygems_remote("https://rubygems.org")
sources.add_path_source({"gemfile"=>gemfile, "path"=>Pathname.new("./logstash-core"), "root_path"=>Pathname.new(cwd), "gemspec"=>nil})
sources.add_path_source({"gemfile"=>gemfile, "path"=>Pathname.new("./logstash-core-plugin-api"), "root_path"=>Pathname.new(cwd), "gemspec"=>nil})


deps = []
deps << Bundler::Dependency.new("logstash-core", [], {"gemfile"=>gemfile, "path"=>"./logstash-core", "source"=>logstash_core_path, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-core-plugin-api", [], {"gemfile"=>gemfile, "path"=>"./logstash-core-plugin-api", "source"=>logstash_core_plugin_api_path, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("paquet", ["~> 0.2"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("pleaserun", ["~>0.0.28"], {"gemfile"=>gemfile, "require"=>false, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("rake", ["~> 12"], {"gemfile"=>gemfile, "require"=>false, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("ruby-progressbar", ["~> 1"], {"gemfile"=>gemfile, "require"=>false, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-elasticsearch", [">= 11.6.0"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("polyglot", [], {"gemfile"=>gemfile, "require"=>false, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("treetop", [], {"gemfile"=>gemfile, "require"=>false, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("faraday", ["~> 1"], {"gemfile"=>gemfile, "require"=>false, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("childprocess", ["~> 4"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:build], "should_include"=>true})
deps << Bundler::Dependency.new("fpm", ["~> 1", ">= 1.14.1"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:build], "should_include"=>true})
deps << Bundler::Dependency.new("gems", ["~> 1"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:build], "should_include"=>true})
deps << Bundler::Dependency.new("octokit", ["~> 4.25"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:build], "should_include"=>true})
deps << Bundler::Dependency.new("rubyzip", ["~> 1"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:build], "should_include"=>true})
deps << Bundler::Dependency.new("stud", ["~> 0.0.22"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:build], "should_include"=>true})
deps << Bundler::Dependency.new("belzebuth", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("benchmark-ips", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("ci_reporter_rspec", ["~> 1"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("flores", ["~> 0.0.8"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("json-schema", ["~> 2"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-devutils", ["~> 2"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("rack-test", [], {"gemfile"=>gemfile, "require"=>"rack/test", "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("rspec", ["~> 3.5"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("webmock", ["~> 3"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:development], "should_include"=>true})
deps << Bundler::Dependency.new("jar-dependencies", ["= 0.4.1"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("murmurhash3", ["= 0.1.6"], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("thwait", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-avro", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-cef", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-collectd", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-dots", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-edn", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-edn_lines", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-es_bulk", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-fluent", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-graphite", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-json", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-json_lines", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-line", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-msgpack", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-multiline", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-netflow", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-plain", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-codec-rubydebug", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-aggregate", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-anonymize", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-cidr", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-clone", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-csv", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-date", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-de_dot", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-dissect", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-dns", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-drop", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-elasticsearch", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-fingerprint", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-geoip", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-grok", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-http", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-json", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-kv", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-memcached", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-metrics", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-mutate", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-prune", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-ruby", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-sleep", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-split", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-syslog_pri", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-throttle", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-translate", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-truncate", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-urldecode", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-useragent", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-uuid", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-filter-xml", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-azure_event_hubs", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-beats", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-couchdb_changes", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-dead_letter_queue", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-elasticsearch", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-exec", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-file", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-ganglia", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-gelf", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-generator", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-graphite", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-heartbeat", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-http", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-http_poller", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-imap", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-jms", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-pipe", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-redis", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-snmp", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-snmptrap", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-stdin", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-syslog", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-tcp", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-twitter", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-udp", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-unix", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-integration-elastic_enterprise_search", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-integration-jdbc", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-integration-kafka", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-integration-rabbitmq", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-integration-aws", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-csv", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-email", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-file", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-graphite", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-http", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-lumberjack", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-nagios", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-null", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-pipe", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-redis", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-stdout", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-tcp", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-udp", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-output-webhdfs", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})
deps << Bundler::Dependency.new("logstash-input-cloudwatch", [], {"gemfile"=>gemfile, "source"=>nil, "env"=>nil, "platforms"=>[], "group"=>[:default], "should_include"=>true})


definition = Bundler::Definition.new(lockfile, deps, sources, {}, nil, [], [gemfile])

# the following is the incriminated
puts "Before resolve_remotely!"
definition.resolve_remotely!