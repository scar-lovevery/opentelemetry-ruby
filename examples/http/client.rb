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

# Export traces to console by default
ENV['OTEL_TRACES_EXPORTER'] ||= 'console'
ENV['OTEL_PROPAGATORS'] ||= 'xray'
ENV['OTEL_LOG_LEVEL'] ||= 'debug'

# Allow setting the host from the ENV
host = ENV.fetch('HTTP_EXAMPLE_HOST', '0.0.0.0')

# configure SDK with defaults
OpenTelemetry::SDK.configure

# Configure tracer
tracer = OpenTelemetry.tracer_provider.tracer('faraday', '1.0')

connection = Faraday.new("http://#{host}:4567")
url = '/hello'

# For attribute naming, see:
# https://github.com/open-telemetry/opentelemetry-specification/blob/master/specification/data-semantic-conventions.md#http-client

# Span name should be set to URI path value:
tracer.in_span(
  url,
  attributes: {
    'component' => 'http',
    'http.method' => 'GET',
  },
  kind: :client
) do |span|
  response = connection.get(url) do |request|
    # Inject context into request headers
    # SCAR - DEFINITELY BREAKS IF NOT THIS LINE
    OpenTelemetry.propagation.inject(request.headers)
  end

  span.set_attribute('http.url', response.env.url.to_s)
  span.set_attribute('http.status_code', response.status)
end
