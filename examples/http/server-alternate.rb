#!/usr/bin/env ruby
# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'

require 'faraday'


# Require otel-ruby
require 'opentelemetry/sdk'
require 'opentelemetry/propagator/xray'
require 'opentelemetry/instrumentation/sinatra'
require 'opentelemetry/instrumentation/faraday'

# Export traces to console by default
ENV['OTEL_TRACES_EXPORTER'] ||= 'console'
ENV['OTEL_PROPAGATORS'] ||= 'xray'
ENV['OTEL_LOG_LEVEL'] ||= 'debug'

host = ENV.fetch('HTTP_EXAMPLE_HOST', '0.0.0.0')

OpenTelemetry::SDK.configure do |c|
  c.use 'OpenTelemetry::Instrumentation::Sinatra'
  c.use 'OpenTelemetry::Instrumentation::Faraday'
end

class App < Sinatra::Base
  set :bind, '0.0.0.0'
  #use OpenTelemetryMiddleware

  get '/hello' do
    #connection = Faraday.new("http://0.0.0.0:4567")
    #url = '/world'
    #response = connection.get(url)
    "Hello! #{response}"
  end
  get '/world' do
    'World!'
  end

  run! if app_file == $0
end
