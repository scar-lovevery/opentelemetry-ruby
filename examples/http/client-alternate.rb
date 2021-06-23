#!/usr/bin/env ruby
# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0
require 'rubygems'
require 'bundler/setup'
require 'faraday'
# Require otel-ruby
require 'opentelemetry/sdk'
require 'opentelemetry/propagator/xray'
require 'opentelemetry/instrumentation/faraday'

# Export traces to console by default
ENV['OTEL_TRACES_EXPORTER'] ||= 'console'
ENV['OTEL_PROPAGATORS'] ||= 'xray'
ENV['OTEL_LOG_LEVEL'] ||= 'debug'

# Allow setting the host from the ENV
host = ENV.fetch('HTTP_EXAMPLE_HOST', '0.0.0.0')

# configure SDK with defaults
OpenTelemetry::SDK.configure do |c|
  c.use 'OpenTelemetry::Instrumentation::Faraday'
end

connection = Faraday.new("http://#{host}:4567")
url = '/hello'

response = connection.get(url)