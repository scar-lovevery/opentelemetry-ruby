#!/usr/bin/env ruby
# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0
require 'rubygems'
require 'bundler/setup'
require 'faraday'
# Require otel-ruby

# Allow setting the host from the ENV
host = ENV.fetch('HTTP_EXAMPLE_HOST', '0.0.0.0')

connection = Faraday.new("http://#{host}:4567")
url = '/hello'

response = connection.get(url)